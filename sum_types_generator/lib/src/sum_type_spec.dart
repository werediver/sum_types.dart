import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sum_types/sum_types.dart';
import 'package:sum_types_generator/src/templates.dart';

@immutable
class SumTypeSpec {
  const SumTypeSpec({
    @required this.anchorName,
    @required this.ifaceName,
    @required this.recordIfaceName,
    @required this.sumTypeName,
    @required this.cases,
    @required this.noPayloadTypeInstance,
  });

  final String anchorName;
  final String ifaceName;
  final String recordIfaceName;
  final String sumTypeName;
  final Iterable<CaseSpec> cases;
  final String noPayloadTypeInstance;
}

@immutable
class CaseSpec {
  const CaseSpec({
    @required this.name,
    @required this.type,
  });

  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
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
    @required this.name,
    @required this.requiresPayload,
    @required this.isDirectlyRecursive,
  });

  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
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

  String anchorNameToSumTypeName(String anchorName) =>
      undecoratedID(anchorName);

  if (element is ClassElement && element.isMixin) {
    final anchorName = element.name;
    final sumTypeName = anchorNameToSumTypeName(element.name);
    CaseTypeSpec __resolveCaseTypeName(DartType type) => _resolveCaseTypeName(
          declaredCaseType: type,
          sumTypeName: sumTypeName,
          noPayloadTypeName: noPayloadTypeName,
          resolveTypeName: (type) => _resolveTypeName(
            type,
            name: (type) {
              if (type.name == anchorName) {
                return sumTypeName;
              } else if (_isSumTypeAnchor(type)) {
                return anchorNameToSumTypeName(type.name);
              }
              return type.name;
            },
          ),
        );

    return SumTypeSpec(
      anchorName: anchorName,
      ifaceName: "${anchorName}Base",
      recordIfaceName: "${sumTypeName}RecordBase",
      sumTypeName: sumTypeName,
      cases: annotation.objectValue.getField("cases").toListValue().map(
            (item) => makeCaseSpec(
              item,
              resolveTypeName: __resolveCaseTypeName,
            ),
          ),
      noPayloadTypeInstance: "const $noPayloadTypeName()",
    );
  }
  throw Exception("A sum-type anchor must be a mix-in");
}

CaseSpec makeCaseSpec(
  DartObject obj, {
  @required CaseTypeSpec Function(DartType) resolveTypeName,
}) {
  final declaredCaseType = obj.type.typeArguments.first;
  final typeName = resolveTypeName(declaredCaseType);
  return CaseSpec(
    name: obj.getField("name").toStringValue() ??
        _defaultCaseName(declaredCaseType.name),
    type: typeName,
  );
}

String _defaultCaseName(String caseTypeName) =>
    lowercaseLeadingID(undecoratedID(caseTypeName));

CaseTypeSpec _resolveCaseTypeName({
  @required DartType declaredCaseType,
  @required String sumTypeName,
  @required String noPayloadTypeName,
  @required String Function(DartType) resolveTypeName,
}) {
  String resolvedTypeName;
  bool requiresPayload;

  if (declaredCaseType.isVoid) {
    resolvedTypeName = noPayloadTypeName;
    requiresPayload = false;
  } else {
    resolvedTypeName = resolveTypeName(declaredCaseType);
    requiresPayload = true;
  }
  return CaseTypeSpec(
    name: resolvedTypeName,
    requiresPayload: requiresPayload,
    isDirectlyRecursive: resolvedTypeName == sumTypeName,
  );
}

String _resolveTypeName(
  DartType type, {
  @required String Function(DartType) name,
}) {
  String _resolveTypeName(DartType type) => [
        name(type),
        if (type is ParameterizedType && type.typeArguments.isNotEmpty) ...[
          "<",
          type.typeArguments.map(_resolveTypeName).join(", "),
          ">",
        ]
      ].join();
  return _resolveTypeName(type);
}

bool _isSumTypeAnchor(DartType type) => type.element.metadata.any((annotation) {
      final annotationElement = annotation.element;
      if (annotationElement is ConstructorElement) {
        final annotationClassElement = annotationElement.enclosingElement;
        return annotationClassElement.name == "$SumType";
      }
      return false;
    });
