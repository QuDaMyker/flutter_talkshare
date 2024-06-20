import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/enums/role.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/auth/models/user_model.dart';
import 'package:flutter_talkshare/modules/auth/services/auth_services.dart';
import 'package:flutter_talkshare/modules/request_teacher/models/request_teacher_model.dart';
import 'package:flutter_talkshare/modules/request_teacher/services/request_teacher_controller.dart';
import 'package:flutter_talkshare/modules/request_teacher/widgets/dialog_request_teacher.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RequestTeacherController extends GetxController {
  var isLoadingSubmit = Rx<bool>(false);
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> setRole({
    required String agentName,
    required String teacherId,
    required String content,
  }) async {
    isLoadingSubmit.value = true;
    try {
      final AuthController authController = Get.find<AuthController>();
      RequestTeacherModelReq modelReq = RequestTeacherModelReq(
        user_id: authController.user.user_id,
        content: content,
        agent_name: agentName,
        teacher_id: teacherId,
      );

      var add = await RequestTeacherService.instance
          .addRequestTeacher(model: modelReq);

      if (add == true) {
        bool? result = await RequestTeacherService.instance.setRole(
          role: Role.ROLE_TEACHER.toStringValue,
          user_id: modelReq.user_id,
        );

        if (result == true) {
          UserModel? userModel = await AuthServices.instance
              .getUserFromDB(email: authController.user.email);
          if (userModel != null) {
            authController.user = userModel;
          }
          Get.dialog(
            PopScope(
              canPop: true,
              child: DialogRequestTeacher(
                pathBackgroundLottie:
                    'assets/images/lottie/ic_text_congratulation.json',
                pathLottie:
                    'assets/images/lottie/ic_effect_congratulation.json',
                titleButton:
                    'Gửi yêu cầu thành công, yêu cầu sẽ được xem xét trong 24h tiếp theo',
                onTap: () {
                  Navigator.pop(Get.context!);
                  Navigator.pop(
                    Get.context!,
                    {'result': 'success'},
                  );
                },
              ),
            ),
          );
        } else {}
      }
    } catch (e) {
      debugPrint('[RequestTeacherController][setRole]: ${e.toString()}');
    }

    isLoadingSubmit.value = false;
  }
}
