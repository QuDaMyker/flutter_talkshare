import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/vocab/controller/vocab_screen_controller.dart';
import 'package:flutter_talkshare/modules/vocab/widgets/item_collection_vocal.dart';
import 'package:flutter_talkshare/modules/vocab/widgets/item_recent_vocal.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

class VocabScreen extends StatelessWidget {
  const VocabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VocabScreenController vocabScreenController =
        Get.put(VocabScreenController());
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(deviceHeight, deviceWidth, vocabScreenController),
      ),
    );
  }

  Padding _buildBody(
    double deviceHeight,
    double deviceWidth,
    VocabScreenController controller,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.05,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.01,
              ),
              child: _buildVocabSavedScrollable(
                deviceHeight,
                deviceWidth,
                controller,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.01,
              ),
              child: _buildVocabRecentScrollable(
                deviceHeight,
                deviceWidth,
                controller,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.01,
              ),
              child: _buildVocabCollectionScrollable(
                deviceHeight,
                deviceWidth,
                controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildVocabCollectionScrollable(
    double deviceHeight,
    double deviceWidth,
    VocabScreenController controller,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Bộ từ của bạn',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(
                  AppColors.primary40.withOpacity(0.1),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Tạo thư mục mới',
                style: TextStyle(
                  color: AppColors.primary40,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          child: Obx(
            () => controller.isLoading.value
                ? _buildLoading()
                : controller.listVocabCollection.value.isNotEmpty
                    ? SizedBox(
                        width: deviceWidth * 0.5,
                        height: deviceWidth * 0.5,
                        child: Lottie.asset(
                            'assets/images/lottie/ic_nodata3.json'),
                      )
                    : _buildGridviewBuilder(),
          ),
        ),
      ],
    );
  }

  GridView _buildGridviewBuilder() {
    return GridView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        //childAspectRatio: 0.66,
        crossAxisSpacing: 2,
        mainAxisSpacing: 5,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ItemCollectionVocab(
          image: 'image',
          title: 'Tạo bộ từ mới',
          isCreateButton: false,
          onPressed: () {},
        );
      },
    );
  }

  Center _buildLoading() {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: AppColors.primary40,
        size: 200,
      ),
    );
  }

  Column _buildVocabRecentScrollable(
    double deviceHeight,
    double deviceWidth,
    VocabScreenController controller,
  ) {
    return Column(
      children: [
        _buildHeaderText(
          deviceHeight,
          'Các từ gần đây',
        ),
        SizedBox(
          height: deviceHeight * 0.2,
          child: Obx(
            () => controller.isLoading.value
                ? _buildLoading()
                : controller.listVocabRecent.value.isEmpty
                    ? Lottie.asset('assets/images/lottie/ic_nodata2.json')
                    : _buildListviewBuilder(controller.listVocabRecent.value),
          ),
        ),
      ],
    );
  }

  ListView _buildListviewBuilder(List<Map<String, dynamic>> list) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return ItemRecentVocab(
          phonetic: '/kɑː/',
          enWordForm: 'Car',
          translatedWordForm: 'Xe',
          onSpeak: () {},
          onSaving: () {},
        );
      },
    );
  }

  Column _buildVocabSavedScrollable(
    double deviceHeight,
    double deviceWidth,
    VocabScreenController controller,
  ) {
    return Column(
      children: [
        _buildHeaderText(
          deviceHeight,
          'Từ vựng đã lưu',
        ),
        SizedBox(
          height: deviceHeight * 0.2,
          child: Obx(
            () => controller.isLoading.value
                ? _buildLoading()
                : controller.listVocabSaved.value.isEmpty
                    ? Lottie.asset('assets/images/lottie/ic_nodata1.json')
                    : _buildListviewBuilder(controller.listVocabSaved.value),
          ),
        ),
      ],
    );
  }

  Align _buildHeaderText(double deviceHeight, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: deviceHeight * 0.01,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Kho từ',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    );
  }
}
