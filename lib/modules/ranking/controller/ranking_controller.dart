import 'package:flutter_talkshare/modules/ranking/model/top_rank_user_model.dart';
import 'package:flutter_talkshare/modules/ranking/services/ranking_services.dart';
import 'package:get/get.dart';

class RankingController extends GetxController {
  var listTopRank = Rx<List<TopRankUserModel>>([]);
  var isLoading = Rx<bool>(true);

  @override
  void onInit() async {
    await getListTopRank();
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getListTopRank() async {
    List<TopRankUserModel>? list = await RankingServices.instance.getTopRank();
    if (list != null) listTopRank.value = list;
    print(list);
  }
}
