// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CaptionResponse {
  int? index;
  double? start;
  double? dur;
  double? end;
  String? text;
  CaptionResponse({
    required this.index,
    required this.start,
    required this.dur,
    required this.end,
    required this.text,
  });

  CaptionResponse copyWith({
    int? index,
    double? start,
    double? dur,
    double? end,
    String? text,
  }) {
    return CaptionResponse(
      index: index ?? this.index,
      start: start ?? this.start,
      dur: dur ?? this.dur,
      end: end ?? this.end,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'index': index,
      'start': start,
      'dur': dur,
      'end': end,
      'text': text,
    };
  }

  factory CaptionResponse.fromMap(Map<String, dynamic> map) {
    return CaptionResponse(
      index: map['index'] != null ? map['index'] as int : null,
      start: map['start'] != null ? map['start'] as double : null,
      dur: map['dur'] != null ? map['dur'] as double : null,
      end: map['end'] != null ? map['end'] as double : null,
      text: map['text'] != null ? map['text'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CaptionResponse.fromJson(String source) =>
      CaptionResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CaptionResponse(index: $index, start: $start, dur: $dur, end: $end, text: $text)';
  }

  @override
  bool operator ==(covariant CaptionResponse other) {
    if (identical(this, other)) return true;

    return other.index == index &&
        other.start == start &&
        other.dur == dur &&
        other.end == end &&
        other.text == text;
  }

  @override
  int get hashCode {
    return index.hashCode ^
        start.hashCode ^
        dur.hashCode ^
        end.hashCode ^
        text.hashCode;
  }
}
