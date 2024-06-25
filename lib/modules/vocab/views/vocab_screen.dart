import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/create_new_list_vocab/view/creare_new%20_list_vocab_screen.dart';
import 'package:flutter_talkshare/modules/vocab/widgets/item_saved_vocab.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/vocab/controller/custom_bottom_sheet_controller.dart';
import 'package:flutter_talkshare/modules/vocab/controller/vocab_screen_controller.dart';
import 'package:flutter_talkshare/modules/vocab/widgets/custom_bottom_sheet.dart';
import 'package:flutter_talkshare/modules/vocab/widgets/item_collection_vocal.dart';
import 'package:flutter_talkshare/modules/vocab/widgets/item_create_new_word_set.dart';
import 'package:flutter_talkshare/modules/vocab/widgets/item_recent_vocab.dart';
import 'package:flutter_talkshare/modules/vocab_list/views/vocab_list_screen.dart';

import '../../../utils/helper.dart';

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
        body: _buildBody(
            context, deviceHeight, deviceWidth, vocabScreenController),
      ),
    );
  }

  Padding _buildBody(
    BuildContext context,
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
                context,
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
    BuildContext context,
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
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => const CustomBottomSheet(),
                ).whenComplete(() async {
                  Get.delete<CustomBottomSheetController>();
                });
              },
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
                : controller.listVocabCollection.value.isEmpty
                    ? SizedBox(
                        width: deviceWidth * 0.5,
                        height: deviceWidth * 0.5,
                        child: Lottie.asset(
                            'assets/images/lottie/ic_nodata3.json'),
                      )
                    : _buildGridviewBuilder(controller),
          ),
        ),
      ],
    );
  }

  GridView _buildGridviewBuilder(VocabScreenController controller) {
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
      itemCount: controller.listVocabCollection.value.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return GestureDetector(
            onTap: () {
              // navigato  screen create folder
              Get.to(CreateNewListVocabScreen());
            },
            child: ItemCreateNewWordset(
              onPressed: () {
                Get.to(CreateNewListVocabScreen());
              },
            ),
          );
        } else {
          return ItemCollectionVocab(
            wordSet: controller.listVocabCollection.value[index],
            onPressed: () {
              Get.to(
                VocabListScreen(
                  wordSet: controller.listVocabCollection.value[index],
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildLoading() {
    return Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: const Color(0xfffe0079),
        rightDotColor: const Color(0xff0056d6),
        size: 20,
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
                    : _buildListviewRecentBuilder(
                        controller.listVocabRecent.value, controller),
          ),
        ),
      ],
    );
  }

  ListView _buildListviewRecentBuilder(
    List<Vocab> list,
    VocabScreenController controller,
  ) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ItemRecentVocab(
          phonetic: list[index].phonetic ?? '',
          enWordForm: list[index].word,
          translatedWordForm: list[index].primaryMeaning,
        );
      },
    );
  }

  ListView _buildListviewSavedBuilder(
    List<Vocab> list,
    VocabScreenController controller,
  ) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (context, index) {
        return ItemSavedVocab(
          phonetic: list[index].phonetic ?? '',
          enWordForm: list[index].word,
          translatedWordForm: list[index].primaryMeaning,
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
                    : _buildListviewSavedBuilder(
                        controller.listVocabSaved.value, controller),
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
