import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RootViewServices {
  RootViewServices._internal();
  static final RootViewServices instance = RootViewServices._internal();
  factory RootViewServices() => instance;

  SupabaseClient supabaseClient = SupabaseService.instance.supabase;
}
