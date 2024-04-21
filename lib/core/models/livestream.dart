import 'package:flutter_talkshare/core/values/supabase_table.dart';

class Livestream {
  final String streamId;
  final int? createdAt;
  final bool? isActive;
  final String userId;
  const Livestream(
      {required this.streamId,
      required this.userId,
      this.createdAt,
      this.isActive});

  static LivestreamSupabaseTable table = const LivestreamSupabaseTable();

  static Livestream fromJson(Map<String, dynamic> json) => Livestream(
        streamId: json[table.streamId] as String,
        userId: json[table.userId] as String,
        createdAt: int.parse(json[table.createdAt]) as int?,
        isActive: json[table.isActive] as bool?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        table.streamId: streamId,
        table.userId: userId,
        table.createdAt: createdAt,
        table.isActive: isActive,
      };
}
