import 'package:meta/meta.dart';

@immutable
class TypeParamSpec {
  const TypeParamSpec({@required this.name, this.bound});

  final String name;
  final String bound;
}
