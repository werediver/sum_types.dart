// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

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

abstract class _OptionalBase<T> {
  __T iswitch<__T>({
    @required __T Function(T) some,
    @required __T Function() none,
  });
  __T iswitcho<__T>({
    __T Function(T) some,
    __T Function() none,
    @required __T Function() otherwise,
  });
}

class Optional<T> with _Optional<T> implements _OptionalBase<T> {
  const Optional.some(
    T some,
  ) : this._unsafe(some: some);
  const Optional.none() : this._unsafe(none: const Unit());
  const Optional._unsafe({
    this.some,
    this.none,
  }) : assert(some != null && none == null || some == null && none != null);
  static Optional<T> load<__T extends OptionalRecordBase<__T, T>, T>(
    __T rec,
  ) {
    if (!(rec.some != null && rec.none == null ||
        rec.some == null && rec.none != null)) {
      throw Exception("Cannot select a $Optional case given $rec");
    }
    return Optional._unsafe(
      some: rec.some,
      none: rec.none,
    );
  }

  __T dump<__T>(
    __T Function({
      T some,
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
    @required __T Function(T) some,
    @required __T Function() none,
  }) {
    if (this.some != null) {
      return some(this.some);
    } else if (this.none != null) {
      return none();
    } else {
      throw StateError("an instance of $Optional has no case selected");
    }
  }

  @override
  __T iswitcho<__T>({
    __T Function(T) some,
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
    return "$Optional.$ctor";
  }

  @protected
  final T some;
  @protected
  final Unit none;
}

abstract class OptionalRecordBase<Self, T> {
  T get some;
  Unit get none;
}

abstract class _MaybeNatBase {
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

class MaybeNat with _MaybeNat implements _MaybeNatBase {
  const MaybeNat.some(
    Nat some,
  ) : this._unsafe(some: some);
  const MaybeNat.none() : this._unsafe(none: const Unit());
  const MaybeNat._unsafe({
    this.some,
    this.none,
  }) : assert(some != null && none == null || some == null && none != null);
  static MaybeNat load<__T extends MaybeNatRecordBase<__T>>(
    __T rec,
  ) {
    if (!(rec.some != null && rec.none == null ||
        rec.some == null && rec.none != null)) {
      throw Exception("Cannot select a $MaybeNat case given $rec");
    }
    return MaybeNat._unsafe(
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
      throw StateError("an instance of $MaybeNat has no case selected");
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
    return "$MaybeNat.$ctor";
  }

  @protected
  final Nat some;
  @protected
  final Unit none;
}

abstract class MaybeNatRecordBase<Self> {
  Nat get some;
  Unit get none;
}

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
    return "$Nat.$ctor";
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

abstract class _JSONBase {
  __T iswitch<__T>({
    @required __T Function(Map<String, JSON>) object,
    @required __T Function(List<JSON>) array,
    @required __T Function(String) string,
    @required __T Function(double) number,
    @required __T Function(bool) boolean,
    @required __T Function() empty,
  });
  __T iswitcho<__T>({
    __T Function(Map<String, JSON>) object,
    __T Function(List<JSON>) array,
    __T Function(String) string,
    __T Function(double) number,
    __T Function(bool) boolean,
    __T Function() empty,
    @required __T Function() otherwise,
  });
}

class JSON with _JSON implements _JSONBase {
  const JSON.object(
    Map<String, JSON> object,
  ) : this._unsafe(object: object);
  const JSON.array(
    List<JSON> array,
  ) : this._unsafe(array: array);
  const JSON.string(
    String string,
  ) : this._unsafe(string: string);
  const JSON.number(
    double number,
  ) : this._unsafe(number: number);
  const JSON.boolean(
    bool boolean,
  ) : this._unsafe(boolean: boolean);
  const JSON.empty() : this._unsafe(empty: const Unit());
  const JSON._unsafe({
    this.object,
    this.array,
    this.string,
    this.number,
    this.boolean,
    this.empty,
  }) : assert(object != null &&
                array == null &&
                string == null &&
                number == null &&
                boolean == null &&
                empty == null ||
            object == null &&
                array != null &&
                string == null &&
                number == null &&
                boolean == null &&
                empty == null ||
            object == null &&
                array == null &&
                string != null &&
                number == null &&
                boolean == null &&
                empty == null ||
            object == null &&
                array == null &&
                string == null &&
                number != null &&
                boolean == null &&
                empty == null ||
            object == null &&
                array == null &&
                string == null &&
                number == null &&
                boolean != null &&
                empty == null ||
            object == null &&
                array == null &&
                string == null &&
                number == null &&
                boolean == null &&
                empty != null);
  static JSON load<__T extends JSONRecordBase<__T>>(
    __T rec,
  ) {
    if (!(rec.object != null &&
            rec.array == null &&
            rec.string == null &&
            rec.number == null &&
            rec.boolean == null &&
            rec.empty == null ||
        rec.object == null &&
            rec.array != null &&
            rec.string == null &&
            rec.number == null &&
            rec.boolean == null &&
            rec.empty == null ||
        rec.object == null &&
            rec.array == null &&
            rec.string != null &&
            rec.number == null &&
            rec.boolean == null &&
            rec.empty == null ||
        rec.object == null &&
            rec.array == null &&
            rec.string == null &&
            rec.number != null &&
            rec.boolean == null &&
            rec.empty == null ||
        rec.object == null &&
            rec.array == null &&
            rec.string == null &&
            rec.number == null &&
            rec.boolean != null &&
            rec.empty == null ||
        rec.object == null &&
            rec.array == null &&
            rec.string == null &&
            rec.number == null &&
            rec.boolean == null &&
            rec.empty != null)) {
      throw Exception("Cannot select a $JSON case given $rec");
    }
    return JSON._unsafe(
      object: rec.object,
      array: rec.array,
      string: rec.string,
      number: rec.number,
      boolean: rec.boolean,
      empty: rec.empty,
    );
  }

  __T dump<__T>(
    __T Function({
      Map<String, JSON> object,
      List<JSON> array,
      String string,
      double number,
      bool boolean,
      Unit empty,
    })
        make,
  ) {
    return iswitch(
      object: (object) => make(object: object),
      array: (array) => make(array: array),
      string: (string) => make(string: string),
      number: (number) => make(number: number),
      boolean: (boolean) => make(boolean: boolean),
      empty: () => make(empty: const Unit()),
    );
  }

  @override
  __T iswitch<__T>({
    @required __T Function(Map<String, JSON>) object,
    @required __T Function(List<JSON>) array,
    @required __T Function(String) string,
    @required __T Function(double) number,
    @required __T Function(bool) boolean,
    @required __T Function() empty,
  }) {
    if (this.object != null) {
      return object(this.object);
    } else if (this.array != null) {
      return array(this.array);
    } else if (this.string != null) {
      return string(this.string);
    } else if (this.number != null) {
      return number(this.number);
    } else if (this.boolean != null) {
      return boolean(this.boolean);
    } else if (this.empty != null) {
      return empty();
    } else {
      throw StateError("an instance of $JSON has no case selected");
    }
  }

  @override
  __T iswitcho<__T>({
    __T Function(Map<String, JSON>) object,
    __T Function(List<JSON>) array,
    __T Function(String) string,
    __T Function(double) number,
    __T Function(bool) boolean,
    __T Function() empty,
    @required __T Function() otherwise,
  }) {
    __T _otherwise(Object _) => otherwise();
    return iswitch(
      object: object ?? _otherwise,
      array: array ?? _otherwise,
      string: string ?? _otherwise,
      number: number ?? _otherwise,
      boolean: boolean ?? _otherwise,
      empty: empty ?? otherwise,
    );
  }

  @override
  bool operator ==(
    dynamic other,
  ) {
    return other.runtimeType == runtimeType &&
        other.object == object &&
        other.array == array &&
        other.string == string &&
        other.number == number &&
        other.boolean == boolean &&
        other.empty == empty;
  }

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + object.hashCode;
    result = 37 * result + array.hashCode;
    result = 37 * result + string.hashCode;
    result = 37 * result + number.hashCode;
    result = 37 * result + boolean.hashCode;
    result = 37 * result + empty.hashCode;
    return result;
  }

  @override
  String toString() {
    final ctor = iswitch(
      object: (value) => "object($value)",
      array: (value) => "array($value)",
      string: (value) => "string($value)",
      number: (value) => "number($value)",
      boolean: (value) => "boolean($value)",
      empty: () => "empty()",
    );
    return "$JSON.$ctor";
  }

  @protected
  final Map<String, JSON> object;
  @protected
  final List<JSON> array;
  @protected
  final String string;
  @protected
  final double number;
  @protected
  final bool boolean;
  @protected
  final Unit empty;
}

abstract class JSONRecordBase<Self> {
  Map<String, JSON> get object;
  List<JSON> get array;
  String get string;
  double get number;
  bool get boolean;
  Unit get empty;
}
