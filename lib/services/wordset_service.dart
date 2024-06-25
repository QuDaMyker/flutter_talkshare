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

  Future<void> addWordset(WordSet wordSet, List<String> words) async {
    SupabaseService.instance.insertWordset(wordSet);
    for (String word in words) {
      try {
        insertVocabToWordset(await getVocabByWord(word), wordSet.wordsetId);
      } catch (_) {}
    }
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

  Future<List<Folder>> getAllFolders(String userId) async {
    List<dynamic> res = await supabase
        .from(Folder.table.tableName)
        .select()
        .eq(Folder.table.userId, userId);
    List<Folder> listFolder = res.map((e) => Folder.fromJson(e)).toList();
    return listFolder;
  }

  Future<String> uploadWordSetImage(File imageFile) async {
    String imgName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    await supabase.storage.from('Wordset Avatar').upload(imgName, imageFile);
    return imgName;
  }

  Future<Vocab> getVocabByWord(String word) async {
    final response = await supabase
        .from(Vocab.table.tableName)
        .select()
        .eq(Vocab.table.word, word);
    return Vocab.fromJson(response.first);
  }
}
