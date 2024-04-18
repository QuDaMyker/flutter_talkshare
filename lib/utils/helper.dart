import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator_plus/translator_plus.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }
  //Get.snackbar('Notify', 'No image selected');
  print('No image selected');
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<String> tranlateToVN(String word) async {
  final translator = GoogleTranslator();
  var translation = await translator.translate(word, from: 'en', to: 'vi');
  return translation.text;
}

OutlineInputBorder customBorder() {
  return OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppColors.gray40,
      width: 1.0,
    ),
    borderRadius: BorderRadius.circular(14.0),
  );
}

OutlineInputBorder customBorderWhenFocus() {
  return OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppColors.primary40,
      width: 2.0,
    ),
    borderRadius: BorderRadius.circular(14.0),
  );
}
