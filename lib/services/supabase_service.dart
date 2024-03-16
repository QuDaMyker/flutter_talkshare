import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'user_service.dart';
part 'vocab_service.dart';

class SupabaseService {
  SupabaseService._internal();
  factory SupabaseService() => instance;
  static final SupabaseService instance = SupabaseService._internal();
  var supabase;

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
}
