import 'package:flutter_talkshare/core/values/supabase_table.dart';

class Gameword {
  final String id;
  final String roomId;
  final String word;
  final String userId;
  final int? createdAt;

  const Gameword({
    required this.id,
    required this.roomId,
    required this.word,
    required this.userId,
    this.createdAt,
  });

  static GamewordsSupabaseTable table = const GamewordsSupabaseTable();

  static Gameword fromJson(Map<String, dynamic> json) => Gameword(
        id: json[table.id] as String,
        roomId: json[table.roomId] as String,
        word: json[table.word] as String,
        userId: json[table.userId] as String,
        createdAt: json[table.createdAt] as int?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        table.id: id,
        table.roomId: roomId,
        table.word: word,
        table.userId: userId,
        table.createdAt: createdAt,
      };
}
