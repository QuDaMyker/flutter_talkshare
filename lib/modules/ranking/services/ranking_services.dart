import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/ranking/model/top_rank_user_model.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RankingServices {
  RankingServices._internal();
  static final RankingServices instance = RankingServices._internal();
  factory RankingServices() => instance;
  SupabaseClient supabaseClient = SupabaseService.instance.supabase;

  Future<List<TopRankUserModel>?> getTopRank() async {
    try {
      List<TopRankUserModel> list = [];
      final query = await supabaseClient
          .from('point_learning')
          .select('id, user_id, sum_point, users(fullname, avatar_url)')
          .order('sum_point', ascending: false);
      for (var i in query) {
        list.add(TopRankUserModel.fromJson(json.encode(i)));
      }

      return list;
    } catch (e) {
      debugPrint('[RankingServices][getTopRank]: ${e.toString()}');
      return null;
    }
  }
}
