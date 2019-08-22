import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart' show Builder, BuilderOptions;
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart' show SharedPartBuilder, GeneratorForAnnotation;
import 'package:source_gen/src/constants/reader.dart';
import 'package:sum_types/sum_types.dart' as annotations show SumType;
import 'package:sum_types_generator/src/sum_type_spec.dart';
import 'package:sum_types_generator/src/templates.dart';

Builder sumTypesBuilder(BuilderOptions options) => SharedPartBuilder([SumTypesGenerator()], 'sum_types');

class SumTypesGenerator extends GeneratorForAnnotation<annotations.SumType> {
  @override
  Object generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) =>
      generateSumType(makeSumTypeSpec(element, annotation));
}

String generateSumType(SumTypeSpec spec) {
  final sumTypeName = undecoratedID(spec.anchorName);
  return classDecl(
    name: sumTypeName,
    mixins: [spec.anchorName],
    body: [
      // Case constructors
      for (final caseSpec in spec.cases)
        constructor(
          isConst: true,
          type: sumTypeName,
          name: caseName(caseSpec),
          posArgs: [
            if (caseRequiresPayload(caseSpec))
              arg(
                type: caseTypeName(caseSpec),
                name: caseName(caseSpec),
              ),
          ],
          initializers: [
            [
              "this._unsafe(",
              caseName(caseSpec),
              ":",
              if (caseRequiresPayload(caseSpec)) caseName(caseSpec) else "const Unit()",
              ")"
            ].join(),
          ],
        ),
      // The unsafe constructor
      constructor(
        isConst: true,
        type: sumTypeName,
        name: "_unsafe",
        namedArgs: [
          for (final caseSpec in spec.cases) arg(name: "this.${caseName(caseSpec)}"),
        ],
        initializers: [
          [
            "assert(",
            cartprod2(
              spec.cases,
              spec.cases,
              tuple: (expected, other) =>
                  other == expected ? "${caseName(expected)} != null" : "${caseName(other)} == null",
              row: (tuples) => tuples.join("&&"),
              result: (rows) => rows.join("||"),
            ),
            ")",
          ].join(),
        ],
      ),
      // The exhaustive in-line switch
      function(
        type: "T",
        name: "iswitch<T>",
        namedArgs: [
          for (final caseSpec in spec.cases)
            arg(
              type: [
                "@required T Function(",
                if (caseRequiresPayload(caseSpec)) caseTypeName(caseSpec),
                ")",
              ].join(),
              name: caseName(caseSpec),
            ),
        ],
        body: [
          for (final caseSpec in spec.cases) ...[
            "if (this.${caseName(caseSpec)} != null) {",
            "return ${caseName(caseSpec)}(",
            if (caseRequiresPayload(caseSpec)) "this.${caseName(caseSpec)}",
            "); } else"
          ],
          "{ throw StateError(\"an instance of \$${sumTypeName} has no case selected\"); }",
        ],
      ),
      // The inexhaustive in-line switch
      function(
        type: "T",
        name: "iswitcho<T>",
        namedArgs: [
          for (final caseSpec in spec.cases)
            arg(
              type: [
                "T Function(",
                if (caseRequiresPayload(caseSpec)) caseTypeName(caseSpec),
                ")",
              ].join(),
              name: caseName(caseSpec),
            ),
          arg(
            type: "@required T Function()",
            name: "otherwise",
          ),
        ],
        body: [
          "T _otherwise(Object _) => otherwise();",
          "return iswitch(",
          ...spec.cases.map(caseName).map((c) => "$c: $c ?? _otherwise,"),
          ");",
        ],
      ),
      // Fields
      for (final caseSpec in spec.cases)
        finalField(
          type: caseRequiresPayload(caseSpec) ? caseTypeName(caseSpec) : "Unit",
          name: caseName(caseSpec),
        ),
    ],
  );
}
