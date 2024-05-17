import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/auth/views/login_screen.dart';
import 'package:flutter_talkshare/modules/root_view/view/root_view_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    final AuthController authController = Get.put(AuthController());
    Future.delayed(const Duration(seconds: 2), () async {
      // final sharePreferences = await getIt<SharedPreferences>();
      // sharePreferences.getBool(Constants.STATUS_AUTH) == true
      //     ? Get.offAll(() => RootViewScreen())
      //     : Get.offAll(() => LoginScreen());

      await authController.isLogin()
          ? Get.offAll(() => RootViewScreen())
          : Get.offAll(() => LoginScreen());
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
