## 2.0.0

- **Android-only:** removes iOS plugin implementation (Apple provides no supported public API to list system ringtones; see README)
- **Fix:** reload ringtone/alarm/notification lists on each request instead of caching at engine attach (fresh data after user changes system sounds)
- **Fix:** handle empty `RingtoneManager` cursors without crashing
- **Fix:** harden Dart parsing when native returns a non-`List` (addresses upstream `String` vs `List` cast crash on iOS)
- **API:** `FlutterSystemRingtones.isSupported` is `true` only on Android; other platforms return `[]` without calling the method channel
- **Docs:** add guidance for playing sounds via `content://` URIs ([#3](https://github.com/nafiskabbo/flutter_system_ringtones_advanced/issues/3))

## 1.0.0

- **Package renamed** to [`flutter_system_ringtones_advanced`](https://pub.dev/packages/flutter_system_ringtones_advanced) for independent publication on pub.dev
- **Fork lineage:** community-maintained continuation of [imedboumalek/flutter_system_ringtones](https://github.com/imedboumalek/flutter_system_ringtones)
- **Maintainer:** [Nafis Kabbo](mailto:nafiskabbo30@gmail.com)
- **Breaking:** publish under new package name; import `package:flutter_system_ringtones_advanced/flutter_system_ringtones_advanced.dart`
- Migrates Android build to Kotlin DSL with built-in Kotlin support (Flutter 3.44+ and pre-3.44 / AGP 8–9 compatible)
- Adds iOS Swift Package Manager (SPM) support alongside CocoaPods
- Updates Android namespace to `com.kabbodev.flutter_system_ringtones`
- Updates iOS deployment target to 13.0

## 0.0.6

- Added Equatable and copyWith

## 0.0.5

- reverted "Updated `Ringtone` to `SystemSound`"

## 0.0.4

- update `fromMap` to `fromJson`
- update `toMap` to `toJson`
- Added encoding/decoding for fromJson/toJson methods.
- Updated `Ringtone` to `SystemSound`

## 0.0.3

- Methods now return an empty array if no results are found.
- Plugin methods are now static access only.
- Methods have a more descriptive name.

## 0.0.2

updated README.md

## 0.0.1

-get available systems sounds on Android
