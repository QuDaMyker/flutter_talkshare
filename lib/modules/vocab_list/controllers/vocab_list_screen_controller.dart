import 'package:flutter_talkshare/core/models/definition.dart';
import 'package:flutter_talkshare/modules/vocab_list/services/vocab_list_service.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../../../core/configuration/injection.dart';

class VocabListScreenController extends GetxController {
  final String wordsetId;

  VocabListScreenController({required this.wordsetId});

  var isLoading = Rx<bool>(false);
  var listVocab = Rx<List<Definition>>([]);

  @override
  void onInit() async {
    await getListVocab();

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getListVocab() async {
    isLoading.value = true;
    listVocab.value = await VocabListServices().getVocabList(wordsetId);
    isLoading.value = false;
  }
}
