import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:translator_plus/translator_plus.dart';

import '../core/configuration/injection.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }
  debugPrint('No image selected');
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
