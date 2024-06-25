import 'package:flutter_talkshare/core/values/supabase_table.dart';

class User {
  final String userId;
  final String fullname;
  final String avatarUrl;
  final String? password;

  const User({
    required this.userId,
    required this.fullname,
    required this.avatarUrl,
    this.password,
  });

  static UserSupabaseTable table = const UserSupabaseTable();

  static User fromJson(Map<String, dynamic> json) => User(
        userId: json[table.userId] as String,
        fullname: json[table.fullname] as String,
        avatarUrl: json[table.avatarUrl] as String,
        password: json[table.password] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        table.userId: userId,
        table.fullname: fullname,
        table.avatarUrl: avatarUrl,
        table.password: password,
      };
}
