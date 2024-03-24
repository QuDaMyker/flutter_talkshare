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
    Future<void> saveVocabToSharedPreferences(Vocab vocab) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if(vocab.word.isNotEmpty){
        if(!prefs.containsKey(vocab.word)){
          Set<String> history = prefs.getKeys();
          if(history.length >=10){
            String firstKey = prefs.getKeys().first;
            prefs.remove(firstKey);
          }
          await prefs.setString(vocab.word, vocab.primaryMeaning);
        }
      }
    }

  Future<void> getSharedHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();
    for (String item in keys){
      debugPrint(item);
    }
  }

   Future<Set<String>> getAllKeysHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();
    return keys;
  }

  Future<void> removeAllHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
