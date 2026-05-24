# flutter_system_ringtones_advanced

[![pub package](https://img.shields.io/pub/v/flutter_system_ringtones_advanced.svg?logo=dart)](https://pub.dev/packages/flutter_system_ringtones_advanced) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter plugin to list system **ringtones**, **alarms**, and **notification** sounds using native APIs on Android. iOS listing is not implemented yet and returns empty lists.

Community-maintained fork of [imedboumalek/flutter_system_ringtones](https://github.com/imedboumalek/flutter_system_ringtones), republished as **`flutter_system_ringtones_advanced`** on [pub.dev](https://pub.dev/packages/flutter_system_ringtones_advanced) because the upstream maintainer is no longer accepting pull requests.

## Installation

Add `flutter_system_ringtones_advanced` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_system_ringtones_advanced: ^1.0.0
```

Then run:

```bash
flutter pub get
```

### Migrating from `flutter_system_ringtones`

Replace the dependency and update imports:

```yaml
# Before
# flutter_system_ringtones: ^0.0.6

dependencies:
  flutter_system_ringtones_advanced: ^1.0.0
```

```dart
// Before
// import 'package:flutter_system_ringtones/flutter_system_ringtones.dart';

import 'package:flutter_system_ringtones_advanced/flutter_system_ringtones_advanced.dart';
```

The Dart API (`FlutterSystemRingtones`, `Ringtone`) is unchanged; only the package name and import path differ.

## Requirements

| | Minimum |
| --- | --- |
| Dart | 3.0+ |
| Flutter | 3.10+ |
| Android | API 16+ |
| iOS | 13.0+ |

## Usage

Import the package:

```dart
import 'package:flutter_system_ringtones_advanced/flutter_system_ringtones_advanced.dart';
```

### List ringtones

```dart
final List<Ringtone> ringtones =
    await FlutterSystemRingtones.getRingtoneSounds();

for (final ringtone in ringtones) {
  print('${ringtone.title} → ${ringtone.uri}');
}
```

### List alarm sounds

```dart
final List<Ringtone> alarms =
    await FlutterSystemRingtones.getAlarmSounds();
```

### List notification sounds

```dart
final List<Ringtone> notifications =
    await FlutterSystemRingtones.getNotificationSounds();
```

All three methods return an **empty list** when the platform has no sounds or when the native side returns nothing (never `null`).

### `Ringtone` model

Each item has:

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` | System sound ID |
| `title` | `String` | Display name |
| `uri` | `String` | Content URI you can pass to a media player |

`Ringtone` implements `Equatable` and supports `copyWith`, `toJson` / `fromJson`, and `toEncodedJson` / `fromEncodedJson`.

```dart
final encoded = ringtone.toEncodedJson();
final restored = Ringtone.fromEncodedJson(encoded);
```

## Platform support

| Feature | Android | iOS |
| --- | --- | --- |
| Ringtones | Supported | Not implemented (empty list) |
| Alarms | Supported | Not implemented (empty list) |
| Notifications | Supported | Not implemented (empty list) |

On Android, sounds are loaded via `RingtoneManager` when the plugin attaches to the engine. No extra permissions are required for listing built-in tones.

### iOS

Dynamic system sound listing on iOS is **not implemented** in this release. Calls succeed but return `[]`. See [GitHub issues](https://github.com/nafiskabbo/flutter_system_ringtones_advanced/issues) for progress.

## Example

See the [example](example/) app for a simple list UI that loads ringtones on Android.

```bash
cd example
flutter run
```

## Issues

Please file bugs and feature requests on [GitHub](https://github.com/nafiskabbo/flutter_system_ringtones_advanced/issues).

## License

MIT — see [LICENSE](LICENSE). Original work Copyright (c) 2022 Imed Boumalek.
