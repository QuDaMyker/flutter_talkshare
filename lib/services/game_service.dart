part of 'supabase_service.dart';

extension GameRoomService on SupabaseService {
  Future<Map<String, dynamic>?> findWaitingRoom() async {
    try {
      final response = await supabase
          .from(GameroomSupabaseTable().tableName)
          .select()
          .eq('status', 'waiting')
          .eq('israndom', true)
          .single();
      return response;
    } on PostgrestException catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>> createRoom(String userId,
      {bool isRandom = false}) async {
    final response =
        await supabase.from(GameroomSupabaseTable().tableName).insert({
      'status': 'waiting',
      'player1_id': userId,
      'israndom': isRandom,
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
        .stream(primaryKey: ['player2_id']).map((data) => data.first);
  }

  Future<void> sendInvitation(
      String fromUserId, String toUserId, String roomId) async {
    await supabase.from('invitations').insert({
      'from_user_id': fromUserId,
      'to_user_id': toUserId,
      'room_id': roomId,
      'status': 'pending',
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> acceptInvitation(String invitationId) async {
    await supabase.from('invitations').update({
      'status': 'accepted',
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', invitationId);
  }

  Future<void> declineInvitation(String invitationId) async {
    await supabase.from('invitations').update({
      'status': 'declined',
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', invitationId);
  }

  Future<void> cancelInvitation(String invitationId) async {
    await supabase.from('invitations').delete().eq('id', invitationId);
  }

  Stream<Map<String, dynamic>> onAcceptInvitation(String invitationId) {
    return supabase
        .from('invitations:id=eq.$invitationId')
        .stream(primaryKey: ['status'])
        .eq('status', 'accepted')
        .map((data) => data.first);
  }

  Stream<Map<String, dynamic>> onDeclineInvitation(String invitationId) {
    return supabase
        .from('invitations:id=eq.$invitationId')
        .stream(primaryKey: ['status'])
        .eq('status', 'declined')
        .map((data) => data.first);
  }

  Stream<Map<String, dynamic>> onCancelInvitation(String invitationId) {
    return supabase
        .from('invitations:id=eq.$invitationId')
        .stream(primaryKey: ['id']).map((data) => data.first);
  }

  Stream<Map<String, dynamic>> onReceiveInvitation(String userId) {
    return supabase
        .from('invitations:to_user_id=eq.$userId')
        .stream(primaryKey: ['id'])
        .eq('status', 'pending')
        .map((data) => data.first);
  }

  Future<List<Map<String, dynamic>>> getInvitations(String userId) async {
    final response =
        await supabase.from('invitations').select().eq('to_user_id', userId);
    return response;
  }

  Future<void> sendMessage(String roomId, String userId, String word) async {
    await supabase.from(GamewordsSupabaseTable().tableName).insert({
      'room_id': roomId,
      'user_id': userId,
      'word': word,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Stream<Map<String, dynamic>> onReceiveMessage(String roomId) {
    return supabase
        .from('${GamewordsSupabaseTable().tableName}:room_id=eq.$roomId')
        .stream(primaryKey: ['id'])
        .map((data) => data.first);
  }
}
