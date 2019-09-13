import 'dart:convert';

import 'package:example/example.dart';

void main(List<String> arguments) {
  showcaseNatBasic();
  showcaseNatJson();
}

void showcaseNatBasic() {
  print("## $Nat basic\n");

  const x = Nat.next(Nat.next(Nat.zero()));
  final xx = x + x;
  print("  $x\n+ $x\n= $xx");
  print(" (${x.toInt()} + ${x.toInt()} = ${xx.toInt()})");
  print("");
}

void showcaseNatJson() {
  print("## $Nat serializationn-deserialization\n");

  const originalNat = Nat.next(Nat.zero());
  print("Original object: $originalNat");

  final originalRec = originalNat
      .dump<NatRecord>(({zero, next}) => NatRecord(zero: zero, next: next));
  final jsonString = const JsonEncoder().convert(originalRec);
  print("JSON string: $jsonString");

  final Object jsonObject = const JsonDecoder().convert(jsonString);
  final recoveredRec = NatRecord.fromJson(jsonObject as Map<String, Object>);
  final recoveredNat = Nat.load(recoveredRec);
  print("Recovered object: $recoveredNat");
  print("");
}
