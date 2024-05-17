import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/auth/views/login_screen.dart';
import 'package:flutter_talkshare/modules/auth/widgets/custom_text_field.dart';
import 'package:flutter_talkshare/modules/auth/widgets/email_text_field.dart';
import 'package:flutter_talkshare/modules/auth/widgets/password_text_field.dart';
import 'package:flutter_talkshare/utils/helper.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final GlobalKey<FormState> formKeySignUp;
  late final TextEditingController emailController;
  late final TextEditingController fullNameController;
  late final TextEditingController passwordController;
  late final TextEditingController repeatPasswordController;
  final AuthController _authController = Get.find<AuthController>();
  @override
  void initState() {
    formKeySignUp = GlobalKey<FormState>();
    emailController = TextEditingController();
    fullNameController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: -200,
              left: -Get.width * 0.2,
              child: _buildBackground(colors: [
                AppColors.secondary80,
                AppColors.primary40,
                AppColors.secondary80,
              ]),
            ),
            Positioned(
              bottom: -200,
              left: -Get.width * 0.12,
              child: _buildBackground(
                colors: [
                  AppColors.primary40,
                  AppColors.primary50,
                  AppColors.primary40,
                ],
              ),
            ),
            Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildLogoLogin(),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildFormField(),
                    const SizedBox(
                      height: 30,
                    ),
                    _buildNavigateLogIn(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildNavigateLogIn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Bạn đã có tài khoản?',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary40,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
          child: Text(
            'Đăng nhập ngay',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Container _buildBackground({required List<Color> colors}) {
    return Container(
      width: Get.width * 2,
      height: Get.width * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary40,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: colors,
        ),
      ),
    );
  }

  Container _buildFormField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 0.5, color: AppColors.gray60),
          bottom: BorderSide(width: 0.5, color: AppColors.gray60),
          right: BorderSide(width: 0.5, color: AppColors.gray60),
          left: BorderSide(width: 0.5, color: AppColors.gray60),
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Form(
        key: formKeySignUp,
        child: Column(
          children: [
            EmailTextField(
              controller: emailController,
              prefixIcon: ImageAssets.icEmail,
              title: 'Email',
              authController: _authController,
              onValidate: (p0) => Helper.instance.isValidEmail(email: p0),
              errorMessage:
                  'Vui lòng nhập đúng định dạng email. Ví dụ: abc@gmail.com',
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: fullNameController,
              prefixIcon: ImageAssets.icFullName,
              title: 'Họ tên',
              authController: _authController,
            ),
            const SizedBox(
              height: 20,
            ),
            PasswordTextField(
              controller: passwordController,
              prefixIcon: ImageAssets.icPassword,
              title: 'Mật khẩu',
              authController: _authController,
              onValidate: (p0) => Helper.instance.isValidPassword(password: p0),
              errorMessage:
                  'Mật khẩu phải chứa ít nhất một chữ hoa, ít nhất một chữ thường, ít nhất một chữ số, ít nhất một ký tự đặc biệt, dài ít nhất 8 ký tự',
            ),
            const SizedBox(
              height: 20,
            ),
            PasswordTextField(
              controller: repeatPasswordController,
              prefixIcon: ImageAssets.icPassword,
              title: 'Xác nhận mật khẩu',
              authController: _authController,
              onValidate: (p0) => Helper.instance.isValidPassword(password: p0),
              errorMessage:
                  'Mật khẩu phải chứa ít nhất một chữ hoa, ít nhất một chữ thường, ít nhất một chữ số, ít nhất một ký tự đặc biệt, dài ít nhất 8 ký tự',
            ),
            const SizedBox(
              height: 20,
            ),
            _buildButtonSignUp(controller: _authController),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonSignUp({required AuthController controller}) {
    return Obx(
      () => controller.isLoadingSignUp.value
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary40,
              ),
            )
          : GestureDetector(
              onTap: () async {
                if (formKeySignUp.currentState!.validate()) {
                  formKeySignUp.currentState!.save();

                  await controller.onSignUp(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                    fullname: fullNameController.text.trim(),
                  );
                }
                // await controller.onSignUp(
                //   email: 'nthienphu634@gmail.com',
                //   password: 'Test@123456',
                //   fullname: 'Pham Quoc Danh',
                // );
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: AppColors.secondary20,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Đăng ký',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Column _buildLogoLogin() {
    return Column(
      children: [
        SvgPicture.asset(
          ImageAssets.icAuth,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Đăng ký',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        const Text(
          'Tạo tài khoản mới',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
