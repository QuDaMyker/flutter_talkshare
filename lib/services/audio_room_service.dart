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

  Future<List<AudioRoom>> getAllAudioRoom({String? filter}) async {
    List<dynamic> res = await supabase
        .from(AudioRoom.table.tableName)
        .select()
        .eq(AudioRoom.table.isActive, true);
    List<AudioRoom> listRoom;
    if (filter != null) {
      if (filter == "Riêng tư") {
        listRoom = res
            .map((e) => AudioRoom.fromJson(e))
            .where((element) => element.passcode != null)
            .toList();
      } else if (filter == "Công khai") {
        listRoom = res
            .map((e) => AudioRoom.fromJson(e))
            .where((element) => element.passcode == null)
            .toList();
      } else {
        listRoom = res.map((e) => AudioRoom.fromJson(e)).toList();
      }
    } else {
      listRoom = res.map((e) => AudioRoom.fromJson(e)).toList();
    }
    return listRoom;
  }
}
