## 0.3.3

- Fix a few warnings in the generated code
- Remove the use of `dynamic` type in the generator and the generated code

## 0.3.2

- Update `analyzer` constraint to `'>=2.0.0 <5.0.0'`
- Update `housekeeper` to use `dart pub` and `dart run`
- Drop `dependency_validator` command line parameters (they seem to not be needed anymore)

## 0.3.1

- Depend on `analyser` ^2.0.0

## 0.3.0

- Adopt Dart 2.12 / Flutter 2 null-safety

## 0.2.1+3

- Allow "analyzer" versions up to 0.42.0

## 0.2.1+2

- Make sure no `dependency_overrides` are used in the example project

## 0.2.1+1

- Allow "analyzer" versions below 0.40.0

## 0.2.1

- Fix `load(·)` method generation.

## 0.2.0+1

- Fix inter-package dependencies.

## 0.2.0

- This is a major update with backward-incompatible changes!
- Implement a new generation scheme with user-defined top-level classes. The new scheme improves interoperability with other code generators and simplifies sum-type annotations a lot.

## 0.1.5+1

- Update README.md.

## 0.1.5

- Support generic sum-types.
- Restructure the example project.

## 0.1.4

- Allow nesting sum-types (by mentioning anchors).
- Stop using `dynamic` and `Null` as empty-case markers, use only `void`.

## 0.1.3

- Support serialization-deserialization of the generated sum-types through interoperability with user-defined product-types (`XRecordBase<Self>`, `X.dump(·)`, `X.load(·)`)

## 0.1.2+4

- Update README.md and the package description.

## 0.1.2+3

- Attempt to not publish uncommited changes.

## 0.1.2+2

- Extend README.md.
- Include analysis_options.yaml.

## 0.1.2+1

- Relax dependency constraints to improve compatibility.

## 0.1.2

- Integrate an example into the package.

## 0.1.1

- Include a change-log file.

## 0.1.0

- Define the annotations for `sum_types_generator`.
- Include `Unit` type, required by the generator.
