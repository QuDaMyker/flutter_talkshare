import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/models/translation_model.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/vocab_bottom_sheet/controller/bottom_sheet_vocab_controller.dart';
import 'package:flutter_talkshare/utils/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class BottomSheetVocab extends StatelessWidget {
  const BottomSheetVocab({super.key, required this.word});
  final String word;

  @override
  Widget build(BuildContext context) {
    debugPrint('bắt đâu build bottom sheet cho từ: $word');

    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final BottomSheetVocabController controller =
        Get.put(BottomSheetVocabController(word: word))..getTranslate();
    return Container(
      width: deviceWidth,
      child: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return controller.isNotFound.value
                ? Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    width: deviceWidth,
                    height: deviceHeight * 0.45,
                    child: Column(
                      children: [
                        SizedBox(
                          width: deviceWidth * 0.7,
                          height: deviceWidth * 0.7,
                          child: Lottie.asset(
                              'assets/images/lottie/ic_nodata2.json'),
                        ),
                        const Text('Không tìm thấy từ bạn cần'),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('Thử lại'),
                        ),
                      ],
                    ),
                  )
                : Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    width: deviceWidth,
                    height: deviceHeight * 0.45,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * 0.05,
                        vertical: deviceHeight * 0.02,
                      ),
                      child: Column(
                        //cột tônger
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Row cho vocab
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    word,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    controller.translationModel?.phonetic ?? '',
                                    style: GoogleFonts.voces(),
                                    // style: const TextStyle(
                                    //   fontSize: 16,
                                    //   fontWeight: FontWeight.w400,
                                    //   color: AppColors.gray20,
                                    // ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() {
                                    return InkWell(
                                      child: controller.isSave.value
                                          ? SvgPicture.asset(
                                              ImageAssets.icSaved,
                                              width: 24,
                                              height: 24,
                                            )
                                          : SvgPicture.asset(
                                              ImageAssets.icSave,
                                              width: 24,
                                              height: 24,
                                            ),
                                      onTap: () {
                                        debugPrint('Lưu từ này');
                                        controller.onPressBookmark();
                                      },
                                    );
                                  }),
                                  const SizedBox(width: 15),
                                  InkWell(
                                      child: SvgPicture.asset(
                                          ImageAssets.icSpeaker),
                                      onTap: () async {
                                        // controller.playAudio(controller
                                        //     .searchedVocab.audioUrl
                                        //     .toString());
                                        Helper.instance.playWithTTS(word);
                                      }),
                                  const SizedBox(width: 15),
                                  InkWell(
                                      child:
                                          SvgPicture.asset(ImageAssets.icClose),
                                      onTap: () {
                                        // controller.onClose();
                                        // Get.back();
                                        debugPrint('click close bottom sheet');
                                        Navigator.pop(context);
                                        controller.onClose();
                                      }),
                                ],
                              ),
                            ],
                          ),
                          //hiển thị definitons
                          SizedBox(
                            height: deviceHeight * 0.35,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: ListView.builder(
                                  itemCount: controller
                                      .translationModel?.definition?.length,
                                  itemBuilder: (context, index) {
                                    String? partOfSpeech = controller
                                        .translationModel
                                        ?.definition?[index]
                                        .partOfSpeech;

                                    List<Definition>? listDef =
                                        controller.translationModel?.definition;
                                    return ItemPartOfSpeech(
                                        listDef: listDef,
                                        partOfSpeech: partOfSpeech);
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          }
        },
      ),
    );
  }
}

class ItemPartOfSpeech extends StatelessWidget {
  const ItemPartOfSpeech(
      {super.key, required this.listDef, required this.partOfSpeech});
  final String? partOfSpeech;
  final List<Definition>? listDef;

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //bọc part of speech
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.secondary80,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            partOfSpeech ?? '',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.secondary20,
            ),
          ),
        ),
        const SizedBox(height: 4),
        //hiện các def
        Column(
          children: List.generate(listDef?.length ?? 0, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(ImageAssets.triangleRight),
                  const SizedBox(
                    width: 4,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: deviceWidth * 0.8,
                        child: Text(
                          listDef?[index].meaningEn ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: deviceWidth * 0.8,
                        child: Text(
                          listDef?[index].meaningVi ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.withOpacity(0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
