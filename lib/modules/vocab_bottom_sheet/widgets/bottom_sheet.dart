import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
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
                              'trace',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              '/treis/',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.gray20,
                              ),
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
                            SizedBox(width: 15),
                            InkWell(
                              child: SvgPicture.asset(ImageAssets.icSpeaker),
                              onTap: () {},
                              // onTap: () async {
                              //   await controller.getWord('Hot');
                              // }
                            ),
                            SizedBox(width: 15),
                            InkWell(
                                child: SvgPicture.asset(ImageAssets.icClose),
                                onTap: () {}),
                          ],
                        ),
                      ],
                    ),
                    //nội dung phần nghĩa scroll được
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: SizedBox(
                        height: deviceHeight * 0.325,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary80,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'noun',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.secondary20,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(ImageAssets.triangleRight),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'Dấu vết, vết tích',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(ImageAssets.triangleRight),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'một chút, tý chút',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary80,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'verb',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.secondary20,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(ImageAssets.triangleRight),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'theo vết, lân theo giấu vết',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(ImageAssets.triangleRight),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'tìm nguồn gốc, truy tìm',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(ImageAssets.triangleRight),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'vạch ra, phác thảo',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(ImageAssets.triangleRight),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'vạch ra, phác thảo',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(ImageAssets.triangleRight),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'vạch ra, phác thảo',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(ImageAssets.triangleRight),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'vạch ra, phác thảo',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(ImageAssets.triangleRight),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      'vạch ra, phác thảo',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
