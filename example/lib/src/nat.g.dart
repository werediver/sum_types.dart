// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NatRecord _$NatRecordFromJson(Map<String, dynamic> json) {
  return NatRecord(
    zero: json['zero'] == null
        ? null
        : Unit.fromJson(json['zero'] as Map<String, dynamic>),
    next: json['next'] == null
        ? null
        : NatRecord.fromJson(json['next'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NatRecordToJson(NatRecord instance) {
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

abstract class _NatBase {
  __T iswitch<__T>({
    @required __T Function() zero,
    @required __T Function(Nat) next,
  });
  __T iswitcho<__T>({
    __T Function() zero,
    __T Function(Nat) next,
    @required __T Function() otherwise,
  });
}

class Nat with _Nat implements _NatBase {
  const Nat.zero() : this._unsafe(zero: const Unit());
  const Nat.next(
    Nat next,
  ) : this._unsafe(next: next);
  const Nat._unsafe({
    this.zero,
    this.next,
  }) : assert(zero != null && next == null || zero == null && next != null);
  static Nat load<__T extends NatRecordBase<__T>>(
    __T rec,
  ) {
    if (!(rec.zero != null && rec.next == null ||
        rec.zero == null && rec.next != null)) {
      throw Exception("Cannot select a $Nat case given $rec");
    }
    return Nat._unsafe(
      zero: rec.zero,
      next: rec.next != null ? load(rec.next) : null,
    );
  }

  __T dump<__T>(
    __T Function({
      Unit zero,
      __T next,
    })
        make,
  ) {
    return iswitch(
      zero: () => make(zero: const Unit()),
      next: (next) => make(next: next.dump(make)),
    );
  }

  @override
  __T iswitch<__T>({
    @required __T Function() zero,
    @required __T Function(Nat) next,
  }) {
    if (this.zero != null) {
      return zero();
    } else if (this.next != null) {
      return next(this.next);
    } else {
      throw StateError("an instance of $Nat has no case selected");
    }
  }

  @override
  __T iswitcho<__T>({
    __T Function() zero,
    __T Function(Nat) next,
    @required __T Function() otherwise,
  }) {
    __T _otherwise(Object _) => otherwise();
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

abstract class _OptionalNatBase {
  __T iswitch<__T>({
    @required __T Function(Nat) some,
    @required __T Function() none,
  });
  __T iswitcho<__T>({
    __T Function(Nat) some,
    __T Function() none,
    @required __T Function() otherwise,
  });
}

class OptionalNat with _OptionalNat implements _OptionalNatBase {
  const OptionalNat.some(
    Nat some,
  ) : this._unsafe(some: some);
  const OptionalNat.none() : this._unsafe(none: const Unit());
  const OptionalNat._unsafe({
    this.some,
    this.none,
  }) : assert(some != null && none == null || some == null && none != null);
  static OptionalNat load<__T extends OptionalNatRecordBase<__T>>(
    __T rec,
  ) {
    if (!(rec.some != null && rec.none == null ||
        rec.some == null && rec.none != null)) {
      throw Exception("Cannot select a $OptionalNat case given $rec");
    }
    return OptionalNat._unsafe(
      some: rec.some,
      none: rec.none,
    );
  }

  __T dump<__T>(
    __T Function({
      Nat some,
      Unit none,
    })
        make,
  ) {
    return iswitch(
      some: (some) => make(some: some),
      none: () => make(none: const Unit()),
    );
  }

  @override
  __T iswitch<__T>({
    @required __T Function(Nat) some,
    @required __T Function() none,
  }) {
    if (this.some != null) {
      return some(this.some);
    } else if (this.none != null) {
      return none();
    } else {
      throw StateError("an instance of $OptionalNat has no case selected");
    }
  }

  @override
  __T iswitcho<__T>({
    __T Function(Nat) some,
    __T Function() none,
    @required __T Function() otherwise,
  }) {
    __T _otherwise(Object _) => otherwise();
    return iswitch(
      some: some ?? _otherwise,
      none: none ?? otherwise,
    );
  }

  @override
  bool operator ==(
    dynamic other,
  ) {
    return other.runtimeType == runtimeType &&
        other.some == some &&
        other.none == none;
  }

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + some.hashCode;
    result = 37 * result + none.hashCode;
    return result;
  }

  @override
  String toString() {
    final ctor = iswitch(
      some: (value) => "some($value)",
      none: () => "none()",
    );
    return "$runtimeType.$ctor";
  }

  @protected
  final Nat some;
  @protected
  final Unit none;
}

abstract class OptionalNatRecordBase<Self> {
  Nat get some;
  Unit get none;
}
