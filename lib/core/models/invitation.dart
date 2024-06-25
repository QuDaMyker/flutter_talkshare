import 'package:flutter_talkshare/core/values/supabase_table.dart';

class Invitation {
  final String id;
  final String fromUserId;
  final String toUserId;
  final String roomId;
  final String status;
  final int? createdAt;

  const Invitation({
    required this.id,
    required this.fromUserId,
    required this.toUserId,
    required this.roomId,
    required this.status,
    this.createdAt,
  });

  static InvitationsSupabaseTable table = const InvitationsSupabaseTable();

  static Invitation fromJson(Map<String, dynamic> json) => Invitation(
        id: json[table.id] as String,
        fromUserId: json[table.fromUserId] as String,
        toUserId: json[table.toUserId] as String,
        roomId: json[table.roomId] as String,
        status: json[table.status] as String,
        createdAt: json[table.createdAt] as int?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        table.id: id,
        table.fromUserId: fromUserId,
        table.toUserId: toUserId,
        table.roomId: roomId,
        table.status: status,
        table.createdAt: createdAt,
      };
}
