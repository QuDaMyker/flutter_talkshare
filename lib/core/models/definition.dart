import 'package:flutter_talkshare/core/values/supabase_table.dart';

class Definition {
  final String definitionId;
  final String word;
  final String partOfSpeech;
  final String meaning;
  final String? example;

  const Definition({
    required this.definitionId,
    required this.word,
    required this.partOfSpeech,
    required this.meaning,
    required this.example,
  });

  static DefinitionSupabaseTable table = const DefinitionSupabaseTable();

  static Definition fromJson(Map<String, dynamic> json) => Definition(
        definitionId: json[table.definitionId] as String,
        word: json[table.word] as String,
        partOfSpeech: json[table.partOfSpeech] as String,
        meaning: json[table.meaning] as String,
        example: json[table.example] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        table.definitionId: definitionId,
        table.word: word,
        table.partOfSpeech: partOfSpeech,
        table.meaning: meaning,
        table.example: example,
      };
}