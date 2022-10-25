import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sum_types/sum_types.dart';
import 'package:sum_types_generator/src/common_spec.dart';

@immutable
class SumTypeSpec {
  const SumTypeSpec({
    required this.sumTypeName,
    required this.sumTypeBaseName,
    required this.recordIfaceName,
    required this.typeParams,
    required this.cases,
    required this.noPayloadTypeInstance,
  });

  final String sumTypeName;
  final String sumTypeBaseName;
  final String recordIfaceName;
  final Iterable<TypeParamSpec> typeParams;
  final Iterable<CaseSpec> cases;
  final String noPayloadTypeInstance;
}

@immutable
class CaseSpec {
  const CaseSpec({
    required this.name,
    required this.type,
  });

  @override
  bool operator ==(Object other) =>
      other.runtimeType == runtimeType &&
      other is CaseSpec &&
      other.name == name &&
      other.type == type;

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + name.hashCode;
    result = 37 * result + type.hashCode;
    return result;
  }

  final String name;
  final CaseTypeSpec type;
}

@immutable
class CaseTypeSpec {
  const CaseTypeSpec({
    required this.name,
    required this.requiresPayload,
    required this.isDirectlyRecursive,
  });

  @override
  bool operator ==(Object other) =>
      other.runtimeType == runtimeType &&
      other is CaseTypeSpec &&
      other.name == name &&
      other.requiresPayload == requiresPayload &&
      other.isDirectlyRecursive == isDirectlyRecursive;

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + name.hashCode;
    result = 37 * result + requiresPayload.hashCode;
    result = 37 * result + isDirectlyRecursive.hashCode;
    return result;
  }

  final String name;
  final bool requiresPayload;
  final bool isDirectlyRecursive;
}

SumTypeSpec makeSumTypeSpec(Element element, ConstantReader annotation) {
  final noPayloadTypeName = "$Unit";
  final noPayloadTypeInstance = "const $noPayloadTypeName()";

  if (element is ClassElement && !element.isMixin && !element.isEnum) {
    final sumTypeName = element.name;
    CaseTypeSpec __makeCaseTypeSpec(DartType? type) => _makeCaseTypeSpec(
          declaredCaseType: type,
          sumTypeName: sumTypeName,
          noPayloadTypeName: noPayloadTypeName,
        );
    CaseSpec __makeCaseSpec(ConstructorElement ctor) =>
        _makeCaseSpec(ctor, makeCaseTypeSpec: __makeCaseTypeSpec);

    return SumTypeSpec(
      sumTypeName: sumTypeName,
      sumTypeBaseName: "_\$$sumTypeName",
      recordIfaceName: "${sumTypeName}RecordBase",
      typeParams: element.typeParameters.map(
        (e) => TypeParamSpec(
          name: e.name,
          bound: e.bound?.element?.name,
        ),
      ),
      cases: element.constructors
          .where((ctor) => ctor.name.isNotEmpty && !ctor.isFactory)
          .map(__makeCaseSpec),
      noPayloadTypeInstance: noPayloadTypeInstance,
    );
  }
  throw Exception("A sum-type anchor must be a class");
}

CaseSpec _makeCaseSpec(
  ConstructorElement ctor, {
  required CaseTypeSpec Function(DartType?) makeCaseTypeSpec,
}) {
  if (ctor.parameters.length <= 1) {
    final caseType =
        ctor.parameters.isNotEmpty ? ctor.parameters.single.type : null;
    return CaseSpec(name: ctor.name, type: makeCaseTypeSpec(caseType));
  }
  throw Exception(
    "Case-constructor ${ctor.name} shall have at most one parameter",
  );
}

CaseTypeSpec _makeCaseTypeSpec({
  DartType? declaredCaseType,
  required String sumTypeName,
  required String noPayloadTypeName,
}) {
  if (declaredCaseType != null) {
    final resolvedTypeName = _resolveTypeName(declaredCaseType);
    return CaseTypeSpec(
      name: resolvedTypeName,
      requiresPayload: true,
      isDirectlyRecursive: resolvedTypeName == sumTypeName,
    );
  } else {
    return CaseTypeSpec(
      name: noPayloadTypeName,
      requiresPayload: false,
      isDirectlyRecursive: false,
    );
  }
}

String _resolveTypeName(
  DartType type, {
  String? Function(DartType)? name,
}) {
  final _name = name ?? (type) => type.element?.name;

  String _resolveTypeName(DartType type) => [
        _name(type),
        if (type is ParameterizedType && type.typeArguments.isNotEmpty) ...[
          "<",
          type.typeArguments.map(_resolveTypeName).join(", "),
          ">",
        ]
      ].join();

  return _resolveTypeName(type);
}
