import 'package:flutter/material.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PointLearningServices {
  PointLearningServices._internal();
  static final PointLearningServices instance =
      PointLearningServices._internal();
  factory PointLearningServices() => instance;
  SupabaseClient supabase = SupabaseService.instance.supabase;

  Future<int?> getSumPoint({required String userId}) async {
    try {
      final query = await supabase
          .from('point_learning')
          .select('sum_point')
          .eq('user_id', userId);

      return query[0]['sum_point'] as int;
    } catch (e) {
      debugPrint('[PointLearningServices][getSumPoint]: ${e.toString()}');
      return null;
    }
  }
}
