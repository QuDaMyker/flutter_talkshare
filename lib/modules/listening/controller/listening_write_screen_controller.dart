import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/models/listening.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:get/get.dart';
class ListeningWriteScreenController extends GetxController{
  RxBool isTextFieldVisible = false.obs;

  @override
  void onClose() {
    isTextFieldVisible.value = false;
    super.onClose();
  }

  void toggleTextFieldVisibility() {
    isTextFieldVisible.value = !isTextFieldVisible.value;
  }
}