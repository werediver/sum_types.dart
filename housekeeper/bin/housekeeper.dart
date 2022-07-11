import 'dart:io';

import 'package:housekeeper/run.dart';
import 'package:path/path.dart' as p;

void main(List<String> args) {
  var success = true;
  final pkgDirs = findPkgDirs(Directory.current, withSourceDirs: true);
  for (final pkgDir in pkgDirs) {
    success = run("dart", ["pub", "get"], workingDirectory: pkgDir.path)
            .indicatesSuccess &&
        success;
  }
  if (success) {
    for (final pkgDir in pkgDirs) {
      success = run(
            "dart",
            [
              "run",
              "dependency_validator",
            ],
            workingDirectory: pkgDir.path,
          ).indicatesSuccess &&
          success;
    }
  }
  if (success) {
    success = run(
          "dart",
          [
            "run",
            "--enable-asserts",
            "build_runner",
            "build",
            "--delete-conflicting-outputs",
          ],
          workingDirectory: "example",
        ).indicatesSuccess &&
        success;
  }
  if (success) {
    for (final pkgDir in pkgDirs) {
      success = run(
            "dart",
            ["analyze", "."],
            workingDirectory: pkgDir.path,
          ).indicatesSuccess &&
          success;
    }
  }
  if (success) {
    success = run(
          "dart",
          [
            "format",
            "--set-exit-if-changed",
            ".",
          ],
        ).indicatesSuccess &&
        success;
  }

  print("\n  OVERALL: ${success ? "SUCCEEDED" : "FAILED"}");

  exit(success ? 0 : 1);
}

Iterable<Directory> findPkgDirs(Directory root, {bool withSourceDirs = false}) {
  const pubspec = "pubspec.yaml";
  bool subdirExists(String base, String sub) =>
      Directory(p.join(base, sub)).existsSync();
  return root
      .listSync(recursive: true, followLinks: false)
      .expand((entity) => [
            if (p.basename(entity.path) == pubspec)
              Directory(p.dirname(entity.path)),
          ])
      .where((pkgDir) =>
          !withSourceDirs ||
          subdirExists(pkgDir.path, "lib") ||
          subdirExists(pkgDir.path, "bin"));
}
