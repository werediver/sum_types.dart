import 'package:meta/meta.dart';

@immutable
class SumType {
  const SumType(this.cases);

  final List<Case> cases;
}

@immutable
class Case<T> {
  const Case({this.name});

  final String name;
}
