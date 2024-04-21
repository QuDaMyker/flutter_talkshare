import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';
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

String formatDateTimeToDdMmYyyy(DateTime date) {
  final formatter = DateFormat('dd-MM-yyyy');
  return formatter.format(date);
}

String formatDateTimeToHHMMDdMmYyyy(DateTime date) {
  final formatter = DateFormat('hh:mm, dd-MM-yyyy');
  return formatter.format(date);
}

String formatDateTimeToHHMM(DateTime date) {
  final formatter = DateFormat('hh:mm a');
  return formatter.format(date);
}

String formatDateTimeToHms(DateTime date) {
  return DateFormat.Hms().format(date).toString();
}

DateTime combineTwoDateTime(DateTime date, TimeOfDay time) {
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

int dateTimeToTimeStamp(DateTime dateTime) {
  return dateTime.millisecondsSinceEpoch;
}

int timeOfDayToTimeStamp(TimeOfDay dateTime) {
  return dateTimeToTimeStamp(DateTime(dateTime.hour, dateTime.minute));
}

DateTime timeStampToDateTime(int timeStamp) {
  return DateTime.fromMillisecondsSinceEpoch(timeStamp);
}

String intToTimeLeft(int value) {
  int h, m, s;
  h = value ~/ 3600;
  m = ((value - h * 3600)) ~/ 60;
  s = value - (h * 3600) - (m * 60);
  String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();
  String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();
  String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();
  String result = "$hourLeft:$minuteLeft:$secondsLeft";
  return result;
}

String capitalizeFirstLetter(String word) {
  if (word.isEmpty) return word;
  return word[0].toUpperCase() + word.substring(1);
}

String capitalizeFirstLetterOfEachWord(String input) {
  List<String> words = input.split(' ');
  List<String> capitalizedWords =
      words.map((word) => capitalizeFirstLetter(word)).toList();
  return capitalizedWords.join(' ');
}

int generateRandomInt(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min + 1);
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
