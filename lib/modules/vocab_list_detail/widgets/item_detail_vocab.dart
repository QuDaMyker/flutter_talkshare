import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/vocab_list_detail/controllers/item_detail_vocab_controller.dart';
import 'package:get/get.dart';

class ItemDetailVocav extends StatelessWidget {
  const ItemDetailVocav({super.key, required this.word});
  final String word;

  @override
  Widget build(BuildContext context) {
    final ItemDetailVocabController controller =
        Get.put(ItemDetailVocabController());
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return FlipCard(
      rotateSide: RotateSide.bottom,
      onTapFlipping:
          true, //When enabled, the card will flip automatically when touched.
      axis: FlipAxis.horizontal,
      controller: controller.con1,
      frontWidget: Container(
        margin: EdgeInsets.only(
          top: deviceHeight * 0.05,
          left: deviceWidth * 0.1,
          right: deviceWidth * 0.1,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
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
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              // child: IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     Icons.bookmark_border_outlined,
              //     size: deviceWidth * 0.1,
              //   ),
              // ),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Bookmark off')));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child:
                      SvgPicture.asset('assets/images/svg/ic_bookmark_on.svg'),
                ),
              ),
            ),
            const Spacer(),
            Container(
              // padding: EdgeInsets.only(
              //   top: deviceHeight * 0.2,
              //   bottom: deviceHeight * 0.2,
              //   left: deviceWidth * 0.1,
              //   right: deviceWidth * 0.1,
              // ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '$word + font',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      backWidget: Container(
        margin: EdgeInsets.only(
          top: deviceHeight * 0.05,
          left: deviceWidth * 0.1,
          right: deviceWidth * 0.1,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
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
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              // child: IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     Icons.volume_up_outlined,
              //     size: deviceWidth * 0.1,
              //   ),
              // ),
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Speaker')));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SvgPicture.asset('assets/images/svg/ic_speaker.svg'),
                ),
              ),
            ),
            const Spacer(),
            Container(
              // padding: EdgeInsets.only(
              //   top: deviceHeight * 0.2,
              //   bottom: deviceHeight * 0.2,
              //   left: deviceWidth * 0.1,
              //   right: deviceWidth * 0.1,
              // ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '$word back',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
