[![Build Status](https://travis-ci.org/werediver/sum_types.dart.svg?branch=master)](https://travis-ci.org/werediver/sum_types.dart)
[![sum_types version](https://img.shields.io/pub/v/sum_types?label=sum_types)](https://pub.dev/packages/sum_types)
[![sum_types_generator version](https://img.shields.io/pub/v/sum_types_generator?label=sum_types_generator)](https://pub.dev/packages/sum_types_generator)

## sum_types and sum_types_generator

[sum_types](https://pub.dev/packages/sum_types) and [sum_types_generator](https://pub.dev/packages/sum_types_generator) packages together define a code generator enabling [sum-types](https://en.wikipedia.org/wiki/Sum_type) in Dart.

## Features

Core:
- [x] Const case-constructors
- [x] Extensible sum-types (`Nat.toInt()`)
- [x] Recursive sum-types (`Case<_Nat>(name: "next")` → `Nat.next(Nat.zero())`)
- [ ] Generic sum-types (`Either<Left, Right>`)
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
- [ ] Deserialization support (`NatRecord<Self>`, `Nat.load<T extends NatRecord<T>>(T rec)`)
- [ ] Serialization support (`Nat.dump<T>(T Function({Unit zero, T next} make))`)

## Example

In [example/lib/example.dart](example/lib/example.dart) you can find a couple of sum-type declarations and in [example/lib/example.g.dart](example/lib/example.g.dart) the generated code.

This one models the natural numbers (with zero):

```dart
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

## Development

Find the upcoming development plans in the [project planner](https://github.com/werediver/sum_types.dart/projects/1).