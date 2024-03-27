import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_talkshare/core/models/folder.dart';
import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:flutter_talkshare/core/models/wordset.dart';
import 'package:flutter_talkshare/core/values/supabase_table.dart';
import 'package:flutter_talkshare/utils/data.dart';
import 'package:flutter_talkshare/utils/helper.dart';

part 'user_service.dart';
part 'vocab_service.dart';
part 'wordset_service.dart';

class SupabaseService {
  SupabaseService._internal();
  factory SupabaseService() => instance;
  static final SupabaseService instance = SupabaseService._internal();
  late SupabaseClient supabase;

  Future<void> init() async {
    await Supabase.initialize(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    );
    supabase = Supabase.instance.client;
  }

  Future<void> login(String email, String password) async {
    await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<List<WordSet>> getWordSet() async {
    List<WordSet> listWordSet = [];
    try {
      final query = await supabase
          .from('wordset')
          .select('wordset_id, name, avatar_url, folder_id, user_id')
          .eq('user_id', 'f6d32d14-961c-4fba-94ff-7e76f9031a09');

      for (var i in query) {
        WordSet wordSet = WordSet.fromJson(i);
        listWordSet.add(wordSet);
      }

      return listWordSet;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<int> getCounterWordSet(String wordsetId) async {
    final query = await supabase
        .from('wordset_vocab')
        .select('wordset_id')
        .eq('wordset_id', wordsetId)
        .count();
    return query.count;
  }

  Future<List<String>> getWordsetVocab(String wordsetId) async {
    List<String> listVocab = [];
    try {
      final query = await supabase
          .from('wordset_vocab')
          .select('word')
          .eq('wordset_id', wordsetId);

      for (var i in query) {
        listVocab.add(i['word']);
      }

      return listVocab;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<int> insertFolder(Folder folder) async {
    try {
      await supabase.from('folder').insert({
        'name': folder.name,
        'user_id': folder.userId,
      });
      return 200;
    } catch (e) {
      debugPrint(e.toString());
      return 400;
    }
  }

  Future<bool> isBookmarkOn(String word, String userId) async {
    try {
      final query = await supabase
          .from('saved_word')
          .select('word, user_id')
          .eq('word', word)
          .eq('user_id', userId)
          .count();
      if (query.count != 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<int> addRemoveBookmark(String word, String userId) async {
    try {
      bool isExist = await isBookmarkOn(word, userId);
      if (isExist) {
        await supabase.from('saved_word').delete().match({
          'word': word,
          'user_id': userId,
        });
      } else {
        await supabase.from('saved_word').insert({
          'word': word,
          'user_id': userId,
        });
      }

      return 200;
    } catch (e) {
      debugPrint(e.toString());
      return 400;
    }
  }

  Future<List<String>> getListSavedVocab(String userId) async {
    try {
      List<String> listVocab = [];
      final query = await supabase
          .from('saved_word')
          .select('word, user_id')
          .eq('user_id', userId);

      for (var i in query) {
        listVocab.add(i['word']);
      }
      return listVocab;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
