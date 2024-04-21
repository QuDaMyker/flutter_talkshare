import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/video/models/item_caption_model.dart';
import 'package:flutter_talkshare/utils/helper.dart';

class ItemCaptionWidget extends StatelessWidget {
  const ItemCaptionWidget({
    super.key,
    required this.itemCaptionModel,
  });

  final ItemCaptionModel itemCaptionModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      //constraints: const BoxConstraints(minHeight: 60),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        color:
            itemCaptionModel.isSelected ? AppColors.gray60 : Colors.transparent,
        border: const Border(
          top: BorderSide(width: 0.5, color: AppColors.gray20),
          bottom: BorderSide(width: 0.5, color: AppColors.gray20),
          right: BorderSide(width: 0.5, color: AppColors.gray20),
          left: BorderSide(width: 0.5, color: AppColors.gray20),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Text(formatDuration(itemCaptionModel.subtitleModel.start)),
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                itemCaptionModel.subtitleModel.content.toString(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
