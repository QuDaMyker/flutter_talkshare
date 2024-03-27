// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_talkshare/core/values/supabase_table.dart';

class Vocab {
  final String word;
  final String primaryMeaning;
  final String? phonetic;
  final String? audioUrl;
  const Vocab(
      {required this.word,
      required this.primaryMeaning,
      this.phonetic,
      this.audioUrl});

  static VocabSupabaseTable table = const VocabSupabaseTable();

  static Vocab fromJson(Map<String, dynamic> json) => Vocab(
        word: json[table.word] as String,
        primaryMeaning: json[table.primaryMeaning] as String,
        phonetic: json[table.phonetic] as String?,
        audioUrl: json[table.audioUrl] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        table.word: word,
        table.primaryMeaning: primaryMeaning,
        table.phonetic: phonetic,
        table.audioUrl: audioUrl,
      };

  @override
  String toString() {
    return 'Vocab(word: $word, primaryMeaning: $primaryMeaning, phonetic: $phonetic, audioUrl: $audioUrl)';
  }
}
