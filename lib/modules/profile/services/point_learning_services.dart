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

  Future<void> addPoint({
    required String userId,
    required int pointValue,
  }) async {
    try {
      int? currentPoint = await getSumPoint(userId: userId);
      if (currentPoint == null) {
        await supabase.from('point_learning').insert({
          'user_id': userId,
          'sum_point': pointValue,
        });
        debugPrint(
            '[PointLearningServices][addPoint]: Insert new ${pointValue} points');
      } else {
        await supabase.from('point_learning').update({
          'sum_point': currentPoint + pointValue,
        }).eq('user_id', userId);
        debugPrint(
            '[PointLearningServices][addPoint]: Updated new ${currentPoint + pointValue} points');
      }
    } catch (e) {
      debugPrint('[PointLearningServices][getSumPoint]: ${e.toString()}');
      return null;
    }
  }

  Future<int?> getCountDate(
      {required String today, required String user_id}) async {
    try {
      final query = await supabase
          .from('streak_daily')
          .select('date')
          .eq('date', today)
          .eq('user_id', user_id)
          .count();
      return query.count;
    } catch (e) {
      debugPrint('[RootViewServices][getCountDate]: ${e.toString()}');
      return null;
    }
  }

  Future<int?> getStreakDay({
    required String user_id,
  }) async {
    try {
      final query = await supabase
          .from('streak_daily')
          .select('date')
          .eq('user_id', user_id)
          .count();
      return query.count;
    } catch (e) {
      debugPrint('[RootViewServices][getCountDate]: ${e.toString()}');
      return null;
    }
  }

  Future<void> addStreak({
    required String user_id,
    required String today,
  }) async {
    try {
      await supabase.from('streak_daily').insert({
        'user_id': user_id,
        'date': today,
      });
    } catch (e) {
      debugPrint('[RootViewServices][addStreak]: ${e.toString()}');
    }
  }
}
