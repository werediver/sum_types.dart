import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

ExitCode run(String exe, List<String> args, {String? workingDirectory}) {
  print([
    "\n  In ",
    if (workingDirectory != null)
      "${_quoteArg(p.relative(workingDirectory))}"
    else
      ".",
    "\n  Running $exe ${args.map(_quoteArg).join(" ")}\n",
  ].join());

  final runResult =
      Process.runSync(exe, args, workingDirectory: workingDirectory);

  final runResultStdOut = _cast<String>(runResult.stdout, otherwise: () => "");
  final runResultStdErr = _cast<String>(runResult.stderr, otherwise: () => "");
  stdout.write(runResultStdOut);
  stderr.write(runResultStdErr);

  final exitCode = ExitCode(runResult.exitCode);

  print([
    if (runResultStdOut.isNotEmpty || runResultStdErr.isNotEmpty) "\n",
    if (exitCode.indicatesSuccess)
      "  SUCCEEDED"
    else
      "  FAILED with exit code $exitCode",
  ].join());

  return exitCode;
}

String _quoteArg(String arg) => arg.contains(" ") ? "\"$arg\"" : arg;

T _cast<T>(Object? value, {required T Function() otherwise}) =>
    value is T ? value : otherwise();

@immutable
class ExitCode {
  const ExitCode(this.value);

  @override
  String toString() => "$value";

  bool get indicatesSuccess => value == 0;

  final int value;
}
