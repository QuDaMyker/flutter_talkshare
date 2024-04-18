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

  Future<List<AudioRoom>> getAllAudioRoom() async {
    List<dynamic> res = await supabase
        .from(AudioRoom.table.tableName)
        .select()
        .eq(AudioRoom.table.isActive, true);
    List<AudioRoom> listRoom = res.map((e) => AudioRoom.fromJson(e)).toList();
    return listRoom;
  }
}
