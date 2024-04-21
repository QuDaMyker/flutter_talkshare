import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewListVocabController extends GetxController {
  RxList<TextEditingController> wordTCs = <TextEditingController>[].obs;

  @override
  void onInit() {
    super.onInit();
    wordTCs.add(TextEditingController(text: ""));
  }
}
