import 'package:json_annotation/json_annotation.dart';
import 'package:sum_types/sum_types.dart';
import 'package:meta/meta.dart';

part 'optional.g.dart';

@SumType()
class Optional<T> extends _$Optional<T> {
  const Optional.some(T value) : super(some: value);
  const Optional.none() : super(none: const Unit());

  factory Optional.fromNullable(T? value) =>
      value != null ? Optional.some(value) : Optional<T>.none();

  Optional<U> map<U>(U Function(T) f) => iswitch(
        some: (value) => Optional.some(f(value)),
        none: () => Optional<U>.none(),
      );

  Optional<U> flatMap<U>(Optional<U> Function(T) f) => iswitch(
        some: (value) => f(value),
        none: () => Optional<U>.none(),
      );

  T valueOr(T Function() fallback) =>
      iswitch(some: (value) => value, none: fallback);

  T? get valueOrNull => iswitch(some: (x) => x, none: () => null);
}

/// Works for types directly supported by both `JsonEncoder` and `JsonDecoder`.
///
/// No static guarantees.
///
/// See https://github.com/dart-lang/json_serializable/blob/master/example/lib/json_converter_example.dart
class CarelessOptionalConverter<T>
    implements JsonConverter<Optional<T>, Object?> {
  const CarelessOptionalConverter();

  @override
  Optional<T> fromJson(Object? json) => Optional.fromNullable(json as T);

  @override
  Object? toJson(Optional<T> object) => object.valueOrNull;
}
