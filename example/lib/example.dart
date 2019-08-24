import 'package:meta/meta.dart';
import 'package:sum_types/sum_types.dart';

part 'example.g.dart';

@SumType([
  Case<void>(name: "zero"),
  Case<_Nat>(name: "next"),
])
mixin _Nat implements _NatBase {
  int toInt() => iswitch(
        zero: () => 0,
        next: (next) => 1 + next.toInt(),
      );
}

@SumType([
  Case<Map<String, _JSON>>(name: "object"),
  Case<List<_JSON>>(name: "array"),
  Case<String>(),
  Case<double>(name: "number"),
  Case<bool>(name: "boolean"),
  Case<void>(name: "empty"),
])
mixin _JSON {}
