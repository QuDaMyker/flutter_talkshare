import 'dart:ffi';

import 'package:autocorrect_and_autocomplete_engine/autocorrect_and_autocomplete_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/word_list.dart';
import 'package:flutter_talkshare/modules/vocab/services/vocab_services.dart';
import 'package:flutter_talkshare/modules/vocab_bottom_sheet/controller/bottom_sheet_vocab_controller.dart';
import 'package:flutter_talkshare/modules/vocab_bottom_sheet/widgets/bottom_sheet.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator_plus/translator_plus.dart';

class HomeController extends GetxController {
  late final TextEditingController textSearchController;
  // controller cuar TextField || TextFormField
  List<String> suggestList = WordList.en;
  late TrieEngine trieEngine;
  late GoogleTranslator translator;
  RxList<String> recentSharedVocab = <String>[].obs;
  @override
  Future<void> onInit() async {
    //recentSharedVocab.value = [];
    translator = GoogleTranslator();
    textSearchController = TextEditingController();
    trieEngine = TrieEngine(src: suggestList);

    //ds đẫ search
    recentSharedVocab.value =
        (await SupabaseService.instance.getSharedHistory())!;
    debugPrint('lây history${recentSharedVocab.length}');

    for (String item in recentSharedVocab) {
      debugPrint(item);
    }

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<String> translate(String value) async {
    var translation = await translator.translate(value, from: 'en', to: 'vi');
    return translation.text;
  }

  List<String> searchSuggest(String value) {
    List<String> result = trieEngine.autoCompleteSuggestions(value);
    return result;
  }

  Future<void> showBottomSheet(BuildContext context, String vocab) async {
    if (vocab.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheetVocab(word: vocab),
      ).whenComplete(() async {
        debugPrint('whenComplete');

       recentSharedVocab.value =
        (await SupabaseService.instance.getSharedHistory())!;
        debugPrint('history: ${recentSharedVocab.length}');

        Get.delete<BottomSheetVocabController>();
      });
    }
  }
}
