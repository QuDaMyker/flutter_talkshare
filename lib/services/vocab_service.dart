part of 'supabase_service.dart';

extension VocabService on SupabaseService {
  Future<Vocab> getVocabByWord(String word) async {
    final response = await supabase
        .from(Vocab.table.tableName)
        .select()
        .eq(Vocab.table.word, word)
        .maybeSingle();
    final vocab = Vocab.fromJson(response as Map<String, dynamic>);
    return vocab;
  }
}
