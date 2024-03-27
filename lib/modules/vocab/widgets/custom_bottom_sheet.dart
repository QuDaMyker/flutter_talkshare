import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/vocab/controller/custom_bottom_sheet_controller.dart';
import 'package:get/get.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final CustomBottomSheetController bottomSheetController =
        Get.put(CustomBottomSheetController());
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(
            height: 24,
          ),
          _buildInputField(bottomSheetController),
          const SizedBox(
            height: 10,
          ),
          _buildButton(bottomSheetController),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildButton(CustomBottomSheetController controller) {
    return GestureDetector(
      onTap: () async {
        await controller.onCreateNewFolder();
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.secondary20,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Lưu',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildInputField(CustomBottomSheetController bottomSheetController) {
    return Column(
      children: [
        TextFormField(
          inputFormatters: [],
          maxLength: 30,
          cursorColor: AppColors.primary40,
          controller: bottomSheetController.textController,
          obscureText: false,
          onChanged: (value) {
            bottomSheetController.nameOfFolder.value = value;
          },
          decoration: InputDecoration(
            counterText: '',
            labelStyle: const TextStyle(
              color: AppColors.primary40,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.green,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.green,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            labelText: 'Tạo thư mục',
            suffixIcon:
                Obx(() => bottomSheetController.nameOfFolder.value.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          bottomSheetController.textController.clear();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SvgPicture.asset(ImageAssets.icClose),
                        ),
                      )
                    : const SizedBox()),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Obx(
            () => Text(
                '${bottomSheetController.nameOfFolder.value.length}/30 kí tự'),
          ),
        ),
      ],
    );
  }

  Row _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 24,
          height: 24,
        ),
        const Text(
          'Tạo thư mục mới',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        GestureDetector(
          onTap: () => Get.back(),
          child: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset(ImageAssets.icClose),
          ),
        ),
      ],
    );
  }
}
