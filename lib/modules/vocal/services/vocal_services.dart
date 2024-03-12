import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase/supabase.dart';

class VocalService {
  static final supabaseUrl = dotenv.get('supabaseUrl');
  static final supabaseKey = dotenv.get('supabaseKey');
  final supabase = SupabaseClient(supabaseUrl, supabaseKey);
  Future<List<Map<String, dynamic>>> getVocalSavedScrollable() async {
    List<Map<String, dynamic>> result = [];
    try {} catch (e) {}
    return result;
  }

  Future<List<Map<String, dynamic>>> getVocalRecentScrollable() async {
    List<Map<String, dynamic>> result = [];
    try {} catch (e) {}
    return result;
  }

  Future<List<Map<String, dynamic>>> getVocalCollectionScrollable() async {
    List<Map<String, dynamic>> result = [];
    try {} catch (e) {}
    return result;
  }
}
