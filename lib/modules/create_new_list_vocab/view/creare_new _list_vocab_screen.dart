import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/create_new_list_vocab/controller/create_new_list_vocab_controller.dart';
import 'package:flutter_talkshare/utils/helper.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
          child: _builBody(context, deviceHeight, deviceWidth)),
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
    BuildContext context,
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
                    Obx(() => Positioned(
                          left: deviceWidth * 0.3,
                          child: Container(
                            width: deviceWidth * 0.3,
                            height: deviceWidth * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: controller.pickedImage.value != null
                                  ? DecorationImage(
                                      image: FileImage(
                                          controller.pickedImage.value!),
                                      fit: BoxFit.cover)
                                  : DecorationImage(
                                      image: AssetImage(ImageAssets.imageFish),
                                      fit: BoxFit.cover),
                            ),
                          ),
                        )),
                    Positioned(
                      top: deviceHeight * 0.12,
                      child: InkWell(
                        child: SvgPicture.asset(ImageAssets.icCamera),
                        onTap: () {
                          controller.pickImage(source: ImageSource.gallery);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                TextField(
                  controller: controller.nameTextCtrl,
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
                  controller: controller.folderTextCtrl,
                  onTap: () {
                    showModalBottomSheet(
                        useRootNavigator: true,
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Obx(() => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Chọn thư mục",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: AppColors.primary20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: SvgPicture.asset(
                                              ImageAssets.icClose2),
                                        )
                                      ],
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Không có",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.primary20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )
                                        ],
                                      ),
                                      trailing: Transform.scale(
                                        scale: 1,
                                        child: Radio(
                                          groupValue: controller.selectedFolder
                                                  .value?.hashCode ??
                                              0,
                                          value: 0,
                                          activeColor: AppColors.secondary20,
                                          onChanged: (int? value) {
                                            // controller.selectedType.value =
                                            //     value ?? 0;
                                            // controller.filter("Tất cả");
                                            // Get.back();
                                            controller.selectedFolder.value =
                                                null;
                                            controller.folderTextCtrl.text = '';
                                            Get.back();
                                          },
                                        ),
                                      ),
                                      onTap: () {
                                        // Get.back();
                                      },
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.listFolder.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  controller
                                                      .listFolder[index].name,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color:
                                                          AppColors.primary20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              )
                                            ],
                                          ),
                                          trailing: Transform.scale(
                                            scale: 1,
                                            child: Radio(
                                              groupValue: controller
                                                      .selectedFolder
                                                      .value
                                                      ?.hashCode ??
                                                  0,
                                              value: controller
                                                  .listFolder[index].hashCode,
                                              activeColor:
                                                  AppColors.secondary20,
                                              onChanged: (int? value) {
                                                controller
                                                        .selectedFolder.value =
                                                    controller
                                                        .listFolder[index];
                                                controller.folderTextCtrl.text =
                                                    controller
                                                        .listFolder[index].name;
                                                Get.back();
                                              },
                                            ),
                                          ),
                                          onTap: () {
                                            // Get.back();
                                          },
                                        );
                                      },
                                    )
                                  ],
                                )),
                          );
                        });
                  },
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
                  onTap: () async {
                    controller.onCreate();
                    Get.back();
                  },
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
