import 'package:flutter_talkshare/core/configuration/injection.dart';
import 'package:flutter_talkshare/core/values/constants.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/auth/views/login_screen.dart';
import 'package:flutter_talkshare/modules/root_view/view/root_view_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    Get.put(AuthController());
    Future.delayed(const Duration(seconds: 2), () async {
      final sharePreferences = await getIt<SharedPreferences>();
      sharePreferences.getBool(Constants.STATUS_AUTH) == true
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
