import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/configuration/injection.dart';
import 'package:flutter_talkshare/core/values/constants.dart';
import 'package:flutter_talkshare/modules/auth/models/fail_model.dart';
import 'package:flutter_talkshare/modules/auth/models/meta_data_model.dart';
import 'package:flutter_talkshare/modules/auth/models/success_model.dart';
import 'package:flutter_talkshare/modules/auth/models/user_model.dart';
import 'package:flutter_talkshare/modules/auth/services/auth_services.dart';
import 'package:flutter_talkshare/modules/onboarding/views/onboarding_screen.dart';
import 'package:flutter_talkshare/modules/root_view/view/root_view_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  late UserModel user;

  var isLoadingLogin = Rx<bool>(false);
  var isLoadingSignUp = Rx<bool>(false);
  var isObscureText = Rx<bool>(true);

  @override
  void onInit() async {
    await isLogin();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onLogin({
    required String email,
    required String password,
  }) async {
    isLoadingLogin.value = true;

    var res = await AuthServices.instance
        .login(
          email: email,
          password: password,
        )
        .timeout(
          const Duration(seconds: 2),
          onTimeout: onTimeOut,
        );

    if (res.isRight) {
      final _user = await AuthServices.instance.getUserFromDB(email: email);
      if (_user != null) {
        user = _user;
        await saveUserString(user);
        Get.offAll(() => RootViewScreen());
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: const Text('Khong tim thay'),
          ),
        );
      }
    }
    isLoadingSignUp.value = false;
  }

  Future<void> onSignUp({
    required String email,
    required String password,
    required String fullname,
  }) async {
    isLoadingSignUp.value = true;
    var res = await AuthServices.instance.signUp(
      email: email,
      fullname: fullname,
      password: password,
    );

    if (res.isRight) {
      UserModel userModel = UserModel(
        user_id: res.right.user!.id,
        fullname: fullname,
        avatar_url: Constants.imageUser,
        email: email,
        password: password,
        isGoogle: false,
        role: Constants.ROLE_STUDENT,
      );
      var rs = await AuthServices.instance.addUserProfile(userModel: userModel);
      if (rs.isRight) {
        user = rs.right;
        // var sharePrefernces = await getIt<SharedPreferences>();
        // sharePrefernces.setBool(Constants.STATUS_AUTH, true);
        // sharePrefernces.setString(
        //     Constants.USER_STRING, userModel.toJson().toString());
        await saveUserString(user);
        Get.offAll(() => OnBoardingScreen());
      } else {
        if (rs.left.message.toString().contains('users_pkey')) {
          Get.snackbar(
              'Lỗi', 'Vui lòng kích hoạt tài khoản qua email để tiếp tục');
        }
        print(rs.left.message);
        Get.snackbar('Lỗi', rs.left.message);
      }
    } else {
      print('res is not AuthResponse');
    }
    isLoadingSignUp.value = false;
  }

  Future<void> onGoogleAuth() async {
    var res = await AuthServices.instance.nativeGoogleSignIn();
    if (res.isRight) {
      Get.snackbar('title', 'message');
      MetaDataModel metaDataModel = MetaDataModel.fromMap(
          res.right.user!.userMetadata as Map<String, dynamic>);
      user = UserModel(
        user_id: res.right.user!.id,
        fullname: metaDataModel.fullName,
        avatar_url: metaDataModel.avatarUrl,
        email: metaDataModel.email,
        isGoogle: true,
        role: Constants.ROLE_STUDENT,
      );
      var addDb = await AuthServices.instance.addUserProfile(userModel: user);
      if (addDb.isRight) {
        // var sharePrefernces = await getIt<SharedPreferences>();
        // sharePrefernces.setBool(Constants.STATUS_AUTH, true);
        await saveUserString(addDb.right);
        Get.offAll(() => RootViewScreen());
      } else {
        print(addDb.left);
        Get.snackbar('title', res.left.message);
      }
    } else {
      Get.snackbar('title', res.left.message);
    }
  }

  Future<Either<FailModel, SuccessModel>> onTimeOut() async {
    try {
      return Right(SuccessModel(message: 'Successfull'));
    } catch (e) {
      return Left(FailModel(message: e.toString()));
    }
  }

  void onObscureText() {
    isObscureText.value = !isObscureText.value;
  }

  Future<void> saveUserString(UserModel userModel) async {
    var sharePrefernces = await getIt<SharedPreferences>();
    sharePrefernces.setString(
        Constants.USER_STRING, userModel.toJson().toString());
  }

  Future<bool> isLogin() async {
    var sharePrefernces = await getIt<SharedPreferences>();
    String? userString = await sharePrefernces.getString(Constants.USER_STRING);
    if (userString == null) {
      return false;
    }
    user = UserModel.fromJson(userString);
    return true;
  }
}
