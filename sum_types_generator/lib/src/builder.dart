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
  return classDecl(
    name: spec.sumTypeName,
    mixins: [spec.anchorName],
    body: [
      // Case constructors
      for (final caseSpec in spec.cases)
        constructor(
          isConst: true,
          type: spec.sumTypeName,
          name: caseSpec.name,
          posArgs: [
            if (caseSpec.requiresPayload)
              arg(
                type: caseSpec.typeName,
                name: caseSpec.name,
              ),
          ],
          initializers: [
            [
              "this._unsafe(",
              caseSpec.name,
              ":",
              if (caseSpec.requiresPayload) caseSpec.name else "const Unit()",
              ")",
            ].join(),
          ],
        ),
      // The unsafe constructor
      constructor(
        isConst: true,
        type: spec.sumTypeName,
        name: "_unsafe",
        namedArgs: [
          for (final caseSpec in spec.cases) arg(name: "this.${caseSpec.name}"),
        ],
        initializers: [
          [
            "assert(",
            cartprod2(
              spec.cases,
              spec.cases,
              tuple: (expected, other) => other == expected ? "${expected.name} != null" : "${other.name} == null",
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
                if (caseSpec.requiresPayload) caseSpec.typeName,
                ")",
              ].join(),
              name: caseSpec.name,
            ),
        ],
        body: [
          for (final caseSpec in spec.cases) ...[
            "if (this.${caseSpec.name} != null) {",
            "return ${caseSpec.name}(",
            if (caseSpec.requiresPayload) "this.${caseSpec.name}",
            "); } else"
          ],
          "{ throw StateError(\"an instance of \$${spec.sumTypeName} has no case selected\"); }",
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
                if (caseSpec.requiresPayload) caseSpec.typeName,
                ")",
              ].join(),
              name: caseSpec.name,
            ),
          arg(
            type: "@required T Function()",
            name: "otherwise",
          ),
        ],
        body: [
          "T _otherwise(Object _) => otherwise();",
          "return iswitch(",
          ...spec.cases.map((c) => "${c.name}: ${c.name} ?? _otherwise,"),
          ");",
        ],
      ),
      // Equality test
      "@override",
      function(
        type: "bool",
        name: "operator ==",
        posArgs: [arg(type: "dynamic", name: "other")],
        body: [
          "return",
          [
            "other.runtimeType == runtimeType",
            for (final caseSpec in spec.cases) "other.${caseSpec.name} == ${caseSpec.name}"
          ].join("&&"),
          ";",
        ],
      ),
      // Hash function
      "@override",
      getter(
        type: "int",
        name: "hashCode",
        body: [
          "var result = 17;",
          for (final caseSpec in spec.cases) "result = 37 * result + ${caseSpec.name}.hashCode;",
          "return result;",
        ],
      ),
      // To string conversion
      "@override",
      function(
        type: "String",
        name: "toString",
        body: [
          "final ctor = iswitch(",
          ...spec.cases
              .map((caseSpec) => [
                    "${caseSpec.name}: ",
                    if (caseSpec.requiresPayload)
                      "(value) => \"${caseSpec.name}(\$value)\""
                    else
                      "() => \"${caseSpec.name}()\"",
                  ].join())
              .map(appendComma),
          ");",
          "return \"\$${spec.sumTypeName}.\$ctor\";",
        ],
      ),
      // Fields
      for (final caseSpec in spec.cases)
        finalField(
          type: caseSpec.requiresPayload ? caseSpec.typeName : "Unit",
          name: caseSpec.name,
        ),
    ],
  );
}
