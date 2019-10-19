import 'package:meta/meta.dart';
import 'package:sum_types/sum_types.dart';

part 'pesky_json.g.dart';

@SumType()
class PeskyJson extends _$PeskyJson {
  const PeskyJson.object(Map<String, PeskyJson> value) : super(object: value);
  const PeskyJson.array(Iterable<PeskyJson> value) : super(array: value);
  const PeskyJson.string(String value) : super(string: value);
  const PeskyJson.number(double value) : super(number: value);
  const PeskyJson.boolean(bool value) : super(boolean: value);
  const PeskyJson.empty() : super(empty: const Unit());

  factory PeskyJson.fromJson(Object json) {
    if (json is Map<String, Object>) {
      return PeskyJson.object(
        json.map((key, value) => MapEntry(key, PeskyJson.fromJson(value))),
      );
    } else if (json is Iterable<Object>) {
      return PeskyJson.array(json.map((json) => PeskyJson.fromJson(json)));
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
