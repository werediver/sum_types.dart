#!/bin/sh -e

cd hk && pub get && cd -
dart --enable-asserts hk/bin/main.dart
