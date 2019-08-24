import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sum_types/sum_types.dart' as annotations show SumType;
import 'package:sum_types_generator/src/sum_type_spec.dart';
import 'package:sum_types_generator/src/templates.dart';

Builder sumTypesBuilder(BuilderOptions options) => SharedPartBuilder([SumTypesGenerator()], 'sum_types');

class SumTypesGenerator extends GeneratorForAnnotation<annotations.SumType> {
  @override
  Object generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) =>
      generateSumType(makeSumTypeSpec(element, annotation));
}

String generateSumType(SumTypeSpec spec) => classDecl(
      name: spec.sumTypeName,
      mixins: [spec.anchorName],
      body: [
        // Case constructors
        for (final caseSpec in spec.cases)
          constructor(
            isConst: true,
            type: spec.sumTypeName,
            name: caseSpec.name,
            posParams: [
              if (caseSpec.requiresPayload)
                param(
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
          namedParams: [
            for (final caseSpec in spec.cases) param(name: "this.${caseSpec.name}"),
          ],
          initializers: [
            [
              "assert(",
              cartprod2(
                spec.cases,
                spec.cases,
                tuple: (CaseSpec expected, CaseSpec other) =>
                    other == expected ? "${expected.name} != null" : "${other.name} == null",
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
          namedParams: [
            for (final caseSpec in spec.cases)
              param(
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
          namedParams: [
            for (final caseSpec in spec.cases)
              param(
                type: [
                  "T Function(",
                  if (caseSpec.requiresPayload) caseSpec.typeName,
                  ")",
                ].join(),
                name: caseSpec.name,
              ),
            param(
              type: "@required T Function()",
              name: "otherwise",
            ),
          ],
          body: [
            "T _otherwise(Object _) => otherwise();",
            "return iswitch(",
            ...spec.cases.map((c) => "${c.name}: ${c.name} ?? ${c.requiresPayload ? "_otherwise" : "otherwise"},"),
            ");",
          ],
        ),
        // Equality test
        "@override",
        function(
          type: "bool",
          name: "operator ==",
          posParams: [param(type: "dynamic", name: "other")],
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
        for (final caseSpec in spec.cases) ...[
          "@protected",
          finalField(
            type: caseSpec.requiresPayload ? caseSpec.typeName : "Unit",
            name: caseSpec.name,
          ),
        ],
      ],
    );
