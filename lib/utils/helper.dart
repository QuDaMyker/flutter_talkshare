import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator_plus/translator_plus.dart';

import '../core/configuration/injection.dart';

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

Future playWithTTS(String word) async {
  var tts = getIt<FlutterTts>();

  await tts.setLanguage("en-US");

  await tts.setSpeechRate(0.55);

  await tts.setVolume(1.0);

  await tts.setPitch(1.0);

  await tts.isLanguageAvailable("en-US");

  await tts.speak(word);
}

String formatDuration(double durationInSeconds) {
  Duration duration = Duration(seconds: durationInSeconds.toInt());
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);
  return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

String formatMilliseconds(int milliseconds) {
  Duration duration = Duration(milliseconds: milliseconds);
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);
  return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}
