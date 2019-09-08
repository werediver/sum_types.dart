import 'dart:convert';

import 'package:example/example.dart';
import 'package:sum_types/sum_types.dart';

void main(List<String> arguments) {
  showcaseNatBasic();
  showcaseNatJson();
}

void showcaseNatBasic() {
  const x = Nat.next(Nat.next(Nat.zero()));
  final xx = x + x;
  print("  $x\n+ $x\n= $xx");
  print(" (${x.toInt()} + ${x.toInt()} = ${xx.toInt()})");
}

void showcaseNatJson() {
  const originalRec = NatRecord(
    zero: null,
    next: NatRecord(
      zero: Unit(),
      next: null,
    ),
  );

  const coder = JsonCodec();

  final jsonString = coder.encode(originalRec);
  print("JSON string: $jsonString");

  final Object jsonObject = coder.decode(jsonString);
  print("JSON object: $jsonObject");

  final recoveredRec = NatRecord.fromJson(jsonObject as Map<String, Object>);
  print("Recovered record: $recoveredRec");
}
