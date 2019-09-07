// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// SumTypesGenerator
// **************************************************************************

abstract class _NatBase {
  T iswitch<T>({
    @required T Function() zero,
    @required T Function(Nat) next,
  });
  T iswitcho<T>({
    T Function() zero,
    T Function(Nat) next,
    @required T Function() otherwise,
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
  static Nat load<T extends NatRecordBase<T>>(
    T rec,
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

  @override
  T iswitch<T>({
    @required T Function() zero,
    @required T Function(Nat) next,
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
  T iswitcho<T>({
    T Function() zero,
    T Function(Nat) next,
    @required T Function() otherwise,
  }) {
    T _otherwise(Object _) => otherwise();
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
  T iswitch<T>({
    @required T Function(Map<String, JSON>) object,
    @required T Function(List<JSON>) array,
    @required T Function(String) string,
    @required T Function(double) number,
    @required T Function(bool) boolean,
    @required T Function() empty,
  });
  T iswitcho<T>({
    T Function(Map<String, JSON>) object,
    T Function(List<JSON>) array,
    T Function(String) string,
    T Function(double) number,
    T Function(bool) boolean,
    T Function() empty,
    @required T Function() otherwise,
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
  static JSON load<T extends JSONRecordBase<T>>(
    T rec,
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

  @override
  T iswitch<T>({
    @required T Function(Map<String, JSON>) object,
    @required T Function(List<JSON>) array,
    @required T Function(String) string,
    @required T Function(double) number,
    @required T Function(bool) boolean,
    @required T Function() empty,
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
  T iswitcho<T>({
    T Function(Map<String, JSON>) object,
    T Function(List<JSON>) array,
    T Function(String) string,
    T Function(double) number,
    T Function(bool) boolean,
    T Function() empty,
    @required T Function() otherwise,
  }) {
    T _otherwise(Object _) => otherwise();
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
