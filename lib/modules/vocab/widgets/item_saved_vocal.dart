import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';

class ItemSavedVocab extends StatelessWidget {
  const ItemSavedVocab({
    super.key,
    required this.phonetic,
    required this.enWordForm,
    required this.translatedWordForm,
    required this.onSpeak,
    required this.onSaving,
  });
  final String phonetic;
  final String enWordForm;
  final String translatedWordForm;
  final Function onSpeak;
  final Function onSaving;
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
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
          _buildPhoneticAndEvent(),
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

  Row _buildPhoneticAndEvent() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            phonetic,
            style: const TextStyle(
              color: AppColors.gray20,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => onSpeak,
                child: const Icon(
                  color: AppColors.gray20,
                  Icons.volume_up_outlined,
                ),
              ),
              InkWell(
                onTap: () => onSaving,
                child: const Icon(
                  color: AppColors.gray20,
                  Icons.bookmark_add_outlined,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
