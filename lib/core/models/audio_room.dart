import 'package:flutter_talkshare/core/values/supabase_table.dart';

class AudioRoom {
  final String roomId;
  final String name;
  final String topic;
  final int quantity;
  final int? passcode;
  final int? createdAt;
  final bool? isActive;
  final String userId;
  const AudioRoom(
      {required this.roomId,
      required this.name,
      required this.topic,
      required this.quantity,
      required this.userId,
      this.passcode,
      this.createdAt,
      this.isActive});

  static AudioRoomSupabaseTable table = const AudioRoomSupabaseTable();

  static AudioRoom fromJson(Map<String, dynamic> json) => AudioRoom(
        roomId: json[table.roomId] as String,
        name: json[table.name] as String,
        topic: json[table.topic] as String,
        quantity: json[table.quantity] as int,
        userId: json[table.userId] as String,
        passcode: json[table.passcode] as int?,
        createdAt: json[table.createdAt] as int?,
        isActive: json[table.isActive] as bool?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        table.roomId: roomId,
        table.name: name,
        table.topic: topic,
        table.quantity: quantity,
        table.userId: userId,
        table.passcode: passcode,
        table.createdAt: createdAt,
        table.isActive: isActive,
      };
}
