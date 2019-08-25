#!/bin/sh -e

cd housekeeper && pub get && cd -
dart --enable-asserts housekeeper/bin/main.dart
