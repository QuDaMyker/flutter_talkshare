// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String user_id;
  final String fullname;
  final String avatar_url;
  final String password;
  final String email;
  final bool isGoogle;
  final String role;
  UserModel({
    required this.user_id,
    required this.fullname,
    required this.avatar_url,
    this.password = '',
    required this.email,
    required this.isGoogle,
    required this.role,
  });

  UserModel copyWith({
    String? user_id,
    String? fullname,
    String? avatar_url,
    String? password,
    String? email,
    bool? isGoogle,
    String? role,
  }) {
    return UserModel(
      user_id: user_id ?? this.user_id,
      fullname: fullname ?? this.fullname,
      avatar_url: avatar_url ?? this.avatar_url,
      password: password ?? this.password,
      email: email ?? this.email,
      isGoogle: isGoogle ?? this.isGoogle,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'fullname': fullname,
      'avatar_url': avatar_url,
      'password': password,
      'email': email,
      'isGoogle': isGoogle,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      user_id: map['user_id'] as String,
      fullname: map['fullname'] as String,
      avatar_url: map['avatar_url'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      isGoogle: map['isGoogle'] as bool,
      role: map['role'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(user_id: $user_id, fullname: $fullname, avatar_url: $avatar_url, password: $password, email: $email, isGoogle: $isGoogle, role: $role)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.user_id == user_id &&
        other.fullname == fullname &&
        other.avatar_url == avatar_url &&
        other.password == password &&
        other.email == email &&
        other.isGoogle == isGoogle &&
        other.role == role;
  }

  @override
  int get hashCode {
    return user_id.hashCode ^
        fullname.hashCode ^
        avatar_url.hashCode ^
        password.hashCode ^
        email.hashCode ^
        isGoogle.hashCode ^
        role.hashCode;
  }
}
