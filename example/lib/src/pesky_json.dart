import 'package:meta/meta.dart';
import 'package:sum_types/sum_types.dart';

part 'pesky_json.g.dart';

@SumType([
  Case<Map<String, _PeskyJson>>(name: "object"),
  Case<Iterable<_PeskyJson>>(name: "array"),
  Case<String>(),
  Case<double>(name: "number"),
  Case<bool>(name: "boolean"),
  Case<void>(name: "empty"),
])
mixin _PeskyJson implements _PeskyJsonBase {
  // FIXME: Static methods are impossible to mix in. Find another approach.
  static PeskyJson fromJson(Object json) {
    if (json is Map<String, Object>) {
      return PeskyJson.object(
        json.map((key, value) => MapEntry(key, _PeskyJson.fromJson(value))),
      );
    } else if (json is Iterable<Object>) {
      return PeskyJson.array(json.map(_PeskyJson.fromJson));
    } else if (json is String) {
      return PeskyJson.string(json);
    } else if (json is num) {
      return PeskyJson.number(json.toDouble());
    } else if (json is bool) {
      return PeskyJson.boolean(json);
    } else if (json == null) {
      return const PeskyJson.empty();
    }
    throw Exception("Cannot convert $json to $PeskyJson");
  }

  Object toJson() => iswitch(
        object: (value) =>
            value.map((key, value) => MapEntry(key, value.toJson())),
        array: (value) => value.map((value) => value.toJson()),
        string: (value) => value,
        number: (value) => value,
        boolean: (value) => value,
        empty: () => null,
      );
}
