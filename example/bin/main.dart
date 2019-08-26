import 'package:example/example.dart';

void main(List<String> arguments) {
  const x = Nat.next(Nat.next(Nat.zero()));
  print("  $x\n+ $x\n= ${x + x}");
  print(" (${x.toInt()} + ${x.toInt()} = ${(x + x).toInt()})");
}
