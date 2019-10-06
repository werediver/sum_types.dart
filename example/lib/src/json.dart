import 'package:meta/meta.dart';
import 'package:sum_types/sum_types.dart';

part 'json.g.dart';

@SumType([
  Case<Map<String, _JSON>>(name: "object"),
  Case<List<_JSON>>(name: "array"),
  Case<String>(),
  Case<double>(name: "number"),
  Case<bool>(name: "boolean"),
  Case<void>(name: "empty"),
])
mixin _JSON {}
