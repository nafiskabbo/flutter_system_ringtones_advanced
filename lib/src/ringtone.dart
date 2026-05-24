import 'dart:convert';

import 'package:equatable/equatable.dart';

/// A system sound entry returned from `FlutterSystemRingtones` list methods.
///
/// On Android, [uri] is a `content://` media URI (not a filesystem path).
/// Use a player such as `just_audio` or native `RingtoneManager` to play it.
class Ringtone extends Equatable {
  /// System-assigned sound identifier.
  final String id;

  /// User-visible display name of the sound.
  final String title;

  /// Android content URI for the sound (e.g. `content://media/.../42`).
  final String uri;

  /// Creates a [Ringtone] with the given [id], [title], and [uri].
  const Ringtone({
    required this.id,
    required this.title,
    required this.uri,
  });

  /// Builds a [Ringtone] from a map with `id`, `title`, and `uri` string keys.
  factory Ringtone.fromJson(Map<String, dynamic> map) => Ringtone(
        id: map['id'] as String,
        title: map['title'] as String,
        uri: map['uri'] as String,
      );

  /// Converts this ringtone to a JSON-serializable map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'uri': uri,
      };

  /// Decodes a JSON string produced by [toEncodedJson].
  factory Ringtone.fromEncodedJson(String encodedJson) =>
      Ringtone.fromJson(json.decode(encodedJson) as Map<String, dynamic>);

  /// Encodes this ringtone as a JSON string.
  String toEncodedJson() => json.encode(toJson());

  @override
  String toString() {
    return 'Ringtone{id: $id, title: $title, uri: $uri}';
  }

  @override
  List<Object?> get props => [id, title, uri];

  /// Returns a copy of this ringtone with the given fields replaced.
  Ringtone copyWith({
    String? id,
    String? title,
    String? uri,
  }) {
    return Ringtone(
      id: id ?? this.id,
      title: title ?? this.title,
      uri: uri ?? this.uri,
    );
  }
}
