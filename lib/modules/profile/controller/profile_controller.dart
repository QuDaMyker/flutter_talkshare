import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/profile/services/point_learning_services.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class ProfileController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  var focuseDay = Rx<DateTime>(DateTime.now());
  var sumPoint = Rx<int>(0);
  var streakCount = Rx<int>(0);
  DateTime? _selectedDay;

  @override
  void onInit() async {
    _selectedDay = focuseDay.value;
    await getSumPoint(userId: authController.user.user_id);
    await getStreakDay();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getStreakDay() async {
    streakCount.value = (await PointLearningServices.instance
        .getStreakDay(user_id: authController.user.user_id))!;
  }

  void onDaySelected(DateTime selectedDay, DateTime fDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      _selectedDay = selectedDay;
      focuseDay.value = fDay;
    }
  }

  Future<void> getSumPoint({required String userId}) async {
    int? value =
        await PointLearningServices.instance.getSumPoint(userId: userId);
    if (value != null) {
      sumPoint.value = value;
    }
  }
}
