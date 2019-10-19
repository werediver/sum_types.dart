import 'dart:convert';

import 'package:example/src/nat.dart';
import 'package:example/src/optional.dart';

void main(List<String> arguments) {
  showcaseNatBasic();
  showcaseNatJson();
  showcaseOptionalJson();
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

  final jsonString = const JsonEncoder().convert(originalNat);
  print("JSON string: $jsonString");

  final Object jsonObject = const JsonDecoder().convert(jsonString);
  final recoveredNat = Nat.fromJson(jsonObject as Map<String, Object>);
  print("Recovered object: $recoveredNat");
  print("");
}

void showcaseOptionalJson() {
  print("## $Optional serialization-deserialization\n");

  const originalOpt = Optional.some(1);
  print("Original object: $originalOpt");

  final jsonString = const JsonEncoder()
      .convert(const CarelessOptionalConverter<int>().toJson(originalOpt));
  print("JSON string: $jsonString");

  final Object jsonObject = const JsonDecoder().convert(jsonString);
  final recoveredOpt =
      const CarelessOptionalConverter<int>().fromJson(jsonObject);

  print("Recovered object: $recoveredOpt");
  print("");
}
