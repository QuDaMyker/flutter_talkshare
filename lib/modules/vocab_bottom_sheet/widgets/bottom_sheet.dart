import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/models/definition.dart';
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
          return Container(
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
                              onTap: () async {
                                controller.playAudio(controller
                                    .searchedVocab.audioUrl
                                    .toString());
                              }),
                          const SizedBox(width: 15),
                          InkWell(
                              child: SvgPicture.asset(ImageAssets.icClose),
                              onTap: () {}),
                        ],
                      ),
                    ],
                  ),
                  //hiển thị definitons
                  Container(
                    height: deviceHeight * 0.35,
                    color: Colors.amber,
                    child: ListView.builder(
                        itemCount: controller.listDefinitions.length,
                        itemBuilder: (context, index) {
                          String partOfSpeech =
                              controller.listDefinitions.keys.elementAt(index);
                          List<Definition> listDef =
                              controller.listDefinitions[partOfSpeech]!;
                          return ItemPartOfSpeech(
                              listDef: listDef, partOfSpeech: partOfSpeech);
                        }),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class ItemPartOfSpeech extends StatelessWidget {
  const ItemPartOfSpeech(
      {super.key, required this.listDef, required this.partOfSpeech});
  final String partOfSpeech;
  final List<Definition> listDef;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //part of speech
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.secondary80,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            partOfSpeech,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.secondary20,
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height:60,
          child: ListView.builder(
              itemCount: listDef.length,
              itemBuilder: ((context, index) {
                return ItemDefinition(
                  def: listDef[index],
                );
              })),
        )
      ],
    );
  }
}

class ItemDefinition extends StatelessWidget {
  const ItemDefinition({super.key, required this.def});

  final Definition def;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(ImageAssets.triangleRight),
            const SizedBox(
              width: 4,
            ),
            Text(
              def.meaning,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        if (def.example != Null && def.example!.isNotEmpty)
          Text(
            'Ex: ${def.example!}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        const SizedBox(height: 4),
      ],
    );
  }
}
