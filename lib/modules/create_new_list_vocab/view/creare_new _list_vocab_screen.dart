import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/create_new_list_vocab/controller/create_new_list_vocab_controller.dart';
import 'package:flutter_talkshare/utils/helper.dart';
import 'package:get/get.dart';

class CreateNewListVocabScreen extends StatelessWidget {
  CreateNewListVocabScreen({super.key});
  final CreateNewListVocabController controller =
      Get.put(CreateNewListVocabController());

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: AppColors.backgroundGradient,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: _builBody(deviceHeight, deviceWidth)),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Tạo bộ từ mới',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.primary20),
      ),
      leading: InkWell(
        child: Container(
          width: 34,
          height: 34,
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
          child: SvgPicture.asset(
            ImageAssets.icBack,
          ),
        ),
        onTap: () {
          Get.back();
        },
      ),
    );
  }

  Padding _builBody(
    double deviceHeight,
    double deviceWidth,
  ) {
    return Padding(
        padding: EdgeInsets.symmetric(
            vertical: deviceHeight * 0.02, horizontal: deviceWidth * 0.05),
        child: SizedBox(
            width: deviceWidth,
            height: deviceHeight,
            child: SingleChildScrollView(
              child: Column(children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: deviceWidth,
                      height: deviceHeight * 0.16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Positioned(
                      left: deviceWidth * 0.3,
                      child: Container(
                        width: deviceWidth * 0.3,
                        height: deviceWidth * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                              image: AssetImage(ImageAssets.imageFish),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Positioned(
                      top: deviceHeight * 0.12,
                      child: InkWell(
                        child: SvgPicture.asset(ImageAssets.icCamera),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                TextField(
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary20,
                      fontSize: 16),
                  decoration: InputDecoration(
                    labelText: 'Tên bộ từ',
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray40,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SvgPicture.asset(ImageAssets.icEdit),
                    ),
                    focusedBorder: Helper.instance.customBorderWhenFocus(),
                    enabledBorder: Helper.instance.customBorder(),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Bạn chỉ cần nhập từ, Talk Share sẽ tự động lấy nghĩa và ví dụ cho bạn',
                  style: TextStyle(
                    color: AppColors.gray40,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Obx(
                  () => Column(
                    children: [
                      for (int i = 0; i < controller.wordTCs.length; i++)
                        Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: TextField(
                              controller: controller.wordTCs[i],
                              onChanged: (value) {
                                if (i == controller.wordTCs.length - 1 &&
                                    value.isNotEmpty) {
                                  controller.wordTCs
                                      .add(TextEditingController());
                                }
                                if (value.isEmpty) {
                                  controller.wordTCs.removeAt(i);
                                }
                              },
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary20,
                                  fontSize: 16),
                              decoration: InputDecoration(
                                hintText:
                                    i == controller.wordTCs.length - 1 && i != 0
                                        ? 'Thêm từ vựng'
                                        : 'Từ vựng',
                                labelStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.gray40,
                                ),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: SvgPicture.asset(
                                      i == controller.wordTCs.length - 1 &&
                                              i != 0
                                          ? ImageAssets.icAdd2
                                          : ImageAssets.icTag),
                                ),
                                focusedBorder:
                                    Helper.instance.customBorderWhenFocus(),
                                enabledBorder: Helper.instance.customBorder(),
                              ),
                            )),
                    ],
                  ),
                ),
                TextField(
                  readOnly: true,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary20,
                      fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Thư mục',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SvgPicture.asset(ImageAssets.icFolder2),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SvgPicture.asset(ImageAssets.icChevronDown),
                    ),
                    focusedBorder: Helper.instance.customBorderWhenFocus(),
                    enabledBorder: Helper.instance.customBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppColors.secondary20,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Text(
                      'Lưu',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ]),
            )));
  }
}
