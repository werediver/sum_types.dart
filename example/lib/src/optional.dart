import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:sum_types/sum_types.dart';

part 'optional.g.dart';

@SumType([
  CaseT(0, name: "some"),
  Case<void>(name: "none"),
])
mixin _Optional<T> implements _OptionalBase<T> {
  Optional<U> map<U>(U Function(T) f) => iswitch(
        some: (value) => Optional.some(f(value)),
        none: () => Optional<U>.none(),
      );

  Optional<U> flatMap<U>(Optional<U> Function(T) f) => iswitch(
        some: (value) => f(value),
        none: () => Optional<U>.none(),
      );
}

/// This is a pretty impractical way to serialize [Optional].
/// It is here to test the code-generator.
///
/// A more practical approach would be to implement a direct converter like
///
///     class CarelessOptionalJsonConverter<T> implements JsonConverter<Optional<T>, Object> {
///       ...
///     }
///
@JsonSerializable(includeIfNull: false)
class OptionalRecord<T> implements OptionalRecordBase<OptionalRecord<T>, T> {
  const OptionalRecord({@required this.some, @required this.none});

  factory OptionalRecord.fromJson(Map<String, Object> json) =>
      _$OptionalRecordFromJson(json);

  Map<String, Object> toJson() => _$OptionalRecordToJson(this);

  @override
  @_CarelessJsonConverter()
  final T some;

  @override
  final Unit none;
}

/// Works for types directly supported by both `JsonEncoder` and `JsonDecoder`.
///
/// No static guarantees.
class _CarelessJsonConverter<T> implements JsonConverter<T, Object> {
  const _CarelessJsonConverter();

  @override
  T fromJson(Object json) => json as T;

  @override
  Object toJson(T object) => object;
}
