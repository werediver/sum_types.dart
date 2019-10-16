[![Build Status](https://travis-ci.org/werediver/sum_types.dart.svg?branch=master)](https://travis-ci.org/werediver/sum_types.dart)
[![sum_types version](https://img.shields.io/pub/v/sum_types?label=sum_types)](https://pub.dev/packages/sum_types)
[![sum_types_generator version](https://img.shields.io/pub/v/sum_types_generator?label=sum_types_generator)](https://pub.dev/packages/sum_types_generator)

## sum_types and sum_types_generator

[sum_types](https://pub.dev/packages/sum_types) and [sum_types_generator](https://pub.dev/packages/sum_types_generator) packages together define a code generator enabling [sum-types](https://en.wikipedia.org/wiki/Sum_type) in Dart.

## Example

In [example/lib/src/](example/lib/src) you can find a few sum-type declarations and the code generated for them.

This one models the natural numbers (with zero):

```dart
import 'package:meta/meta.dart';
import 'package:sum_types/sum_types.dart';

@SumType([
  Case<void>(name: "zero"),
  Case<_Nat>(name: "next"),
])
mixin _Nat implements _NatBase {
  Nat operator +(Nat other) => iswitch(
        zero: () => other,
        next: (next) => Nat.next(next + other),
      );

  int toInt() => iswitch(
        zero: () => 0,
        next: (next) => 1 + next.toInt(),
      );
}
```

## Features

Core:
- [x] Const case-constructors (`const Nat.zero()`)
- [x] Extensible sum-types (`Nat.toInt()`)
- [x] Nested sum-types
- [x] Recursive sum-types (`Case<_Nat>(name: "next")` → `Nat.next(Nat.zero())`)
- [x] Generic sum-types (`Either<Left, Right>`)
- [x] Exhaustive in-line `iswitch`
- [x] Inexhaustive in-line `iswitcho` (with `otherwise:` case)

Sugar:
- [x] No-payload cases (`Case<void>(name: "zero")` → `Nat.zero()`)
- [x] Default case-names (`Case<String>()` → `JSON.string("some")`)

Trivia:
- [x] Equality test
- [x] Hash function
- [x] To string conversion

Serialization-deserialization support through product-types interoperability:
- [x] Deserialization support (`NatRecord<Self>`, `Nat.load<T extends NatRecord<T>>(T rec)`)
- [x] Serialization support (`Nat.dump<T>(T Function({Unit zero, T next} make))`)

## Development

Find the upcoming development plans in the [project planner](https://github.com/werediver/sum_types.dart/projects/1).
