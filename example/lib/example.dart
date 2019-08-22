import 'package:meta/meta.dart';
import 'package:sum_types/sum_types.dart';

part 'example.g.dart';

@SumType([
  Case<String>(),
  Case<double>(name: "number"),
  Case<bool>(name: "boolean"),
  Case<void>(name: "empty"),
])
mixin _Variant {}

