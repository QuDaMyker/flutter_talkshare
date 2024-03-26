abstract class SupabaseTable {
  const SupabaseTable();
  String get tableName;
}

class VocabSupabaseTable implements SupabaseTable {
  const VocabSupabaseTable();

  @override
  String get tableName => "vocab";

  String get word => "word";
  String get primaryMeaning => "primary_meaning";
  String get phonetic => "phonetic";
  String get audioUrl => "audio_url";
}

class DefinitionSupabaseTable implements SupabaseTable {
  const DefinitionSupabaseTable();

  @override
  String get tableName => "definition";

  String get definitionId => "definition_id";
  String get word => "word";
  String get partOfSpeech => "part_of_speech";
  String get meaning => "meaning";
  String get example => "example";
}

class FolderSupabaseTable implements SupabaseTable {
  const FolderSupabaseTable();

  @override
  String get tableName => "folder";

  String get folderId => "folder_id";
  String get name => "name";
  String get userId => "user_id";
}

class WordSetSupabaseTable implements SupabaseTable {
  const WordSetSupabaseTable();

  @override
  String get tableName => "wordset";

  String get wordsetId => "wordset_id";
  String get name => "name";
  String get avatarUrl => "avatar_url";
  String get folderId => "folder_id";
  String get userId => "user_id";
}

class UserSupabaseTable implements SupabaseTable {
  const UserSupabaseTable();

  @override
  String get tableName => "users";

  String get userId => "user_id";
  String get fullname => "fullname";
  String get avatarUrl => "avatar_url";
  String get password => "password";
}

class SavedWordSupabaseTable implements SupabaseTable {
  const SavedWordSupabaseTable();

  @override
  String get tableName => "saved_word";

  String get word => "word";
  String get userId => "user_id";
}

class WordsetVocabSupabaseTable implements SupabaseTable {
  const WordsetVocabSupabaseTable();

  @override
  String get tableName => "wordset_vocab";

  String get word => "word";
  String get wordsetId => "wordset_id";
}
