// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FailModel {
  final String message;
  FailModel({
    required this.message,
  });

  FailModel copyWith({
    String? message,
  }) {
    return FailModel(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
    };
  }

  factory FailModel.fromMap(Map<String, dynamic> map) {
    return FailModel(
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FailModel.fromJson(String source) =>
      FailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FailModel(message: $message)';

  @override
  bool operator ==(covariant FailModel other) {
    if (identical(this, other)) return true;

    return other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
