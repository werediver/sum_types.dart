import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sum_types/sum_types.dart' as annotations show SumType;
import 'package:sum_types_generator/src/common_spec.dart';
import 'package:sum_types_generator/src/sum_type_spec.dart';
import 'package:sum_types_generator/src/templates.dart';

Builder sumTypesBuilder(BuilderOptions options) =>
    SharedPartBuilder([SumTypesGenerator()], 'sum_types');

class SumTypesGenerator extends GeneratorForAnnotation<annotations.SumType> {
  @override
  Object generateForAnnotatedElement(
          Element element, ConstantReader annotation, BuildStep buildStep) =>
      generateSumType(makeSumTypeSpec(element, annotation));
}

String generateSumType(SumTypeSpec spec) => [
      // The sum-type base class
      classDecl(
        abstract: true,
        name: spec.sumTypeBaseName,
        typeParams: spec.typeParams,
        body: [
          // The unsafe constructor
          constructor(
            isConst: true,
            type: spec.sumTypeBaseName,
            namedParams: [
              for (final caseSpec in spec.cases)
                param(name: "this.${caseSpec.name}"),
            ],
            initializers: [
              "assert(${invariant(spec.cases)})",
            ],
          ),
          loadFromRecord(spec),
          dumpToRecord(spec),
          exhaustiveSwitch(spec: spec, implement: true),
          inexhaustiveSwitch(spec: spec, implement: true),
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
                for (final caseSpec in spec.cases)
                  "other.${caseSpec.name} == ${caseSpec.name}"
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
              for (final caseSpec in spec.cases)
                "result = 37 * result + ${caseSpec.name}.hashCode;",
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
                        if (caseSpec.type.requiresPayload)
                          "(value) => \"${caseSpec.name}(\$value)\""
                        else
                          "() => \"${caseSpec.name}()\"",
                      ].join())
                  .map(appendComma),
              ");",
              "return \"\$runtimeType.\$ctor\";",
            ],
          ),
          // Fields
          for (final caseSpec in spec.cases) ...[
            "@protected",
            finalField(
              type: caseSpec.type.name,
              name: caseSpec.name,
            ),
          ],
        ],
      ),
      // The read-only record-type interface
      classDecl(
        abstract: true,
        name: spec.recordIfaceName,
        typeParams: [
          const TypeParamSpec(name: "Self"),
          ...spec.typeParams,
        ],
        body: [
          for (final caseSpec in spec.cases)
            getter(
              type: caseSpec.type.isDirectlyRecursive
                  ? "Self"
                  : caseSpec.type.name,
              name: caseSpec.name,
            ),
        ],
      ),
    ].join(" ");

String invariant(Iterable<CaseSpec> cases, {String obj = ""}) => cartprod2(
      cases,
      cases,
      tuple: (CaseSpec expected, CaseSpec other) => other == expected
          ? "${obj.isNotEmpty ? "$obj." : ""}${expected.name} != null"
          : "${obj.isNotEmpty ? "$obj." : ""}${other.name} == null",
      row: (tuples) => tuples.join("&&"),
      result: (rows) => rows.join("||"),
    );

String loadFromRecord(SumTypeSpec spec) => function(
      isStatic: true,
      type: [
        spec.sumTypeName,
        specialize(spec.typeParams.map((typeParam) => typeParam.name)),
      ].join(),
      name: "load",
      typeParams: [
        TypeParamSpec(
          name: "\$T",
          bound: [
            spec.recordIfaceName,
            specialize([
              "\$T",
              ...spec.typeParams.map((typeParam) => typeParam.name),
            ]),
          ].join(),
        ),
        ...spec.typeParams,
      ],
      posParams: [param(type: "\$T", name: "rec")],
      body: [
        spec.cases.map((expected) {
          final cond = spec.cases
              .map((other) => other == expected
                  ? "rec.${expected.name} != null"
                  : "rec.${other.name} == null")
              .join("&&");
          return [
            "if ($cond) {",
            "return ",
            if (!expected.type.requiresPayload && spec.typeParams.isEmpty)
              "const ",
            "${spec.sumTypeName}${specialize(spec.typeParams.map((param) => param.name))}.${expected.name}(",
            if (expected.type.isDirectlyRecursive)
              "load(rec.${expected.name})"
            else if (expected.type.requiresPayload)
              "rec.${expected.name}",
            ");",
            "} else ",
          ].join();
        }).join(),
        "{ throw Exception(\"Cannot select a \$${spec.sumTypeName} case given \$rec\"); }",
      ],
    );

String dumpToRecord(SumTypeSpec spec) => function(
      type: "\$T",
      name: "dump",
      typeParams: [const TypeParamSpec(name: "\$T")],
      posParams: [
        param(
          type: [
            "\$T Function({",
            ...spec.cases
                .map(
                  (c) => param(
                    type: c.type.isDirectlyRecursive ? "\$T" : c.type.name,
                    name: c.name,
                  ),
                )
                .map(appendComma),
            "})",
          ].join(),
          name: "make",
        ),
      ],
      body: [
        "return iswitch(",
        ...spec.cases
            .map(
              (c) => [
                "${c.name}: (",
                if (c.type.requiresPayload) c.name,
                ") => make(${c.name}:",
                if (c.type.isDirectlyRecursive)
                  "${c.name}.dump(make)"
                else if (c.type.requiresPayload)
                  c.name
                else
                  spec.noPayloadTypeInstance,
                ")",
              ].join(),
            )
            .map(appendComma),
        ");",
      ],
    );

String exhaustiveSwitch({
  @required SumTypeSpec spec,
  @required bool implement,
}) =>
    function(
      type: "\$T",
      name: "iswitch",
      typeParams: [const TypeParamSpec(name: "\$T")],
      namedParams: [
        for (final caseSpec in spec.cases)
          param(
            type: [
              "@required \$T Function(",
              if (caseSpec.type.requiresPayload) caseSpec.type.name,
              ")",
            ].join(),
            name: caseSpec.name,
          ),
      ],
      body: implement
          ? [
              for (final caseSpec in spec.cases) ...[
                "if (this.${caseSpec.name} != null) {",
                "return ${caseSpec.name}(",
                if (caseSpec.type.requiresPayload) "this.${caseSpec.name}",
                "); } else"
              ],
              "{ throw StateError(\"an instance of \$${spec.sumTypeName} has no case selected\"); }",
            ]
          : null,
    );

String inexhaustiveSwitch({
  @required SumTypeSpec spec,
  @required bool implement,
}) =>
    function(
      type: "\$T",
      name: "iswitcho",
      typeParams: [const TypeParamSpec(name: "\$T")],
      namedParams: [
        for (final caseSpec in spec.cases)
          param(
            type: [
              "\$T Function(",
              if (caseSpec.type.requiresPayload) caseSpec.type.name,
              ")",
            ].join(),
            name: caseSpec.name,
          ),
        param(
          type: "@required \$T Function()",
          name: "otherwise",
        ),
      ],
      body: implement
          ? [
              "\$T _otherwise(Object _) => otherwise();",
              "return iswitch(",
              ...spec.cases.map((c) =>
                  "${c.name}: ${c.name} ?? ${c.type.requiresPayload ? "_otherwise" : "otherwise"},"),
              ");",
            ]
          : null,
    );
