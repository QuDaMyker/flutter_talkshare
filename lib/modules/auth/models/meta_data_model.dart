// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MetaDataModel {
  final String avatarUrl;
  final String email;
  final bool emailVerified;
  final String fullName;
  final String iss;
  final String name;
  final bool phoneVerified;
  final String picture;
  final String providerId;
  final String sub;
  MetaDataModel({
    required this.avatarUrl,
    required this.email,
    required this.emailVerified,
    required this.fullName,
    required this.iss,
    required this.name,
    required this.phoneVerified,
    required this.picture,
    required this.providerId,
    required this.sub,
  });

  MetaDataModel copyWith({
    String? avatarUrl,
    String? email,
    bool? emailVerified,
    String? fullName,
    String? iss,
    String? name,
    bool? phoneVerified,
    String? picture,
    String? providerId,
    String? sub,
  }) {
    return MetaDataModel(
      avatarUrl: avatarUrl ?? this.avatarUrl,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      fullName: fullName ?? this.fullName,
      iss: iss ?? this.iss,
      name: name ?? this.name,
      phoneVerified: phoneVerified ?? this.phoneVerified,
      picture: picture ?? this.picture,
      providerId: providerId ?? this.providerId,
      sub: sub ?? this.sub,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'avatarUrl': avatarUrl,
      'email': email,
      'emailVerified': emailVerified,
      'fullName': fullName,
      'iss': iss,
      'name': name,
      'phoneVerified': phoneVerified,
      'picture': picture,
      'providerId': providerId,
      'sub': sub,
    };
  }

  factory MetaDataModel.fromMap(Map<String, dynamic> map) {
    return MetaDataModel(
      avatarUrl: map['avatar_url'] as String,
      email: map['email'] as String,
      emailVerified: map['email_verified'] as bool,
      fullName: map['full_name'] as String,
      iss: map['iss'] as String,
      name: map['name'] as String,
      phoneVerified: map['phone_verified'] as bool,
      picture: map['picture'] as String,
      providerId: map['provider_id'] as String,
      sub: map['sub'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MetaDataModel.fromJson(String source) =>
      MetaDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MetaDataModel(avatarUrl: $avatarUrl, email: $email, emailVerified: $emailVerified, fullName: $fullName, iss: $iss, name: $name, phoneVerified: $phoneVerified, picture: $picture, providerId: $providerId, sub: $sub)';
  }

  @override
  bool operator ==(covariant MetaDataModel other) {
    if (identical(this, other)) return true;

    return other.avatarUrl == avatarUrl &&
        other.email == email &&
        other.emailVerified == emailVerified &&
        other.fullName == fullName &&
        other.iss == iss &&
        other.name == name &&
        other.phoneVerified == phoneVerified &&
        other.picture == picture &&
        other.providerId == providerId &&
        other.sub == sub;
  }

  @override
  int get hashCode {
    return avatarUrl.hashCode ^
        email.hashCode ^
        emailVerified.hashCode ^
        fullName.hashCode ^
        iss.hashCode ^
        name.hashCode ^
        phoneVerified.hashCode ^
        picture.hashCode ^
        providerId.hashCode ^
        sub.hashCode;
  }
}
