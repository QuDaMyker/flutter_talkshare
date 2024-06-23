import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/ranking/controller/ranking_controller.dart';
import 'package:flutter_talkshare/modules/ranking/model/top_rank_user_model.dart';
import 'package:flutter_talkshare/modules/ranking/widgets/item_rank_user_widget.dart';
import 'package:flutter_talkshare/modules/ranking/widgets/top_rank_user_widget.dart';
import 'package:lottie/lottie.dart';

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
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          height: 60,
                          width: Get.width,
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 15,
                                sigmaY: 15,
                                tileMode: TileMode.mirror,
                              ),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  color: AppColors.primary50.withOpacity(0.5),
                                ),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    // Positioned(
                                    //   bottom: -70,
                                    //   left: 0,
                                    //   right: 0,
                                    //   child: SizedBox(
                                    //     height: 200,
                                    //     width: 200,
                                    //     child: CircleAvatar(
                                    //       child: Lottie.asset(
                                    //           'assets/images/lottie/ic_text_congratulation.json'),
                                    //     ),
                                    //   ),
                                    // ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Lottie.asset(
                                          'assets/images/lottie/ic_effect_congratulation.json'),
                                    ),
                                  ],
                                ),
                              ),
                              //blendMode: BlendMode.color,
                            ),
                          ),
                        ),
                        _buildTop3Rank(rankingController, labelHeight),
                      ],
                    ),
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
      // color: AppColors.secondary40.withOpacity(0.5),
      color: Color(0xffFFFFEE),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: rankingController.listTopRank.value.length,
        itemBuilder: (context, index) {
          // if (index > 3) {
          //   TopRankUserModel item = rankingController.listTopRank.value[index];
          //   return ItemRankUserWidget(item: item, index: index);
          // }
          // return null;
          TopRankUserModel item = rankingController.listTopRank.value[index];
          return ItemRankUserWidget(item: item, index: index);
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
          child: rankingController.listTopRank.value.length > 1
              ? TopRankUser(
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
                )
              : const SizedBox(),
        ),
        rankingController.listTopRank.value.length > 0
            ? TopRankUser(
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
              )
            : const SizedBox(),
        rankingController.listTopRank.value.length > 2
            ? Container(
                padding: const EdgeInsets.only(top: 100),
                child: TopRankUser(
                  topRankUserModel: rankingController.listTopRank.value[2],
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
              )
            : const SizedBox(),
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
