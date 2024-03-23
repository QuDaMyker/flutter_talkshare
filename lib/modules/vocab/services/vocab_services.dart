import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VocabService {
  
  Future<List<Map<String, dynamic>>> getVocabSavedScrollable() async {
    List<Map<String, dynamic>> result = [];
    try {} catch (e) {}
    return result;
  }

  Future<List<Map<String, dynamic>>> getVocabRecentScrollable() async {
    List<Map<String, dynamic>> result = [];
    try {} catch (e) {}
    return result;
  }

  Future<List<Map<String, dynamic>>> getVocabCollectionScrollable() async {
    List<Map<String, dynamic>> result = [];
    try {} catch (e) {}
    return result;
  }


  //danh sách từ được là list<String> searchHistory
  Future<void> saveVocabToSharedPreferences(String word) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> searchHistory = await getSearchHistory();
    if (!searchHistory.contains(word)) {
      searchHistory.add(word);
      await prefs.setStringList('searchHistory', searchHistory);
    }
  }

  Future<List<String>> getSearchHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final searchHistory = prefs.getStringList('searchHistory') ?? [];
    return searchHistory;
  }

 
}
