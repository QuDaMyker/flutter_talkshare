import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/vocab_list_detail/controllers/vocab_list_detail_controller.dart';
import 'package:get/get.dart';
import 'package:wave_linear_progress_indicator/wave_linear_progress_indicator.dart';

class VocabListDetailScreen extends StatelessWidget {
  const VocabListDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final VocabListDetailController vocabListDetailController =
        Get.put(VocabListDetailController());
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: _buildBody(
            deviceHeight,
            deviceWidth,
            vocabListDetailController,
          ),
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
      ),
    );
  }

  Container _buidStudyingWord(
    double deviceHeight,
    double deviceWidth,
    VocabListDetailController controller,
  ) {
    return Container(
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
      ),
    );
  }

  Widget _buildBody(
    double deviceHeight,
    double deviceWidth,
    VocabListDetailController controller,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLinearProgressIndicator(controller),
        _buildIndexWord(deviceHeight, deviceWidth, controller),
        _buildPresentWord(deviceHeight, deviceWidth, controller),
        _buidGroupButton(deviceHeight, deviceWidth, controller),
      ],
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
          _buidStudyingWord(
            deviceHeight,
            deviceWidth,
            controller,
          ),
          _buildButtonTryAgain(
            deviceWidth,
            controller,
          ),
          _buildStudiedWord(
            deviceHeight,
            deviceWidth,
            controller,
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
    return Container(
      margin: EdgeInsets.only(
        top: deviceHeight * 0.05,
        left: deviceWidth * 0.1,
        right: deviceWidth * 0.1,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
        border: const Border(
          top: BorderSide(
            color: AppColors.gray60,
            width: 1,
          ),
          bottom: BorderSide(
            color: AppColors.gray60,
            width: 1,
          ),
          left: BorderSide(
            color: AppColors.gray60,
            width: 1,
          ),
          right: BorderSide(
            color: AppColors.gray60,
            width: 1,
          ),
        ),
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.bookmark_border_outlined,
                size: deviceWidth * 0.1,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: deviceHeight * 0.2,
              bottom: deviceHeight * 0.2,
              left: deviceWidth * 0.1,
              right: deviceWidth * 0.1,
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                'Align',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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

  Container _buildRightIndex(
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
      child: const Text(
        '4',
        style: TextStyle(
          color: AppColors.primary40,
          fontSize: 16,
          fontWeight: FontWeight.w600,
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
      child: const Text(
        '4',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  WaveLinearProgressIndicator _buildLinearProgressIndicator(
    VocabListDetailController vocabListDetailController,
  ) {
    return WaveLinearProgressIndicator(
      value: 0.75,
      enableBounceAnimation: true,
      waveColor: Colors.orange,
      backgroundColor: Colors.grey[150],
      minHeight: 10,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        '4/12',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
    );
  }
}
