# flutter_system_ringtones_advanced

[![pub package](https://img.shields.io/pub/v/flutter_system_ringtones_advanced.svg?logo=dart)](https://pub.dev/packages/flutter_system_ringtones_advanced) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter plugin to list system **ringtones**, **alarms**, and **notification** sounds on **Android** using `RingtoneManager`.

Community-maintained fork of [imedboumalek/flutter_system_ringtones](https://github.com/imedboumalek/flutter_system_ringtones), republished as **`flutter_system_ringtones_advanced`** on [pub.dev](https://pub.dev/packages/flutter_system_ringtones_advanced) because the upstream maintainer is no longer accepting pull requests.

## Platform support

| Platform | Supported | Notes |
| --- | --- | --- |
| **Android** | Yes | API 16+. Lists tones via `RingtoneManager`. |
| **iOS** | No | Apple does not expose a supported public API to enumerate user/system ringtones for third-party apps. Use `FlutterSystemRingtones.isSupported` (false on iOS); API calls return an empty list without invoking the method channel. |
| Web / desktop | No | Returns an empty list. |

### Why no iOS?

iOS does not provide an equivalent of Android’s `RingtoneManager`. The original upstream plugin returned a **platform version string** from iOS, which caused:

`type 'String' is not a subtype of type 'List?' in type cast`

when calling `getNotificationSounds()` / similar methods ([upstream issue discussion](https://github.com/imedboumalek/flutter_system_ringtones/issues/2)). This package removes iOS from the plugin and guards the Dart API so non-Android platforms never hit that failure mode.

Scanning private system sound directories is fragile, simulator-incompatible, and generally **not App Store–safe**; it is intentionally out of scope.

## Installation

```yaml
dependencies:
  flutter_system_ringtones_advanced: ^2.0.2
```

```bash
flutter pub get
```

### Migrating from `flutter_system_ringtones`

```yaml
dependencies:
  flutter_system_ringtones_advanced: ^2.0.2
```

```dart
import 'package:flutter_system_ringtones_advanced/flutter_system_ringtones_advanced.dart';
```

The Dart API (`FlutterSystemRingtones`, `Ringtone`) is unchanged on Android.

## Requirements

| | Minimum |
| --- | --- |
| Dart | 3.0+ |
| Flutter | 3.10+ |
| Android | API 16+ |

No extra Android permissions are required to **list** built-in tones.

## Usage

```dart
import 'package:flutter_system_ringtones_advanced/flutter_system_ringtones_advanced.dart';

if (FlutterSystemRingtones.isSupported) {
  final ringtones = await FlutterSystemRingtones.getRingtoneSounds();
  final alarms = await FlutterSystemRingtones.getAlarmSounds();
  final notifications = await FlutterSystemRingtones.getNotificationSounds();
}
```

Each method returns `List<Ringtone>` (never `null`; empty when unsupported or when none are found).

### `Ringtone` fields

| Field | Description |
| --- | --- |
| `id` | System sound ID |
| `title` | Display name |
| `uri` | Android **content URI** (e.g. `content://media/internal/audio/media/42`) |

`Ringtone` implements `Equatable` and supports `copyWith`, JSON encoding, etc.

## Playing a selected sound on Android

The `uri` value is a **`content://` URI**, not a filesystem path. You usually **cannot** convert it to a stable absolute file path for all devices/OEMs. Play it through Android’s content resolver instead.

### Option 1: `just_audio` (recommended)

```yaml
dependencies:
  just_audio: ^0.10.4
```

```dart
import 'package:just_audio/just_audio.dart';

final player = AudioPlayer();
await player.setUrl(ringtone.uri); // content://...
await player.play();
```

### Option 2: `audioplayers`

```dart
import 'package:audioplayers/audioplayers.dart';

final player = AudioPlayer();
await player.play(UrlSource(ringtone.uri));
```

### Option 3: native `RingtoneManager` (Android only)

In Kotlin/Java:

```kotlin
val uri = Uri.parse(ringtoneUriString)
val ringtone = RingtoneManager.getRingtone(context, uri)
ringtone.play()
```

If playback fails, confirm the URI is still valid (user may have removed the sound) and that you are not assuming a `/storage/...` file path.

## Example

```bash
cd example
flutter run
```

On Android you will see device ringtones; on iOS the example compiles but lists nothing and shows an informational banner.

## FAQ

### How do I get a “real” file path from `uri`? ([#3](https://github.com/nafiskabbo/flutter_system_ringtones_advanced/issues/3))

For many media tones there is **no** portable absolute path—only a `content://` URI. Use one of the playback options above. To copy bytes to your app sandbox (advanced), use Android `ContentResolver.openInputStream(Uri.parse(uri))` in platform code; that is not built into this plugin.

### Does this support iOS? ([#2](https://github.com/nafiskabbo/flutter_system_ringtones_advanced/issues/2))

No. See [Platform support](#platform-support) above.

## Issues

[GitHub Issues](https://github.com/nafiskabbo/flutter_system_ringtones_advanced/issues)

## License

MIT — see [LICENSE](LICENSE). Original work Copyright (c) 2022 Imed Boumalek.
