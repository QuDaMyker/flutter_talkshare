import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/vocab_bottom_sheet/widgets/bottom_sheet.dart';
import 'package:get/get.dart';

class VocalController extends GetxController {
  var index = Rx<int>(-1);

  @override
  void onInit() {
    print('oninit controller');
    super.onInit();
  }

  void tang() {
    index.value++;
    print(index.value);
  }

  void showNackbar(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('snack')));
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const BottomSheetItem(word: 'TRACE'),
    );
  }
}
