import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/models/word_response.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator_plus/translator_plus.dart';

import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:flutter_talkshare/core/models/wordset.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';

import '../../../utils/helper.dart';

class VocabService {
  final translator = GoogleTranslator();
  late final SharedPreferences prefs;
  final AuthController authController = Get.find<AuthController>();

  Future<List<Vocab>> getVocabSaved() async {
    try {
      List<Vocab> result = [];
      List<String> listWordString = await SupabaseService.instance
          .getListSavedVocab(authController.user.user_id);

      for (var i in listWordString) {
        Vocab vocab = await getWordByMapperJson(i);
        result.add(vocab);
        print(vocab.word);
      }
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<Vocab>> getVocabRecent() async {
    try {
      List<Vocab> result = [];
      List<String> recentVocab = await getSearchedHistory();
      debugPrint('recent: ${recentVocab.length}');
      for (var i in recentVocab) {
        Vocab rsWord = await getWordByMapperJson(i);
        result.add(rsWord);
      }

      // getWordByMapperJson('home');
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<WordSet>> getVocabCollection() async {
    List<WordSet> result = await SupabaseService.instance.getWordSet();
    for (int i = 0; i < result.length; i++) {
      int count =
          await SupabaseService.instance.getCounterWordSet(result[i].wordsetId);
      result[i] = result[i].copyWith(count: count);
    }
    return result;
  }

  Future<Vocab> getWordByMapperJson(String word) async {
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
      return Vocab(
        word: word,
        // primaryMeaning: responseModel.meanings![0].definitions![0].definition!,
        primaryMeaning: primaryMeaning,
        audioUrl: responseModel.phonetics!.isNotEmpty
            ? responseModel
                .phonetics![responseModel.phonetics!.length - 1].audio
            : '',
        phonetic: responseModel.phonetic,
      );
    } else {
      debugPrint('wrong');
      return Vocab(word: word, primaryMeaning: 'unknown');
    }
  }

  Future<Vocab> getWord(String word) async {
    String search = word.toLowerCase();
    Vocab rsWord;
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
      Map<String, dynamic> item = body[0];

      String temp = item['meanings'][0]['definitions'][0]['definition'];
      String primaryMeaning = await Helper.instance.tranlateToVN(temp);
      String audioUrl;

      if (item['phonetics'][0]['audio'] == '') {
        audioUrl = item['phonetics'][1]['audio'];
      } else if (item['phonetics'][1]['audio'] == '') {
        audioUrl = item['phonetics'][0]['audio'];
      } else {
        audioUrl = '';
      }

      rsWord = Vocab(
        word: word,
        primaryMeaning: primaryMeaning,
        phonetic: item['phonetic'],
        audioUrl: audioUrl,
      );
    } else {
      rsWord = Vocab(word: word, primaryMeaning: 'unknown');
    }

    return rsWord;
  }

  Future<List<String>> getSearchedHistory() async {
    prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getStringList('history') ?? [];

    return keys;
  }
}
