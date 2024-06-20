part of 'supabase_service.dart';

extension GameRoomService on SupabaseService {
  Future<Map<String, dynamic>?> findWaitingRoom() async {
    try {
      final response = await supabase
          .from(GameroomSupabaseTable().tableName)
          .select()
          .eq('status', 'waiting')
          .single();
      return response;
    } on PostgrestException catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>> createRoom(String userId) async {
    final response = await supabase.from(GameroomSupabaseTable().tableName).insert({
      'status': 'waiting',
      'player1_id': userId,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    }).select();
    return response[0];
  }

  Future<void> joinRoom(String roomId, String userId) async {
    await supabase.from(GameroomSupabaseTable().tableName).update({
      'status': 'playing',
      'player2_id': userId,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', roomId);
  }

  Stream<Map<String, dynamic>> onRoomJoined(String roomId) {
    return supabase
        .from('gameroom:id=eq.$roomId')
        .stream(primaryKey: ['player2_id'])
        .map((data) => data.first);
  }
}
