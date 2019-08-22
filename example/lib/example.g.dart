// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// SumTypesGenerator
// **************************************************************************

class Variant with _Variant {
  const Variant.string(
    String string,
  ) : this._unsafe(string: string);
  const Variant.number(
    double number,
  ) : this._unsafe(number: number);
  const Variant.boolean(
    bool boolean,
  ) : this._unsafe(boolean: boolean);
  const Variant.empty() : this._unsafe(empty: const Unit());
  const Variant._unsafe({
    this.string,
    this.number,
    this.boolean,
    this.empty,
  }) : assert(string != null &&
                number == null &&
                boolean == null &&
                empty == null ||
            string == null &&
                number != null &&
                boolean == null &&
                empty == null ||
            string == null &&
                number == null &&
                boolean != null &&
                empty == null ||
            string == null &&
                number == null &&
                boolean == null &&
                empty != null);
  T iswitch<T>({
    @required T Function(String) string,
    @required T Function(double) number,
    @required T Function(bool) boolean,
    @required T Function() empty,
  }) {
    if (this.string != null) {
      return string(this.string);
    } else if (this.number != null) {
      return number(this.number);
    } else if (this.boolean != null) {
      return boolean(this.boolean);
    } else if (this.empty != null) {
      return empty();
    } else {
      throw StateError("an instance of $Variant has no case selected");
    }
  }

  T iswitcho<T>({
    T Function(String) string,
    T Function(double) number,
    T Function(bool) boolean,
    T Function() empty,
    @required T Function() otherwise,
  }) {
    T _otherwise(Object _) => otherwise();
    return iswitch(
      string: string ?? _otherwise,
      number: number ?? _otherwise,
      boolean: boolean ?? _otherwise,
      empty: empty ?? _otherwise,
    );
  }

  final String string;
  final double number;
  final bool boolean;
  final Unit empty;
}
