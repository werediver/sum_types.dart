## Example

A `sum_types` and `sum_types_generator` packages usage example.

## Running

### With Dart SDK

As usual, run `dart pub get` first, then `dart run example:main`.

### With Flutter SDK

As usual, run `flutter pub get` first, then `flutter pub run example:main`.

## Hacking

Add the following lines to [pubspec.yaml](pubspec.yaml) to use the local versions
of `sum_types` and `sum_types_generator`:

```yaml
dependency_overrides:
  sum_types:
    path: ../sum_types
  sum_types_generator:
    path: ../sum_types_generator
```
