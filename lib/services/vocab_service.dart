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
    //cho phép lưu dưới 10 từ
    Future<void> saveVocabToSharedPreferences(String vocab) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? history = await getSharedHistory();

      if(!(history!.contains(vocab))){
        if(history.length == 10){
          history.removeLast();
        }
        history = [vocab, ...history];
        prefs.setStringList('history', history);
        
        debugPrint('vocabService: đã lưu xong');
      }

    }

  Future<List<String>?> getSharedHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('history')?? [];

  }

  Future<void> removeAllHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
