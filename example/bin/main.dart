import 'package:example/example.dart';

void main(List<String> arguments) {
  const x = Nat.next(Nat.next(Nat.zero()));
  final xx = x + x;
  print("  $x\n+ $x\n= $xx");
  print(" (${x.toInt()} + ${x.toInt()} = ${xx.toInt()})");
}
