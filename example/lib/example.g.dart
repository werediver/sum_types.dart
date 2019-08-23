// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// SumTypesGenerator
// **************************************************************************

class Nat with _Nat {
  const Nat.zero() : this._unsafe(zero: const Unit());
  const Nat.next(
    Nat next,
  ) : this._unsafe(next: next);
  const Nat._unsafe({
    this.zero,
    this.next,
  }) : assert(zero != null && next == null || zero == null && next != null);
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

  T iswitcho<T>({
    T Function() zero,
    T Function(Nat) next,
    @required T Function() otherwise,
  }) {
    T _otherwise(Object _) => otherwise();
    return iswitch(
      zero: zero ?? _otherwise,
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

  final Unit zero;
  final Nat next;
}

class JSON with _JSON {
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
      empty: empty ?? _otherwise,
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

  final Map<String, JSON> object;
  final List<JSON> array;
  final String string;
  final double number;
  final bool boolean;
  final Unit empty;
}
