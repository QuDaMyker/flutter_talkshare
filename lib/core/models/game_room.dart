import 'package:flutter_talkshare/core/values/supabase_table.dart';

class Gameroom {
  final String id;
  final String status;
  final String? player1Id;
  final String? player2Id;
  final String? winnerId;
  final int? createdAt;
  final int? updatedAt;

  const Gameroom({
    required this.id,
    required this.status,
    this.player1Id,
    this.player2Id,
    this.winnerId,
    this.createdAt,
    this.updatedAt,
  });

  static GameroomSupabaseTable table = const GameroomSupabaseTable();

  static Gameroom fromJson(Map<String, dynamic> json) => Gameroom(
        id: json[table.id] as String,
        status: json[table.status] as String,
        player1Id: json[table.player1Id] as String?,
        player2Id: json[table.player2Id] as String?,
        winnerId: json[table.winnerId] as String?,
        createdAt: json[table.createdAt] as int?,
        updatedAt: json[table.updatedAt] as int?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        table.id: id,
        table.status: status,
        table.player1Id: player1Id,
        table.player2Id: player2Id,
        table.winnerId: winnerId,
        table.createdAt: createdAt,
        table.updatedAt: updatedAt,
      };
}
