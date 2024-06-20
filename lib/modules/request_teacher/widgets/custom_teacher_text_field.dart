import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/request_teacher/controller/request_teacher_controller.dart';
import 'package:get/get.dart';

class CustomTeacherTextField extends StatelessWidget {
  const CustomTeacherTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.requestTeacherController,
    this.maxLines = 1,
  });

  final String title;
  final TextEditingController controller;
  final RequestTeacherController requestTeacherController;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(
        () => TextFormField(
          maxLines: maxLines,
          enabled: !requestTeacherController.isLoadingSubmit.value,
          controller: controller,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng điền thông tin';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: AppColors.primary40,
          style: TextStyle(color: Colors.black, fontSize: 16),
          decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.red),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.red),
              borderRadius: BorderRadius.circular(12),
            ),
            errorMaxLines: 3,
            hintText: ' $title',
            isDense: false,
            hintStyle: const TextStyle(
              color: AppColors.gray40,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.gray40),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.gray40),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
