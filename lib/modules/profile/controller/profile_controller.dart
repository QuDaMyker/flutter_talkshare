import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class ProfileController extends GetxController {
  var focuseDay = Rx<DateTime>(DateTime.now());
  DateTime? _selectedDay;

  @override
  void onInit() {
    _selectedDay = focuseDay.value;
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onDaySelected(DateTime selectedDay, DateTime fDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      _selectedDay = selectedDay;
      focuseDay.value = fDay;
    }
  }
}
