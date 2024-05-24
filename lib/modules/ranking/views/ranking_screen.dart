import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/ranking/controller/ranking_controller.dart';
import 'package:flutter_talkshare/modules/ranking/model/top_rank_user_model.dart';
import 'package:flutter_talkshare/modules/ranking/widgets/item_rank_user_widget.dart';
import 'package:flutter_talkshare/modules/ranking/widgets/top_rank_user_widget.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var labelHeight = 50.0;
    final RankingController rankingController = Get.put(RankingController());
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(
        () => rankingController.isLoading.value
            ? _buildLoading()
            : Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildTop3Rank(rankingController, labelHeight),
                  ),
                  Expanded(
                    flex: 1,
                    child: _buildListRank(rankingController),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildListRank(RankingController rankingController) {
    return Container(
      color: AppColors.secondary40.withOpacity(0.5),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: rankingController.listTopRank.value.length,
        itemBuilder: (context, index) {
          if (index > 3) {
            TopRankUserModel item = rankingController.listTopRank.value[index];
            return ItemRankUserWidget(item: item, index: index);
          }
          return null;
        },
      ),
    );
  }

  Row _buildTop3Rank(RankingController rankingController, double labelHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 50),
          child: TopRankUser(
            topRankUserModel: rankingController.listTopRank.value[1],
            size: Get.width * 0.24,
            labelHeight: labelHeight,
            isTopOne: false,
            index: 2,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TopRankUser(
          topRankUserModel: rankingController.listTopRank.value[0],
          size: Get.width * 0.3,
          labelHeight: labelHeight,
          isTopOne: true,
          index: 1,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.w900,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 100),
          child: TopRankUser(
            topRankUserModel: rankingController.listTopRank.value[1],
            size: Get.width * 0.2,
            labelHeight: labelHeight,
            isTopOne: false,
            index: 3,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Center _buildLoading() {
    return Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: AppColors.primary40,
        rightDotColor: AppColors.secondary20,
        size: 20,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Bảng xếp hạng',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: AppColors.primary20,
        ),
      ),
    );
  }
}
