import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sum_types_generator/src/templates.dart';

@immutable
class SumTypeSpec {
  const SumTypeSpec({
    @required this.anchorName,
    @required this.ifaceName,
    @required this.sumTypeName,
    @required this.cases,
  })  : assert(anchorName != null),
        assert(sumTypeName != null),
        assert(cases != null);

  final String anchorName;
  final String ifaceName;
  final String sumTypeName;
  final Iterable<CaseSpec> cases;
}

@immutable
class CaseSpec {
  const CaseSpec({
    @required this.name,
    @required this.typeName,
    @required this.requiresPayload,
  })  : assert(name != null),
        assert(typeName != null),
        assert(requiresPayload != null);

  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      other.name == name &&
      other.typeName == typeName &&
      other.requiresPayload == requiresPayload;

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + name.hashCode;
    result = 37 * result + typeName.hashCode;
    result = 37 * result + requiresPayload.hashCode;
    return result;
  }

  final String name;
  final String typeName;
  final bool requiresPayload;
}

SumTypeSpec makeSumTypeSpec(Element element, ConstantReader annotation) {
  if (element is ClassElement && element.isMixin) {
    final anchorName = element.name;
    final sumTypeName = undecoratedID(element.name);

    return SumTypeSpec(
      anchorName: anchorName,
      ifaceName: "${anchorName}Base",
      sumTypeName: sumTypeName,
      cases: annotation.objectValue.getField("cases").toListValue().map(
            (item) => makeCaseSpec(
              item,
              typeName: (type) => _typeName(
                type,
                resolve: (name) => name == anchorName ? sumTypeName : name,
              ),
            ),
          ),
    );
  }
  throw Exception("A sum-type anchor must be a mix-in");
}

CaseSpec makeCaseSpec(DartObject obj,
    {@required String Function(DartType) typeName}) {
  final caseType = obj.type.typeArguments.first;
  return CaseSpec(
    name: obj.getField("name").toStringValue() ?? _defaultCaseName(caseType),
    typeName: typeName(caseType),
    requiresPayload: _caseTypeRequiresPayload(caseType),
  );
}

bool _caseTypeRequiresPayload(DartType type) =>
    !(type.isDynamic || type.isVoid || type.isDartCoreNull);

String _defaultCaseName(DartType type) =>
    lowercaseLeadingID(undecoratedID(type.name));

String _typeName(DartType type, {@required String Function(String) resolve}) =>
    [
      resolve(type.name),
      if (type is ParameterizedType && type.typeArguments.isNotEmpty) ...[
        "<",
        type.typeArguments
            .map((type) => _typeName(type, resolve: resolve))
            .join(", "),
        ">",
      ]
    ].join();
