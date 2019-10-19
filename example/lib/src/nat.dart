import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:sum_types/sum_types.dart';

part 'nat.g.dart';

@SumType()
class Nat extends _$Nat {
  const Nat.zero() : super(zero: const Unit());
  const Nat.next(Nat value) : super(next: value);

  factory Nat.fromJson(Map<String, Object> json) =>
      _$Nat.load(_NatRecord.fromJson(json));

  Map<String, Object> toJson() =>
      dump<_NatRecord>(({zero, next}) => _NatRecord(zero: zero, next: next))
          .toJson();

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
class _NatRecord implements NatRecordBase<_NatRecord> {
  const _NatRecord({
    this.zero,
    this.next,
  });

  factory _NatRecord.fromJson(Map<String, Object> json) =>
      _$_NatRecordFromJson(json);

  Map<String, dynamic> toJson() => _$_NatRecordToJson(this);

  @override
  final Unit zero;
  @override
  final _NatRecord next;
}
