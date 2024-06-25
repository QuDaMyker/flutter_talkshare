import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/models/definition.dart';
import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:flutter_talkshare/core/models/wordset.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/vocab_list/controllers/vocab_list_screen_controller.dart';
import 'package:flutter_talkshare/modules/vocab_list/widgets/item_vocab_list.dart';
import 'package:flutter_talkshare/modules/vocab_list_detail/views/vocab_list_detail.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/helper.dart';

class VocabListScreen extends StatelessWidget {
  const VocabListScreen({
    super.key,
    required this.wordSet,
  });
  final WordSet wordSet;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final VocabListScreenController vocabListScreenController =
        Get.put(VocabListScreenController(wordsetId: wordSet.wordsetId));
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(deviceHeight, deviceWidth, vocabListScreenController),
        bottomNavigationBar:
            _buildButton(deviceHeight, deviceWidth, vocabListScreenController),
      ),
    );
  }

  Widget _buildButton(
    double deviceHeight,
    double deviceWidth,
    VocabListScreenController controller,
  ) {
    return GestureDetector(
      onTap: () {
        if (controller.listVocab.value.isNotEmpty &&
            controller.listVocab.value.length > 3) {
          Get.to(
            () => VocabListDetailScreen(
              listVocabAddToCard: controller.listVocab.value,
            ),
          );
        }
      },
      child: Obx(
        () => controller.listVocab.value.isNotEmpty &&
                controller.listVocab.value.length > 0
            ? Container(
                padding: EdgeInsets.symmetric(
                  vertical: deviceHeight * 0.012,
                ),
                margin: EdgeInsets.only(
                  left: deviceWidth * 0.1,
                  right: deviceWidth * 0.1,
                  bottom: 40,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.secondary20,
                  border: Border(
                    top: BorderSide(color: Colors.transparent, width: 0),
                    bottom: BorderSide(color: Colors.transparent, width: 0),
                    right: BorderSide(color: Colors.transparent, width: 0),
                    left: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.copy_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      'Học bộ từ này',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  Padding _buildBody(
    double deviceHeight,
    double deviceWidth,
    VocabListScreenController controller,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        right: deviceWidth * 0.05,
        left: deviceWidth * 0.05,
      ),
      child: Obx(
        () => controller.isLoading.value
            ? _buildLoading()
            : controller.listVocab.value.isNotEmpty
                ? SingleChildScrollView(
                    child: SizedBox(
                      child: _buildListviewBuilder(
                          deviceHeight, deviceWidth, controller),
                    ),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Lottie.asset(
                      'assets/images/lottie/ic_nodata2.json',
                      width: 200,
                      height: 200,
                    ),
                  ),
      ),
    );
  }

  Widget _buildListviewBuilder(
    double deviceHeight,
    double deviceWidth,
    VocabListScreenController controller,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          constraints: BoxConstraints(maxHeight: deviceHeight - 180),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: controller.listVocab.value.length,
            itemBuilder: (context, index) {
              Vocab vocab = controller.listVocab.value[index];
              return ItemVocabList(
                enWordForm: vocab.word,
                translatedWordForm: vocab.primaryMeaning,
                //typeOfWord: vocab.,
                onSpeak: () {
                  Helper.instance.playWithTTS(vocab.word);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: AppColors.primary40,
        size: 200,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        wordSet.name,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    );
  }
}
