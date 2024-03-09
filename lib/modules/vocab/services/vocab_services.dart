import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase/supabase.dart';

class VocabService {
  static final supabaseUrl = dotenv.get('supabaseUrl');
  static final supabaseKey = dotenv.get('supabaseKey');
  final supabase = SupabaseClient(supabaseUrl, supabaseKey);
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
}
