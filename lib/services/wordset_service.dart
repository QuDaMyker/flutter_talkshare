part of 'supabase_service.dart';

extension WordsetService on SupabaseService {
  //DO NOT trigger this method
  Future<List<WordSet>> addDefaultWordSets() async {
    List<WordSet> wordsets = [];
    String adminId = 'f6d32d14-961c-4fba-94ff-7e76f9031a09';
    String urlPrefix =
        'https://huprpremefnsrvgkdhqm.supabase.co/storage/v1/object/public/Wordset%20Avatar/';
    SystemData.defaultWordset.forEach((key, value) async {
      var uuid = const Uuid();
      String wordsetId = uuid.v4();
      String name = key;
      var wordset = WordSet(
          name: name,
          avatarUrl: '$urlPrefix$name.jpg',
          userId: adminId,
          wordsetId: wordsetId);
      wordsets.add(wordset);
      insertWordset(wordset);

      for (var item in value) {
        Vocab? vocab = await getVocabByWord(item);
        if (vocab != null) {
          insertVocab(vocab);
          insertVocabToWordset(vocab, wordsetId);
        }
      }
    });
    return wordsets;
  }

  Future<void> insertWordset(WordSet wordSet) async {
    await supabase.from(WordSet.table.tableName).insert(wordSet.toJson());
  }

  Future<void> insertVocabToWordset(Vocab vocab, String wordsetId) async {
    var table = const WordsetVocabSupabaseTable();
    Map<String, dynamic> res = {
      table.wordsetId: wordsetId,
      table.word: vocab.word,
    };
    await supabase.from(table.tableName).insert(res);
  }
}
