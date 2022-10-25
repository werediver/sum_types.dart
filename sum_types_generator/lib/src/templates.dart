import 'package:sum_types_generator/src/common_spec.dart';

String undecoratedID(String id) {
  final start = _idDecorationLen(id);
  final end = id.indexOf("<", start);
  return start == 0 && end < 0
      ? id
      : id.substring(start, end >= 0 ? end : null);
}

String lowercaseLeadingID(String id) {
  final offset = _idDecorationLen(id);
  final leadingLetter = id[offset];
  final lowercasedLeadingLetter = leadingLetter.toLowerCase();
  return leadingLetter == lowercasedLeadingLetter
      ? id
      : id.substring(0, offset) +
          lowercasedLeadingLetter +
          id.substring(offset + 1);
}

int _idDecorationLen(String id) {
  bool isDecoration(String char) => char == "_" || char == r"$";
  var offset = 0;
  while (isDecoration(id[offset])) {
    offset += 1;
  }
  return offset;
}

String classDecl({
  bool abstract = false,
  required String name,
  Iterable<TypeParamSpec> typeParams = const [],
  String? superclass,
  Iterable<String> mixins = const [],
  Iterable<String> ifaces = const [],
  Iterable<String> body = const [],
}) =>
    [
      if (abstract) "abstract",
      "class",
      name,
      parametrize(typeParams),
      if (superclass != null) ...[
        "extends",
        superclass,
      ],
      if (mixins.isNotEmpty) ...[
        "with",
        mixins.join(", "),
      ],
      if (ifaces.isNotEmpty) ...[
        "implements",
        ifaces.join(", "),
      ],
      "{",
      ...body,
      "}",
    ].join("\n");

String mixinDecl({
  required String name,
  Iterable<TypeParamSpec> typeParams = const [],
  Iterable<String> superclassConstraints = const [],
  Iterable<String> ifaces = const [],
  Iterable<String> body = const [],
}) =>
    [
      "mixin",
      name,
      parametrize(typeParams),
      if (superclassConstraints.isNotEmpty) ...[
        "on",
        superclassConstraints.join(", "),
      ],
      if (ifaces.isNotEmpty) ...[
        "implements",
        ifaces.join(", "),
      ],
      "{",
      ...body,
      "}",
    ].join("\n");

String constructor({
  required bool isConst,
  required String type,
  String? name,
  Iterable<String> posParams = const [],
  Iterable<String> namedParams = const [],
  Iterable<String> initializers = const [],
}) =>
    [
      if (isConst) "const ",
      type,
      if (name != null) ".$name",
      "(",
      ...posParams.map(appendComma),
      if (namedParams.isNotEmpty) ...[
        "{",
        ...namedParams.map(appendComma),
        "}",
      ],
      ")",
      if (initializers.isNotEmpty) ...[
        ":",
        initializers.join(", "),
      ],
      ";",
    ].join();

String function({
  bool isStatic = false,
  required String type,
  required String name,
  Iterable<TypeParamSpec> typeParams = const [],
  Iterable<String> posParams = const [],
  Iterable<String> namedParams = const [],
  Iterable<String>? body,
}) =>
    [
      if (isStatic) "static ",
      type,
      " ",
      name,
      parametrize(typeParams),
      "(",
      ...posParams.map(appendComma),
      if (namedParams.isNotEmpty) ...[
        "{",
        ...namedParams.map(appendComma),
        "}",
      ],
      ")",
      if (body != null) ...[
        "{",
        body.join("\n"),
        "}",
      ] else
        ";",
    ].join("\n");

String expressionFunction({
  required String type,
  required String name,
  required Iterable<String> body,
  bool isStatic = false,
  Iterable<TypeParamSpec> typeParams = const [],
  Iterable<String> posParams = const [],
  Iterable<String> namedParams = const [],
}) =>
    [
      if (isStatic) "static ",
      type,
      " ",
      name,
      parametrize(typeParams),
      "(",
      ...posParams.map(appendComma),
      if (namedParams.isNotEmpty) ...[
        "{",
        ...namedParams.map(appendComma),
        "}",
      ],
      ") =>",
      body.join("\n"),
      ";",
    ].join("\n");

String param({String? type, required String name}) => [
      if (type != null) type,
      name,
    ].join(" ");

String getter({
  required String type,
  required String name,
  Iterable<String>? body,
}) =>
    [
      type,
      " get ",
      name,
      if (body != null) ...[
        "{",
        body.join(" "),
        "}",
      ] else
        ";",
    ].join();

String finalField({required String type, required String name}) => [
      "final",
      type,
      name,
      ";",
    ].join(" ");

String parametrize(Iterable<TypeParamSpec> typeParams) => typeParams.isNotEmpty
    ? [
        "<",
        typeParams
            .map((typeParam) => [
                  typeParam.name,
                  if (typeParam.bound != null) " extends ${typeParam.bound}",
                ].join())
            .join(","),
        ">",
      ].join()
    : "";

String specialize(Iterable<String> typeArgs) => typeArgs.isNotEmpty
    ? [
        "<",
        typeArgs.join(","),
        ">",
      ].join()
    : "";

String appendComma(String s) => "$s,";

Result cartprod2<A, B, Tuple, Row, Result>(
  Iterable<A> as,
  Iterable<B> bs, {
  required Tuple Function(A a, B b) tuple,
  required Row Function(Iterable<Tuple>) row,
  required Result Function(Iterable<Row>) result,
}) =>
    result(as.map((a) => row(bs.map((b) => tuple(a, b)))));
