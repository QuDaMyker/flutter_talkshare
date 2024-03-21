import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/vocab_bottom_sheet/controller/bottom_sheet_vocab_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetVocab extends StatelessWidget {
  const BottomSheetVocab({super.key, required this.word});
  final String word;
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final BottomSheetVocabController controller =
        Get.put(BottomSheetVocabController(word: word));

    return Obx(
      () {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Container(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.searchedVocab.word,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              controller.searchedVocab.phonetic.toString(),
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
                            InkWell(
                              child: SvgPicture.asset(
                                ImageAssets.icSave,
                                width: 24,
                                height: 24,
                              ),
                              onTap: () {},
                            ),
                            const SizedBox(width: 15),
                            InkWell(
                                child: SvgPicture.asset(ImageAssets.icSpeaker),
                                //onTap: () {},
                                onTap: () async {
                                  //về test
                                  controller.playAudio(controller.searchedVocab.audioUrl.toString());
                                }),
                            const SizedBox(width: 15),
                            InkWell(
                                child: SvgPicture.asset(ImageAssets.icClose),
                                onTap: () {}),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class ItemVocabMeaning extends StatelessWidget {
  const ItemVocabMeaning({super.key, required this.vocab});
  final Vocab vocab;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vocab.word,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              vocab.phonetic.toString(),
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
            InkWell(
              child: SvgPicture.asset(
                ImageAssets.icSave,
                width: 24,
                height: 24,
              ),
              onTap: () {},
            ),
            const SizedBox(width: 15),
            InkWell(
                child: SvgPicture.asset(ImageAssets.icSpeaker),
                //onTap: () {},
                onTap: () async {}),
            const SizedBox(width: 15),
            InkWell(child: SvgPicture.asset(ImageAssets.icClose), onTap: () {}),
          ],
        ),
      ],
    );
  }
}
