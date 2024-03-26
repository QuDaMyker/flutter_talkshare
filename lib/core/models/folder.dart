import 'package:flutter_talkshare/core/values/supabase_table.dart';

class Folder {
  final String folderId;
  final String name;
  final String userId;

  const Folder({
    required this.folderId,
    required this.name,
    required this.userId,
  });

  static FolderSupabaseTable table = const FolderSupabaseTable();

  static Folder fromJson(Map<String, dynamic> json) => Folder(
        folderId: json[table.folderId] as String,
        name: json[table.name] as String,
        userId: json[table.userId] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        table.folderId: folderId,
        table.name: name,
        table.userId: userId,
      };
}