// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestTeacherModelReq {
  final String user_id;
  final String content;
  final String agent_name;
  final String teacher_id;
  RequestTeacherModelReq({
    required this.user_id,
    required this.content,
    required this.agent_name,
    required this.teacher_id,
  });

  RequestTeacherModelReq copyWith({
    String? user_id,
    String? content,
    String? agent_name,
    String? teacher_id,
  }) {
    return RequestTeacherModelReq(
      user_id: user_id ?? this.user_id,
      content: content ?? this.content,
      agent_name: agent_name ?? this.agent_name,
      teacher_id: teacher_id ?? this.teacher_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'content': content,
      'agent_name': agent_name,
      'teacher_id': teacher_id,
    };
  }

  factory RequestTeacherModelReq.fromMap(Map<String, dynamic> map) {
    return RequestTeacherModelReq(
      user_id: map['user_id'] as String,
      content: map['content'] as String,
      agent_name: map['agent_name'] as String,
      teacher_id: map['teacher_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestTeacherModelReq.fromJson(String source) =>
      RequestTeacherModelReq.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestTeacherModelReq(user_id: $user_id, content: $content, agent_name: $agent_name, teacher_id: $teacher_id)';
  }

  @override
  bool operator ==(covariant RequestTeacherModelReq other) {
    if (identical(this, other)) return true;

    return other.user_id == user_id &&
        other.content == content &&
        other.agent_name == agent_name &&
        other.teacher_id == teacher_id;
  }

  @override
  int get hashCode {
    return user_id.hashCode ^
        content.hashCode ^
        agent_name.hashCode ^
        teacher_id.hashCode;
  }
}
