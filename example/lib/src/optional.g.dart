// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'optional.dart';

// **************************************************************************
// SumTypesGenerator
// **************************************************************************

// ignore_for_file: unused_element
abstract class _$Optional<T> {
  const _$Optional({
    this.some,
    this.none,
  }) : assert(some != null && none == null || some == null && none != null);
  static Optional<T> load<$T extends OptionalRecordBase<$T, T>, T>(
    $T rec,
  ) {
    if (rec.some != null && rec.none == null) {
      return Optional<T>.some(rec.some!);
    } else if (rec.some == null && rec.none != null) {
      return Optional<T>.none();
    } else {
      throw Exception("Cannot select a $Optional case given $rec");
    }
  }

  $T dump<$T>(
    $T Function({
      T? some,
      Unit? none,
    }) make,
  ) =>
      iswitch(
        some: (some) => make(some: some),
        none: () => make(none: const Unit()),
      );
  $T iswitch<$T>({
    required $T Function(T) some,
    required $T Function() none,
  }) {
    if (this.some != null) {
      return some(this.some!);
    } else if (this.none != null) {
      return none();
    } else {
      throw StateError("an instance of $Optional has no case selected");
    }
  }

  $T iswitcho<$T>({
    required $T Function() otherwise,
    $T Function(T)? some,
    $T Function()? none,
  }) {
    $T _otherwise(Object? _) => otherwise();
    return iswitch(
      some: some ?? _otherwise,
      none: none ?? otherwise,
    );
  }

  @override
  bool operator ==(
    Object other,
  ) =>
      other.runtimeType == runtimeType &&
      other is Optional &&
      other.some == some &&
      other.none == none;
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
  final T? some;
  @protected
  final Unit? none;
}

abstract class OptionalRecordBase<Self, T> {
  T? get some;
  Unit? get none;
}
