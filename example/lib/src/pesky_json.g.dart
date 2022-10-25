// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pesky_json.dart';

// **************************************************************************
// SumTypesGenerator
// **************************************************************************

// ignore_for_file: unused_element
abstract class _$PeskyJson {
  const _$PeskyJson({
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
  static PeskyJson load<$T extends PeskyJsonRecordBase<$T>>(
    $T rec,
  ) {
    if (rec.object != null &&
        rec.array == null &&
        rec.string == null &&
        rec.number == null &&
        rec.boolean == null &&
        rec.empty == null) {
      return PeskyJson.object(rec.object!);
    } else if (rec.object == null &&
        rec.array != null &&
        rec.string == null &&
        rec.number == null &&
        rec.boolean == null &&
        rec.empty == null) {
      return PeskyJson.array(rec.array!);
    } else if (rec.object == null &&
        rec.array == null &&
        rec.string != null &&
        rec.number == null &&
        rec.boolean == null &&
        rec.empty == null) {
      return PeskyJson.string(rec.string!);
    } else if (rec.object == null &&
        rec.array == null &&
        rec.string == null &&
        rec.number != null &&
        rec.boolean == null &&
        rec.empty == null) {
      return PeskyJson.number(rec.number!);
    } else if (rec.object == null &&
        rec.array == null &&
        rec.string == null &&
        rec.number == null &&
        rec.boolean != null &&
        rec.empty == null) {
      return PeskyJson.boolean(rec.boolean!);
    } else if (rec.object == null &&
        rec.array == null &&
        rec.string == null &&
        rec.number == null &&
        rec.boolean == null &&
        rec.empty != null) {
      return const PeskyJson.empty();
    } else {
      throw Exception("Cannot select a $PeskyJson case given $rec");
    }
  }

  $T dump<$T>(
    $T Function({
      Map<String, PeskyJson>? object,
      Iterable<PeskyJson>? array,
      String? string,
      double? number,
      bool? boolean,
      Unit? empty,
    })
        make,
  ) =>
      iswitch(
        object: (object) => make(object: object),
        array: (array) => make(array: array),
        string: (string) => make(string: string),
        number: (number) => make(number: number),
        boolean: (boolean) => make(boolean: boolean),
        empty: () => make(empty: const Unit()),
      );
  $T iswitch<$T>({
    required $T Function(Map<String, PeskyJson>) object,
    required $T Function(Iterable<PeskyJson>) array,
    required $T Function(String) string,
    required $T Function(double) number,
    required $T Function(bool) boolean,
    required $T Function() empty,
  }) {
    if (this.object != null) {
      return object(this.object!);
    } else if (this.array != null) {
      return array(this.array!);
    } else if (this.string != null) {
      return string(this.string!);
    } else if (this.number != null) {
      return number(this.number!);
    } else if (this.boolean != null) {
      return boolean(this.boolean!);
    } else if (this.empty != null) {
      return empty();
    } else {
      throw StateError("an instance of $PeskyJson has no case selected");
    }
  }

  $T iswitcho<$T>({
    required $T Function() otherwise,
    $T Function(Map<String, PeskyJson>)? object,
    $T Function(Iterable<PeskyJson>)? array,
    $T Function(String)? string,
    $T Function(double)? number,
    $T Function(bool)? boolean,
    $T Function()? empty,
  }) {
    $T _otherwise(Object? _) => otherwise();
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
    Object other,
  ) =>
      other.runtimeType == runtimeType &&
      other is PeskyJson &&
      other.object == object &&
      other.array == array &&
      other.string == string &&
      other.number == number &&
      other.boolean == boolean &&
      other.empty == empty;
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
    return "$runtimeType.$ctor";
  }

  @protected
  final Map<String, PeskyJson>? object;
  @protected
  final Iterable<PeskyJson>? array;
  @protected
  final String? string;
  @protected
  final double? number;
  @protected
  final bool? boolean;
  @protected
  final Unit? empty;
}

abstract class PeskyJsonRecordBase<Self> {
  Map<String, PeskyJson>? get object;
  Iterable<PeskyJson>? get array;
  String? get string;
  double? get number;
  bool? get boolean;
  Unit? get empty;
}
