import 'package:freezed_annotation/freezed_annotation.dart';

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

class AudioRoomSupabaseTable implements SupabaseTable {
  const AudioRoomSupabaseTable();

  @override
  String get tableName => "audioroom";

  String get roomId => "room_id";
  String get name => "name";
  String get topic => "topic";
  String get quantity => "quantity";
  String get passcode => "passcode";
  String get createdAt => "created_at";
  String get isActive => "isactive";
  String get userId => "user_id";
}

class BlogSupabaseTable implements SupabaseTable {
  const BlogSupabaseTable();

  @override
  String get tableName => "blog";

  String get blogId => "blog_id";
  String get userId => "user_id";
  String get created_at => "created_at";
  String get images => "images";
  String get content => "content";
}
class LivestreamSupabaseTable implements SupabaseTable {
  const LivestreamSupabaseTable();

  @override
  String get tableName => "livestream";

  String get streamId => "stream_id";
  String get createdAt => "created_at";
  String get isActive => "isactive";
  String get userId => "user_id";
}

class GameroomSupabaseTable implements SupabaseTable {
  const GameroomSupabaseTable();

  @override
  String get tableName => "gameroom";

  String get id => "id";
  String get status => "status";
  String get player1Id => "player1_id";
  String get player2Id => "player2_id";
  String get winnerId => "winner_id";
  String get createdAt => "created_at";
  String get updatedAt => "updated_at";
}

class InvitationsSupabaseTable implements SupabaseTable {
  const InvitationsSupabaseTable();

  @override
  String get tableName => "invitations";

  String get id => "id";
  String get fromUserId => "from_user_id";
  String get toUserId => "to_user_id";
  String get roomId => "room_id";
  String get status => "status";
  String get createdAt => "created_at";
}

class GamewordsSupabaseTable implements SupabaseTable {
  const GamewordsSupabaseTable();

  @override
  String get tableName => "gamewords";

  String get id => "id";
  String get roomId => "room_id";
  String get word => "word";
  String get userId => "user_id";
  String get createdAt => "created_at";
}
