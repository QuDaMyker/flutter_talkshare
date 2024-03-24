part of 'supabase_service.dart';

extension VocabService on SupabaseService {
  Future<Vocab?> getVocabByWord(String word) async {
    Vocab? searchedVocab;
    String search = word.toLowerCase();
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.dictionaryapi.dev/api/v2/entries/en/$search')); //lấy nghĩa TA
    request.body = '''{"query":"","variables":{}}''';
    request.headers.addAll(headers);
    var url = Uri.https('api.dictionaryapi.dev', 'api/v2/entries/en/$search');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      debugPrint(body.length.toString());
      Map<String, dynamic> item = body[0];
      String temp = item['meanings'][0]['definitions'][0]['definition'];
      String primaryMeaning = await tranlateToVN(temp);
      String phonetic = '';
      String audioUrl = '';

      for (int i = 0; i < body.length; i++) {
        List<dynamic> item = body[i]['phonetics'];
        for (int j = 0; j < item.length; j++) {
          Map<String, dynamic> itemPhonetic = item[j];
          if (itemPhonetic.containsKey('text') &&
              itemPhonetic.containsKey('audio') &&
              itemPhonetic['audio'] != '' &&
              itemPhonetic['text'] != '') {
            phonetic = itemPhonetic['text'];
            audioUrl = itemPhonetic['audio'];
            break;
          }
        }
        if (phonetic != '') {
          break;
        }
      }
      searchedVocab = Vocab(
        word: search,
        primaryMeaning: primaryMeaning,
        phonetic: phonetic,
        audioUrl: audioUrl,
      );
    }
    return searchedVocab;
  }

  Future<void> insertVocab(Vocab word) async {
    await supabase.from(Vocab.table.tableName).insert(word.toJson());
  }

  //cho phép lưu dưới 10 từ
  Future<void> saveVocabToSharedPreferences(Vocab vocab) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (vocab.word.isNotEmpty) {
      if (!prefs.containsKey(vocab.word)) {
        Set<String> history = prefs.getKeys();
        if (history.length >= 10) {
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
    for (String item in keys) {
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
