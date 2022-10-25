import 'package:meta/meta.dart';

@immutable
class Unit {
  const Unit();

  // ignore: avoid_unused_constructor_parameters
  factory Unit.fromJson(Map<String, Object?> _) => const Unit();

  Map<String, Object?> toJson() => {};

  @override
  bool operator ==(Object other) => other.runtimeType == runtimeType;

  @override
  int get hashCode => 1;
}
