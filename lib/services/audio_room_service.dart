part of 'supabase_service.dart';

extension AudioRoomService on SupabaseService {
  Future<void> insertRoom(AudioRoom room) async {
    await supabase.from(AudioRoom.table.tableName).insert(room.toJson());
  }

  Future<void> endRoom(String roomId) async {
    await supabase
        .from(AudioRoom.table.tableName)
        .update({AudioRoom.table.isActive: false}).match(
            {AudioRoom.table.roomId: roomId});
  }
}
