import 'package:flutter_talkshare/core/values/supabase_table.dart';

class WordSet {
  final String wordsetId;
  final String name;
  final String avatarUrl;
  final String userId;
  final String? folderId;
  final int? count;

  const WordSet({
    required this.wordsetId,
    required this.name,
    required this.avatarUrl,
    required this.userId,
    this.folderId,
    this.count = 0,
  });
  WordSet copyWith({int? count}) {
    return WordSet(
        wordsetId: wordsetId,
        name: name,
        avatarUrl: avatarUrl,
        userId: userId,
        count: count ?? this.count);
  }

  static WordSetSupabaseTable table = const WordSetSupabaseTable();

  static WordSet fromJson(Map<String, dynamic> json) => WordSet(
        wordsetId: json[table.wordsetId] as String,
        name: json[table.name] as String,
        avatarUrl: json[table.avatarUrl] as String,
        userId: json[table.userId] as String,
        folderId: json[table.folderId] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        table.wordsetId: wordsetId,
        table.name: name,
        table.avatarUrl: avatarUrl,
        table.userId: userId,
        table.folderId: folderId,
      };
}
