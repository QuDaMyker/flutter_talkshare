import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/vocab/controller/item_saved_vocab_controller.dart';
import 'package:flutter_talkshare/utils/helper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemSavedVocab extends StatelessWidget {
  const ItemSavedVocab({
    super.key,
    required this.phonetic,
    required this.enWordForm,
    required this.translatedWordForm,
  });
  final String phonetic;
  final String enWordForm;
  final String translatedWordForm;
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final itemSavedController = Get.put(
      ItemSavedVocabController(word: enWordForm),
      tag: enWordForm,
    );
    return Container(
      width: deviceWidth * 0.45,
      margin: EdgeInsets.only(
        right: deviceWidth * 0.01,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.03,
        vertical: deviceHeight * 0.001,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondary80,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.transparent,
          width: 2.5,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPhoneticAndEvent(itemSavedController),
          _buildEnWorkForm(),
          _buildTranslatedWordForm(),
        ],
      ),
    );
  }

  Text _buildTranslatedWordForm() {
    return Text(
      translatedWordForm,
      style: const TextStyle(
        color: AppColors.primary20,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Text _buildEnWorkForm() {
    return Text(
      enWordForm,
      style: const TextStyle(
        color: AppColors.secondary20,
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
    );
  }

  Row _buildPhoneticAndEvent(ItemSavedVocabController controller) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            phonetic,
            style: GoogleFonts.voces(color: Colors.black),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async {
                  // ENVENT SPEAK
                  playWithTTS(enWordForm);
                },
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: SvgPicture.asset(ImageAssets.icSpeaker),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () async {
                  controller.onPressBookmark();
                },
                child: Obx(
                  () => SizedBox(
                    width: 16,
                    height: 16,
                    child: controller.isBookmarkOn.value
                        ? SvgPicture.asset(
                            'assets/images/svg/ic_bookmark_on.svg')
                        : SvgPicture.asset(
                            'assets/images/svg/ic_bookmark_off.svg'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
