import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/models/folder.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class CustomBottomSheetController extends GetxController {
  late TextEditingController textController;
  var nameOfFolder = Rx<String>('');
  @override
  void onInit() {
    textController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> onCreateNewFolder() async {
    Folder folder = Folder(
      folderId: 'folderId',
      name: nameOfFolder.value,
      userId: 'f6d32d14-961c-4fba-94ff-7e76f9031a09',
    );
    int result = await SupabaseService.instance.insertFolder(folder);
    if (result == 200) {
      Get.back();
      Get.snackbar("Thêm thành công", 'Thêm thành công thư mục ${folder.name}');
    } else {
      Get.back();
    }
  }
}
