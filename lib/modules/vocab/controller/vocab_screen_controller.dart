import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:flutter_talkshare/core/models/wordset.dart';
import 'package:flutter_talkshare/modules/vocab/services/vocab_services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/configuration/injection.dart';

class VocabScreenController extends GetxController {
  var isLoading = Rx<bool>(false);
  var listVocabSaved = Rx<List<Vocab>>([]);
  var listVocabRecent = Rx<List<Vocab>>([]);
  var listVocabCollection = Rx<List<WordSet>>([]);

  final player = AudioPlayer();

  @override
  void onInit() async {
    await getListVocabSaved();
    await getListVocabRecent();
    await getListVocabCollection();
    isLoading.value = false;

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getListVocabSaved() async {
    isLoading.value = true;

    listVocabSaved.value = await VocabService().getVocabSaved();
  }

  Future<void> getListVocabRecent() async {
    isLoading.value = true;
    listVocabRecent.value = await VocabService().getVocabRecent();
    print(listVocabRecent.value.length);
  }

  Future<void> getListVocabCollection() async {
    isLoading.value = true;
    List<WordSet> rs = await VocabService().getVocabCollection();
    listVocabCollection.value = [
      const WordSet(
          wordsetId: 'wordsetId',
          name: 'name',
          avatarUrl: 'avatarUrl',
          userId: 'userId'),
      ...rs,
    ];

    debugPrint(listVocabCollection.value.length.toString());
  }

  Future<void> playAudio(String urlAudio) async {
    // await player.setUrl(urlAudio);
    // player.play();
    debugPrint(urlAudio);
  }
}
