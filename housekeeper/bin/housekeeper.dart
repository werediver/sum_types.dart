import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

void main(List<String> args) {
  var success = true;
  final pkgDirs = findPkgDirs(Directory.current, withSourceDirs: true);
  for (final pkgDir in pkgDirs) {
    success = run("pub", ["get"], workingDirectory: pkgDir.path).indicatesSuccess && success;
  }
  if (success) {
    for (final pkgDir in pkgDirs) {
      success =
          run("pub", ["run", "dependency_validator", "--ignore", "sum_types_generator"], workingDirectory: pkgDir.path)
                  .indicatesSuccess &&
              success;
    }
  }
  if (success) {
    for (final pkgDir in pkgDirs) {
      success = run("dartanalyzer", ["."], workingDirectory: pkgDir.path).indicatesSuccess && success;
    }
  }
  if (success) {
    success = run("dartfmt", ["--set-exit-if-changed", "-n", "."]).indicatesSuccess && success;
  }

  print("\n  OVERALL: ${success ? "SUCCEEDED" : "FAILED"}");

  exit(success ? 0 : 1);
}

Iterable<Directory> findPkgDirs(Directory root, {bool withSourceDirs = false}) {
  const pubspec = "pubspec.yaml";
  bool subdirExists(String base, String sub) => Directory(p.join(base, sub)).existsSync();
  return root
      .listSync(recursive: true)
      .expand((entity) => [
            if (p.basename(entity.path) == pubspec) Directory(p.dirname(entity.path)),
          ])
      .where((pkgDir) => !withSourceDirs || subdirExists(pkgDir.path, "lib") || subdirExists(pkgDir.path, "bin"));
}

ExitCode run(String exe, List<String> args, {String workingDirectory}) {
  print([
    "\n",
    "  In ",
    if (workingDirectory != null) "${quoteArg(p.relative(workingDirectory))}\n" else ".\n",
    "  Running $exe ${args.map(quoteArg).join(" ")}\n",
  ].join());

  final runResult = Process.runSync(exe, args, workingDirectory: workingDirectory);

  final runResultStdOut = cast<String>(runResult.stdout, otherwise: () => "");
  final runResultStdErr = cast<String>(runResult.stderr, otherwise: () => "");
  stdout.write(runResultStdOut);
  stderr.write(runResultStdErr);

  final exitCode = ExitCode(runResult.exitCode);

  print([
    if (runResultStdOut.isNotEmpty || runResultStdErr.isNotEmpty) "\n",
    if (exitCode.indicatesSuccess) "  SUCCEEDED" else "  FAILED with exit code $exitCode",
  ].join());

  return exitCode;
}

String quoteArg(String arg) => arg.contains(" ") ? "\"$arg\"" : arg;

T cast<T>(dynamic value, {@required T Function() otherwise}) => value is T ? value : otherwise();

@immutable
class ExitCode {
  const ExitCode(this.value);

  @override
  String toString() => "$value";

  bool get indicatesSuccess => value == 0;

  final int value;
}
