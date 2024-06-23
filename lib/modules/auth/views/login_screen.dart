import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/auth/views/forgot_password_srceen.dart';
import 'package:flutter_talkshare/modules/auth/views/sign_up_screen.dart';
import 'package:flutter_talkshare/modules/auth/widgets/email_text_field.dart';
import 'package:flutter_talkshare/modules/auth/widgets/password_text_field.dart';
import 'package:flutter_talkshare/utils/helper.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GlobalKey<FormState> formKeyLogin;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    formKeyLogin = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
              left: -Get.width * 0.12,
              child: _buildBackground(),
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
                    _buildFormField(authController: _authController),
                    const SizedBox(
                      height: 30,
                    ),
                    _buildDivider(),
                    const SizedBox(
                      height: 30,
                    ),
                    _buildButtonGoogle(onClick: () async {
                      await _authController.onGoogleAuth();
                    }),
                    const SizedBox(
                      height: 30,
                    ),
                    _buildNavigateSignUp(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildNavigateSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Bạn chưa có tài khoản?',
          style: TextStyle(
            color: AppColors.gray20,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary40,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            );
          },
          child: Text(
            'Đăng ký ngay',
            style: TextStyle(
              color: AppColors.primary40,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonGoogle({required Function onClick}) {
    return GestureDetector(
      onTap: () async {
        onClick();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: AppColors.gray20),
            bottom: BorderSide(width: 1, color: AppColors.gray20),
            right: BorderSide(width: 1, color: AppColors.gray20),
            left: BorderSide(width: 1, color: AppColors.gray20),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(ImageAssets.icGoogle),
            const SizedBox(
              width: 4,
            ),
            const Text(
              'Đăng nhập với Google',
              style: TextStyle(
                color: AppColors.primary40,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildBackground() {
    return Container(
      width: Get.width * 2,
      height: Get.width * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary40,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.primary40,
            AppColors.primary50,
          ],
        ),
      ),
    );
  }

  Padding _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Divider(
              color: AppColors.gray20,
              height: 1,
            ),
          ),
          Expanded(
            flex: 1,
            child: const Text(
              'hoặc',
              style: TextStyle(
                color: Color.fromRGBO(132, 132, 132, 1),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Divider(
              color: AppColors.gray20,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildFormField({required AuthController authController}) {
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
        key: formKeyLogin,
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
            PasswordTextField(
              controller: passwordController,
              prefixIcon: ImageAssets.icPassword,
              title: 'Mật khẩu',
              authController: _authController,
              onValidate: (p0) => Helper.instance.isValidPassword(password: p0),
              errorMessage:
                  'Mật khẩu phải chứa ít nhất một chữ hoa, ít nhất một chữ thường, ít nhất một chữ số, ít nhất một ký tự đặc biệt, dài ít nhất 8 ký tự',
            ),
            _buildButtonForgotPassword(),
            _buildButtonLogin(controller: _authController),
          ],
        ),
      ),
    );
  }

  Align _buildButtonForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary40,
        ),
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ForgotPasswordScreen(),
            ),
          );
        },
        child: const Text(
          'Quên mật khẩu',
          style: TextStyle(
            color: AppColors.primary40,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildButtonLogin({required AuthController controller}) {
    return Obx(
      () => controller.isLoadingLogin.value
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary40,
              ),
            )
          : GestureDetector(
              onTap: () async {
                if (formKeyLogin.currentState!.validate()) {
                  formKeyLogin.currentState!.save();

                  await controller.onLogin(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                }

                // await controller.onLogin(
                //   email: 'nthienphu634@gmail.com',
                //   password: 'Test@123456',
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
                        'Đăng nhập',
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
          'Chào mừng bạn trở lại!',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        const Text(
          'Đăng nhập vào tài khoản của bạn',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
