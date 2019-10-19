// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NatRecord _$_NatRecordFromJson(Map<String, dynamic> json) {
  return _NatRecord(
    zero: json['zero'] == null
        ? null
        : Unit.fromJson(json['zero'] as Map<String, dynamic>),
    next: json['next'] == null
        ? null
        : _NatRecord.fromJson(json['next'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_NatRecordToJson(_NatRecord instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('zero', instance.zero);
  writeNotNull('next', instance.next);
  return val;
}

// **************************************************************************
// SumTypesGenerator
// **************************************************************************

abstract class _$Nat {
  const _$Nat({
    this.zero,
    this.next,
  }) : assert(zero != null && next == null || zero == null && next != null);
  static Nat load<$T extends NatRecordBase<$T>>(
    $T rec,
  ) {
    if (rec.zero != null && rec.next == null) {
      return const Nat.zero();
    } else if (rec.zero == null && rec.next != null) {
      return Nat.next(load(rec.next));
    } else {
      throw Exception("Cannot select a $Nat case given $rec");
    }
  }

  $T dump<$T>(
    $T Function({
      Unit zero,
      $T next,
    })
        make,
  ) {
    return iswitch(
      zero: () => make(zero: const Unit()),
      next: (next) => make(next: next.dump(make)),
    );
  }

  $T iswitch<$T>({
    @required $T Function() zero,
    @required $T Function(Nat) next,
  }) {
    if (this.zero != null) {
      return zero();
    } else if (this.next != null) {
      return next(this.next);
    } else {
      throw StateError("an instance of $Nat has no case selected");
    }
  }

  $T iswitcho<$T>({
    $T Function() zero,
    $T Function(Nat) next,
    @required $T Function() otherwise,
  }) {
    $T _otherwise(Object _) => otherwise();
    return iswitch(
      zero: zero ?? otherwise,
      next: next ?? _otherwise,
    );
  }

  @override
  bool operator ==(
    dynamic other,
  ) {
    return other.runtimeType == runtimeType &&
        other.zero == zero &&
        other.next == next;
  }

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + zero.hashCode;
    result = 37 * result + next.hashCode;
    return result;
  }

  @override
  String toString() {
    final ctor = iswitch(
      zero: () => "zero()",
      next: (value) => "next($value)",
    );
    return "$runtimeType.$ctor";
  }

  @protected
  final Unit zero;
  @protected
  final Nat next;
}

abstract class NatRecordBase<Self> {
  Unit get zero;
  Self get next;
}
