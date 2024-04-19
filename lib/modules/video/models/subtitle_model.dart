// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubtitleModel {
  final String? id;
  final String idVideo;
  final int index;
  final String content;
  final double start;
  final double duration;
  final double end;
  SubtitleModel({
    this.id,
    required this.idVideo,
    required this.index,
    required this.content,
    required this.start,
    required this.duration,
    required this.end,
  });

  SubtitleModel copyWith({
    String? id,
    String? idVideo,
    int? index,
    String? content,
    double? start,
    double? duration,
    double? end,
  }) {
    return SubtitleModel(
      id: id ?? this.id,
      idVideo: idVideo ?? this.idVideo,
      index: index ?? this.index,
      content: content ?? this.content,
      start: start ?? this.start,
      duration: duration ?? this.duration,
      end: end ?? this.end,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'id_video': idVideo,
      'index': index,
      'content': content,
      'start': start,
      'duration': duration,
      'end': end,
    };
  }

  factory SubtitleModel.fromMap(Map<String, dynamic> map) {
    return SubtitleModel(
      id: map['id'] as String,
      idVideo: map['id_video'] as String,
      index: map['index'] as int,
      content: map['content'] as String,
      start: map['start'] * 1.0 as double,
      duration: map['duration'] * 1.0 as double,
      end: map['end'] * 1.0 as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubtitleModel.fromJson(String source) =>
      SubtitleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubtitleModel(id: $id, idVideo: $idVideo, index: $index, content: $content, start: $start, duration: $duration, end: $end)';
  }

  @override
  bool operator ==(covariant SubtitleModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.idVideo == idVideo &&
        other.index == index &&
        other.content == content &&
        other.start == start &&
        other.duration == duration &&
        other.end == end;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idVideo.hashCode ^
        index.hashCode ^
        content.hashCode ^
        start.hashCode ^
        duration.hashCode ^
        end.hashCode;
  }
}
