import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/models/definition.dart';
import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/vocab_list_detail/controllers/vocab_list_detail_controller.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wave_linear_progress_indicator/wave_linear_progress_indicator.dart';

class VocabListDetailScreen extends StatelessWidget {
  const VocabListDetailScreen({
    super.key,
    required this.listVocabAddToCard,
  });

  final List<Vocab> listVocabAddToCard;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final vocabListDetailController = Get.put(
      VocabListDetailController(
        listVocabAddToCard: listVocabAddToCard,
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(vocabListDetailController),
        body: _buildBody(
          deviceHeight,
          deviceWidth,
          vocabListDetailController,
        ),
      ),
    );
  }

  Container _buildStudiedWord(
    double deviceHeight,
    double deviceWidth,
    VocabListDetailController controller,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.04),
      padding: EdgeInsets.symmetric(
        vertical: deviceHeight * 0.005,
        horizontal: deviceWidth * 0.05,
      ),
      decoration: const BoxDecoration(
        color: AppColors.secondary60,
        borderRadius: BorderRadius.all(
          Radius.circular(
            12,
          ),
        ),
        border: Border(
          top: BorderSide(
            color: AppColors.primary40,
            width: 1,
          ),
          bottom: BorderSide(
            color: AppColors.primary40,
            width: 1,
          ),
          right: BorderSide(
            color: AppColors.primary40,
            width: 1,
          ),
          left: BorderSide(
            color: AppColors.primary40,
            width: 1,
          ),
        ),
      ),
      child: const Text(
        'Đã biết',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.primary40,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buidStudyingWord(
    double deviceHeight,
    double deviceWidth,
    VocabListDetailController controller,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.04),
      padding: EdgeInsets.symmetric(
        vertical: deviceHeight * 0.005,
        horizontal: deviceWidth * 0.04,
      ),
      decoration: BoxDecoration(
        color: AppColors.gray20.withOpacity(
          0.2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            12,
          ),
        ),
        border: const Border(
          top: BorderSide(
            color: AppColors.gray20,
            width: 1,
          ),
          bottom: BorderSide(
            color: AppColors.gray20,
            width: 1,
          ),
          right: BorderSide(
            color: AppColors.gray20,
            width: 1,
          ),
          left: BorderSide(
            color: AppColors.gray20,
            width: 1,
          ),
        ),
      ),
      child: const Text(
        'Đang học',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: AppColors.gray20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildBody(
    double deviceHeight,
    double deviceWidth,
    VocabListDetailController controller,
  ) {
    return SizedBox(
      height: deviceHeight,
      child: Obx(
        () => !controller.isLoading.value
            ? Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildLinearProgressIndicator(controller),
                  ),
                  Expanded(
                    flex: 1,
                    child:
                        _buildIndexWord(deviceHeight, deviceWidth, controller),
                  ),
                  Expanded(
                    flex: 5,
                    child: _buildPresentWord(
                        deviceHeight, deviceWidth, controller),
                  ),
                  Expanded(
                    flex: 2,
                    child:
                        _buidGroupButton(deviceHeight, deviceWidth, controller),
                  ),
                ],
              )
            : _buildLoading(),
      ),
    );
  }

  Center _buildLoading() {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: AppColors.primary40,
        size: 200,
      ),
    );
  }

  Container _buidGroupButton(double deviceHeight, double deviceWidth,
      VocabListDetailController controller) {
    return Container(
      margin: EdgeInsets.only(
        top: deviceHeight * 0.1,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                controller.controllerCard.swipe(CardSwiperDirection.left);
              },
              child: _buidStudyingWord(
                deviceHeight,
                deviceWidth,
                controller,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                controller.controllerCard.undo();
              },
              child: _buildButtonTryAgain(
                deviceWidth,
                controller,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                controller.controllerCard.swipe(CardSwiperDirection.right);
              },
              child: _buildStudiedWord(
                deviceHeight,
                deviceWidth,
                controller,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildButtonTryAgain(
    double deviceWidth,
    VocabListDetailController controller,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
      padding: EdgeInsets.all(
        deviceWidth * 0.04,
      ),
      decoration: const BoxDecoration(
        color: AppColors.secondary20,
        borderRadius: BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
      ),
      child: SvgPicture.asset(
        'assets/images/svg/ic_try.svg',
        semanticsLabel: 'Acme Logo',
      ),
    );
  }

  Widget _buildPresentWord(
    double deviceHeight,
    double deviceWidth,
    VocabListDetailController vocabListDetailController,
  ) {
    return CardSwiper(
      controller: vocabListDetailController.controllerCard,
      onSwipe: vocabListDetailController.onSwipe,
      onUndo: vocabListDetailController.onUndo,
      allowedSwipeDirection: const AllowedSwipeDirection.only(
        left: true,
        right: true,
        up: false,
        down: false,
      ),
      cardsCount: vocabListDetailController.listVocab.value.length,
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
          vocabListDetailController.listVocab.value[index],
    );
  }

  // Widget _buildPresentWord(
  //   double deviceHeight,
  //   double deviceWidth,
  //   VocabListDetailController vocabListDetailController,
  // ) {
  //   return Container(
  //     margin: EdgeInsets.only(
  //       top: deviceHeight * 0.05,
  //       left: deviceWidth * 0.1,
  //       right: deviceWidth * 0.1,
  //     ),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: const BorderRadius.all(
  //         Radius.circular(
  //           20,
  //         ),
  //       ),
  //       border: const Border(
  //         top: BorderSide(
  //           color: AppColors.gray60,
  //           width: 1,
  //         ),
  //         bottom: BorderSide(
  //           color: AppColors.gray60,
  //           width: 1,
  //         ),
  //         left: BorderSide(
  //           color: AppColors.gray60,
  //           width: 1,
  //         ),
  //         right: BorderSide(
  //           color: AppColors.gray60,
  //           width: 1,
  //         ),
  //       ),
  //       shape: BoxShape.rectangle,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.5),
  //           spreadRadius: 2,
  //           blurRadius: 5,
  //           offset: const Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.max,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Align(
  //           alignment: Alignment.centerRight,
  //           child: IconButton(
  //             onPressed: () {},
  //             icon: Icon(
  //               Icons.bookmark_border_outlined,
  //               size: deviceWidth * 0.1,
  //             ),
  //           ),
  //         ),
  //         Container(
  //           padding: EdgeInsets.only(
  //             top: deviceHeight * 0.2,
  //             bottom: deviceHeight * 0.2,
  //             left: deviceWidth * 0.1,
  //             right: deviceWidth * 0.1,
  //           ),
  //           child: const Align(
  //             alignment: Alignment.center,
  //             child: Text(
  //               'Align',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: 24,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Row _buildIndexWord(
    double deviceHeight,
    double deviceWidth,
    VocabListDetailController controller,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: _buildLeftIndex(deviceHeight, deviceWidth, controller),
        ),
        const Spacer(),
        Flexible(
          flex: 1,
          child: _buildRightIndex(deviceHeight, deviceWidth, controller),
        ),
      ],
    );
  }

  Widget _buildRightIndex(
    double deviceHeight,
    double deviceWidth,
    VocabListDetailController controller,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: deviceHeight * 0.01,
        horizontal: deviceWidth * 0.05,
      ),
      decoration: const BoxDecoration(
        color: AppColors.secondary60,
        border: Border(
          top: BorderSide(
            color: AppColors.primary40,
            width: 1.5,
          ),
          left: BorderSide(
            color: AppColors.primary40,
            width: 1.5,
          ),
          bottom: BorderSide(
            color: AppColors.primary40,
            width: 1.5,
          ),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        ),
      ),
      child: Obx(
        () => Text(
          //'${controller.currentIndexCard.value == controller.listVocab.value.length ? 1 : controller.currentIndexCard.value + 1}',
          '${controller.listStudied.length}',
          style: const TextStyle(
            color: AppColors.primary40,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildLeftIndex(
    double deviceHeight,
    double deviceWidth,
    VocabListDetailController controller,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: deviceHeight * 0.01,
        horizontal: deviceWidth * 0.05,
      ),
      decoration: const BoxDecoration(
        color: AppColors.gray60,
        border: Border(
          top: BorderSide(
            color: AppColors.gray20,
            width: 1.5,
          ),
          right: BorderSide(
            color: AppColors.gray20,
            width: 1.5,
          ),
          bottom: BorderSide(
            color: AppColors.gray20,
            width: 1.5,
          ),
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Obx(
        () => Text(
          //'${controller.currentIndexCard.value == 1 ? controller.listVocab.value.length : controller.currentIndexCard.value}',
          '${controller.listStuying.length}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildLinearProgressIndicator(
    VocabListDetailController controller,
  ) {
    return Obx(
      () => WaveLinearProgressIndicator(
        value: (controller.currentIndexCard.value + 1) /
            controller.listVocab.value.length,
        enableBounceAnimation: true,
        waveColor: AppColors.primary40,
        backgroundColor: Colors.grey[150],
        minHeight: 10,
      ),
    );
  }

  AppBar _buildAppBar(
    VocabListDetailController controller,
  ) {
    return AppBar(
      centerTitle: true,
      title: Obx(
        () => Text(
          '${controller.currentIndexCard.value + 1}/${controller.listVocab.value.length}',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
