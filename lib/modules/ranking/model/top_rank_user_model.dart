// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TopRankUserModel {
  final String id;
  final String user_id;
  final String fullname;
  final String avatar_url;
  final int sum_point;
  TopRankUserModel({
    required this.id,
    required this.user_id,
    required this.fullname,
    required this.avatar_url,
    required this.sum_point,
  });

  TopRankUserModel copyWith({
    String? id,
    String? user_id,
    String? fullname,
    String? avatar_url,
    int? sum_point,
  }) {
    return TopRankUserModel(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      fullname: fullname ?? this.fullname,
      avatar_url: avatar_url ?? this.avatar_url,
      sum_point: sum_point ?? this.sum_point,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'fullname': fullname,
      'avatar_url': avatar_url,
      'sum_point': sum_point,
    };
  }

  factory TopRankUserModel.fromMap(Map<String, dynamic> map) {
    return TopRankUserModel(
      id: map['id'] as String,
      user_id: map['user_id'] as String,
      fullname: map['users']['fullname'] as String,
      avatar_url: map['users']['avatar_url'] as String,
      sum_point: map['sum_point'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TopRankUserModel.fromJson(String source) =>
      TopRankUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TopRankUserModel(id: $id, user_id: $user_id, fullname: $fullname, avatar_url: $avatar_url, sum_point: $sum_point)';
  }

  @override
  bool operator ==(covariant TopRankUserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user_id == user_id &&
        other.fullname == fullname &&
        other.avatar_url == avatar_url &&
        other.sum_point == sum_point;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user_id.hashCode ^
        fullname.hashCode ^
        avatar_url.hashCode ^
        sum_point.hashCode;
  }
}
