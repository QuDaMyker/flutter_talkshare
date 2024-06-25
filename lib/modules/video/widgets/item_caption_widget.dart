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
    bool isSelected = itemCaptionModel.isSelected;
    return Container(
      constraints: const BoxConstraints(minHeight: 60),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.secondary60 : Colors.transparent,
        border: const Border(
          //top: BorderSide(width: 0.5, color: AppColors.gray20),
          bottom: BorderSide(width: 2, color: AppColors.primary40),
          //right: BorderSide(width: 0.5, color: AppColors.primary40),
          left: BorderSide(width: 2, color: AppColors.primary40),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              Helper.instance
                  .formatDuration(itemCaptionModel.subtitleModel.start),
              style: isSelected
                  ? TextStyle(
                      color: AppColors.primary40,
                      fontWeight: FontWeight.w700,
                    )
                  : TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
            ),
          ),
          VerticalDivider(
            width: 10,
            thickness: 0.5,
            color: Colors.black,
          ),
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                Helper.instance.upperCaseFirstChar(
                  itemCaptionModel.subtitleModel.content.toString(),
                ),
                style: isSelected
                    ? TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      )
                    : TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
