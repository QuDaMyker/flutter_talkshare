import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/request_teacher/models/request_teacher_model.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RequestTeacherService {
  RequestTeacherService._internal();
  static final RequestTeacherService instance =
      RequestTeacherService._internal();
  factory RequestTeacherService() => instance;
  SupabaseClient supabaseClient = SupabaseService.instance.supabase;

  Future<bool?> setRole({required String role, required String user_id}) async {
    try {
      await supabaseClient
          .from('users')
          .update({'role': role}).eq('user_id', user_id);

      return true;
    } catch (e) {
      debugPrint(
          '[RequestTeacherService][requestTeacherRole]: ${e.toString()}');
      return null;
    }
  }

  Future<bool?> addRequestTeacher({
    required RequestTeacherModelReq model,
  }) async {
    try {
      await supabaseClient.from('request_teacher').insert(model.toMap());

      return true;
    } catch (e) {
      debugPrint('[RequestTeacherService][addRequestTeacher]: ${e.toString()}');
      return null;
    }
  }
}
