import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/auth/widgets/email_text_field.dart';
import 'package:flutter_talkshare/utils/helper.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late final GlobalKey<FormState> formKeyLogin;
  late final TextEditingController emailController;
  final AuthController _authController = Get.find<AuthController>();
  @override
  void initState() {
    formKeyLogin = GlobalKey<FormState>();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
                  ],
                ),
              ),
            ),
          ],
        ),
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
              title: 'Email đã đăng ký',
              authController: _authController,
              onValidate: (p0) => Helper.instance.isValidEmail(email: p0),
              errorMessage:
                  'Vui lòng nhập đúng định dạng email. Ví dụ: abc@gmail.com',
            ),
            const SizedBox(
              height: 20,
            ),
            _buildButtonLogin(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonLogin() {
    return Obx(
      () => _authController.isLoadingForgotPassword.value
          ? Center(
              child: LoadingAnimationWidget.discreteCircle(
                secondRingColor: AppColors.secondary20,
                thirdRingColor: AppColors.gray40,
                color: AppColors.primary40,
                size: 30,
              ),
            )
          : GestureDetector(
              onTap: () async {
                if (formKeyLogin.currentState!.validate()) {
                  formKeyLogin.currentState!.save();

                  await _authController.forgotPassword(
                      email: emailController.text.trim());
                }
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
          'Yêu cầu quên mật khẩu!',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        const Text(
          'Chúng tôi luôn ở đây để giúp đỡ bạn',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
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
}
