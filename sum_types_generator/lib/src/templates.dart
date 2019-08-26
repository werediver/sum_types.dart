import 'package:meta/meta.dart';

String undecoratedID(String id) {
  final offset = _idDecorationLen(id);
  return offset == 0 ? id : id.substring(offset);
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
  @required String name,
  String superclass,
  Iterable<String> mixins = const [],
  Iterable<String> ifaces = const [],
  Iterable<String> body = const [],
}) =>
    [
      if (abstract) "abstract",
      "class",
      name,
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
    ].join(" ");

String mixinDecl({
  @required String name,
  Iterable<String> superclassConstraints = const [],
  Iterable<String> ifaces = const [],
  Iterable<String> body = const [],
}) =>
    [
      "mixin",
      name,
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
    ].join(" ");

String constructor({
  @required bool isConst,
  @required String type,
  String name,
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
  @required String type,
  @required String name,
  Iterable<String> posParams = const [],
  Iterable<String> namedParams = const [],
  Iterable<String> body,
}) =>
    [
      type,
      " ",
      name,
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
        body.join(" "),
        "}",
      ] else
        ";",
    ].join();

String param({String type, @required String name}) => [
      if (type != null) type,
      name,
    ].join(" ");

String getter({
  String type,
  @required String name,
  @required Iterable<String> body,
}) =>
    [
      type,
      " get ",
      name,
      "{",
      body.join(" "),
      "}",
    ].join();

String finalField({@required String type, @required String name}) => [
      "final",
      type,
      name,
      ";",
    ].join(" ");

String appendComma(String s) => "$s,";

Result cartprod2<A, B, Tuple, Row, Result>(
  Iterable<A> as,
  Iterable<B> bs, {
  @required Tuple Function(A a, B b) tuple,
  @required Row Function(Iterable<Tuple>) row,
  @required Result Function(Iterable<Row>) result,
}) =>
    result(as.map((a) => row(bs.map((b) => tuple(a, b)))));
