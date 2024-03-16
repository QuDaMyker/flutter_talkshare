import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/vocab_bottom_sheet/controller/bottom_sheet_item_controller.dart';
import 'package:get/get.dart';

class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem({super.key, required this.word});
  final String word;
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final BottomSheetItemController controller =
        Get.put(BottomSheetItemController(word: word));

    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
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
                padding: EdgeInsets.all(
                  deviceWidth * 0.01,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                       top: deviceHeight*0.02,
                       start: deviceWidth*0.06,
                       end: deviceWidth * 0.04,
                       bottom: deviceWidth *0.02 
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(     
                            crossAxisAlignment: CrossAxisAlignment.start,                                        
                            children: [
                              Text(                              
                                'trace',
                                style: const TextStyle(
                                  fontFamily: 'assets/fonts/Manrope-Bold.ttf',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '/treis/',
                                style: const TextStyle(
                                  fontFamily: 'assets/fonts/Manrope-Bold.ttf',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.bookmark_outline),
                                iconSize: 20,
                                color: AppColors.gray20,
                                onPressed: () async {
                                  await controller.getWord('Hot');
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.volume_up_outlined),
                                iconSize: 20,
                                color: AppColors.gray20,
                                onPressed: () async {
                                  await controller.getWord('Hot');
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                iconSize: 20,
                                color: AppColors.gray20,
                                onPressed: () async {
                                  await controller.getWord('Hot');
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
