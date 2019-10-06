// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json.dart';

// **************************************************************************
// SumTypesGenerator
// **************************************************************************

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
    return "$runtimeType.$ctor";
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
