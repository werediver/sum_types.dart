import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:sum_types/sum_types.dart';

part 'nat.g.dart';

@SumType([
  Case<void>(name: "zero"),
  Case<_Nat>(name: "next"),
])
mixin _Nat implements _NatBase {
  Nat operator +(Nat other) => iswitch(
        zero: () => other,
        next: (next) => Nat.next(next + other),
      );

  int toInt() => iswitch(
        zero: () => 0,
        next: (next) => 1 + next.toInt(),
      );
}

@JsonSerializable(includeIfNull: false)
class NatRecord implements NatRecordBase<NatRecord> {
  const NatRecord({
    this.zero,
    this.next,
  });

  factory NatRecord.fromJson(Map<String, Object> json) =>
      _$NatRecordFromJson(json);

  Map<String, dynamic> toJson() => _$NatRecordToJson(this);

  @override
  final Unit zero;
  @override
  final NatRecord next;
}

@SumType([
  Case<_Nat>(name: "some"),
  Case<void>(name: "none"),
])
mixin _OptionalNat implements _OptionalNatBase {}
