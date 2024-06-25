import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_talkshare/core/models/definition.dart';
import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:flutter_talkshare/core/models/word_response.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:http/http.dart' as http;

import '../../../utils/helper.dart';

class VocabListServices {
  Future<List<Vocab>> getVocabList(String wordsetId) async {
    try {
      List<Vocab> result = [];
      List<String> listWordString =
          await SupabaseService.instance.getWordsetVocab(wordsetId);

      for (var i in listWordString) {
        //Definition vocab = await getWordByMapperJson(i);
        Vocab vocab = await SupabaseService.instance.getVocabByWord(i);

        result.add(vocab);
      }
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<Definition> getWordByMapperJson(String word) async {
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
      WordResponseModel responseModel =
          WordResponseModel.fromJson(json.decode(response.body)[0]);
      String primaryMeaning = await Helper.instance.tranlateToVN(word);
      return Definition(
        definitionId: responseModel
            .meanings![responseModel.meanings!.length - 1]
            .definitions![0]
            .definition!,
        word: word,
        partOfSpeech: responseModel
            .meanings![responseModel.meanings!.length - 1].partOfSpeech!,
        meaning: primaryMeaning,
        example: responseModel.meanings![responseModel.meanings!.length - 1]
            .definitions![0].example,
      );
    } else {
      debugPrint('wrong');
      return Definition(
          definitionId: 'definitionId',
          word: word,
          partOfSpeech: 'partOfSpeech',
          meaning: 'meaning',
          example: 'example');
    }
  }
}
