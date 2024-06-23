import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:get/get.dart';

class RepeatPasswordTextField extends StatelessWidget {
  const RepeatPasswordTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.prefixIcon,
    required this.authController,
    required this.errorMessage,
    this.comparePassword = '',
  });

  final String title;
  final String comparePassword;
  final String prefixIcon;
  final String errorMessage;
  final TextEditingController controller;
  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(
        () => TextFormField(
          enabled: !authController.isLoadingLogin.value,
          controller: controller,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng điền thông tin';
            }
            if (comparePassword != controller.text.trim()) {
              return errorMessage;
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: AppColors.primary40,
          style: TextStyle(color: AppColors.gray40, fontSize: 16),
          obscureText: authController.isObscureText.value,
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
                const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.gray40),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.gray40),
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                prefixIcon,
                fit: BoxFit.contain,
              ),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                authController.onObscureText();
              },
              icon: Icon(
                authController.isObscureText.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
            //prefix: const Icon(Icons.email_outlined),
          ),
        ),
      ),
    );
  }
}
