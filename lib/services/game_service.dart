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
      {bool isRandom = false, String? code}) async {
    if (code != null) {
      final existingRoom = await supabase
          .from(GameroomSupabaseTable().tableName)
          .select('id')
          .eq('code', code)
          .eq('status', 'waiting');
      if (existingRoom.length > 0) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: const Text('Phòng đã tồn tại'),
          ),
        );
        return {};
      }
    }

    final response =
        await supabase.from(GameroomSupabaseTable().tableName).insert({
      'status': 'waiting',
      'player1_id': userId,
      'israndom': isRandom,
      'code': code,
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
        .from('gameroom')
        .stream(primaryKey: ['id'])
        .eq('id', roomId)
        .map((data) => data.first);
  }

  Future<void> endGame(String roomId, String? winnerId) async {
    await supabase.from(GameroomSupabaseTable().tableName).update({
      'status': 'ended',
      'winner_id': winnerId,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', roomId);
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
        .from('${GamewordsSupabaseTable().tableName}')
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .order('created_at', ascending: false)
        .limit(1)
        .map((data) => data.first);
  }

  Future<String?> getRoomIdByCode(String code) async {
    final response = await supabase
        .from(GameroomSupabaseTable().tableName)
        .select('id')
        .eq('code', code)
        .eq('status', 'waiting')
        .single();

    return response['id'] as String?;
  }

  Future<UserModel?> getUserById(String userId) async {
    final response = UserModel.fromMap(await supabase
        .from(UserSupabaseTable().tableName)
        .select()
        .eq('user_id', userId)
        .single());

    return response;
  }

  Future<String?> getPlayerIdByRoomId(String roomId, bool isPlayer2) async {
    final response = await supabase
        .from(GameroomSupabaseTable().tableName)
        .select(isPlayer2 ? 'player1_id' : 'player2_id')
        .eq('id', roomId)
        .single();

    return isPlayer2
        ? response['player1_id'] as String?
        : response['player2_id'] as String?;
  }

  Future<Map<String, int>> getUserWinsAndLosses(String userId) async {
    final winsResponse = await supabase
        .from(GameroomSupabaseTable().tableName)
        .select('id')
        .eq('winner_id', userId)
        .count(CountOption.exact);

    int wins = winsResponse.count;

    final lossesResponse = await supabase
        .from(GameroomSupabaseTable().tableName)
        .select('id')
        .or('player1_id.eq.$userId,player2_id.eq.$userId')
        .neq('winner_id', userId)
        .not('winner_id', 'is', null)
        .count(CountOption.exact);

    int losses = lossesResponse.count;

    return {
      'wins': wins,
      'losses': losses,
    };
  }
}
