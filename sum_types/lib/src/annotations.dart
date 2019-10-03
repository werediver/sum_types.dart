import 'package:meta/meta.dart';

@immutable
class SumType {
  const SumType(this.cases);

  final List<CaseBase> cases;
}

@immutable
abstract class CaseBase {
  String get name;
}

@immutable
class Case<T> implements CaseBase {
  const Case({this.name});

  @override
  final String name;
}

@immutable
class CaseT implements CaseBase {
  const CaseT(this.typeParameterIndex, {this.name});

  final int typeParameterIndex;

  @override
  final String name;
}
