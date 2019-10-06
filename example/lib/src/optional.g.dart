// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'optional.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionalRecord<T> _$OptionalRecordFromJson<T>(Map<String, dynamic> json) {
  return OptionalRecord<T>(
    some: _CarelessJsonConverter<T>().fromJson(json['some']),
    none: json['none'] == null
        ? null
        : Unit.fromJson(json['none'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OptionalRecordToJson<T>(OptionalRecord<T> instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('some', _CarelessJsonConverter<T>().toJson(instance.some));
  writeNotNull('none', instance.none);
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
    return "$runtimeType.$ctor";
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
