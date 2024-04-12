import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';

class ItemVocabList extends StatelessWidget {
  const ItemVocabList({
    super.key,
    required this.enWordForm,
    required this.translatedWordForm,
    required this.typeOfWord,
    required this.onSpeak,
  });

  final String enWordForm;
  final String translatedWordForm;
  final String typeOfWord;
  final Function onSpeak;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      constraints: const BoxConstraints(maxHeight: 80),
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.1,
      ),
      margin: EdgeInsets.only(
        bottom: deviceHeight * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
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
        borderRadius: const BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSourceWord(deviceHeight, deviceWidth),
          _buildTranslatedWord()
        ],
      ),
    );
  }

  Row _buildSourceWord(double deviceHeight, double deviceWidth) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                enWordForm,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
                maxLines: 2,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: _buildSpeakButton(deviceHeight, deviceWidth),
          ),
        ),
      ],
    );
  }

  Widget _buildSpeakButton(double deviceHeight, double deviceWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: deviceHeight * 0.005,
            horizontal: deviceWidth * 0.01,
          ),
          decoration: const BoxDecoration(
            color: AppColors.secondary80,
            borderRadius: BorderRadius.all(
              Radius.circular(
                8,
              ),
            ),
            border: Border(
              top: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
              bottom: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
              left: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
              right: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
          ),
          child: Text(
            typeOfWord,
            style: const TextStyle(
              color: AppColors.secondary20,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            textAlign: TextAlign.left,
            maxLines: 2,
          ),
        ),
        IconButton(
          onPressed: () => onSpeak(),
          icon: const Icon(
            Icons.volume_up_outlined,
          ),
        ),
      ],
    );
  }

  Align _buildTranslatedWord() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        translatedWordForm,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
