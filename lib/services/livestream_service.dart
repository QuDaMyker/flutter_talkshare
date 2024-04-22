part of 'supabase_service.dart';

extension LivestreamService on SupabaseService {
  Future<void> insertLivestream(Livestream stream) async {
    await supabase.from(Livestream.table.tableName).insert(stream.toJson());
  }

  Future<void> endStream(String streamId) async {
    await supabase
        .from(Livestream.table.tableName)
        .update({Livestream.table.isActive: false}).match(
            {Livestream.table.streamId: streamId});
  }

  Future<List<Livestream>> getAllLivestream() async {
    List<dynamic> res = await supabase
        .from(Livestream.table.tableName)
        .select()
        .eq(Livestream.table.isActive, true);
    List<Livestream> listStream =
        res.map((e) => Livestream.fromJson(e)).toList();
    return listStream;
  }
}
