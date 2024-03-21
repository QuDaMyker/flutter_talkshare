import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;

class BottomSheetVocabController extends GetxController {
  final String word;

  BottomSheetVocabController({required this.word});
  final player = AudioPlayer();
  var isLoading = Rx<bool>(false);
  late Vocab searchedVocab;
  var listVocab = Rx<List<Vocab>>([]);
  Map<String, List<String>> sumamryMeaning = {};
// {
//   'noun': {
//     'defination 1',
//     'defination 2'
//   },
//   'verb': {
//     'defination 1',
//     'defination 2'
//   }
// }

  @override
  void onInit() async {
    super.onInit();
    await getWord(word);
    // for (int i = 0; i < listVocab.value.length; i++) {
    //   sumamryMeaning.putIfAbsent(
    //       listVocab.value[i].word, () => listVocab.value[i].primaryMeaning);
    // }
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('onClose');
    Get.delete<BottomSheetVocabController>();
  }

  //call api lấy Vocab từ word
  Future<void> getWord(String word) async {
    print('bắt đầu lấy nghĩa của ' + word);

    isLoading.value = true;

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.dictionaryapi.dev/api/v2/entries/en/$word')); //lấy nghĩa TA
    request.body = '''{"query":"","variables":{}}''';

    request.headers.addAll(headers);
    var url = Uri.https('api.dictionaryapi.dev', 'api/v2/entries/en/$word');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      //print(response.body);

      List<dynamic> body = json.decode(response.body);
      debugPrint(body.length.toString());
      Map<String, dynamic> item = body[0];
      // data.value = item['meanings'][0]['definitions'][0]['example'];
      // List<dynamic> meanings = item['meanings'];

      String primaryMeaning =
          item['meanings'][0]['definitions'][0]['definition'];

      ///
      String phonetic = '';
      String audioUrl = '';

      for (int i = 0; i < body.length; i++) {
        List<dynamic> item = body[i]['phonetics'];
        debugPrint(item.length.toString());
        for (int j = 0; j < item.length; j++) {
          Map<String, dynamic> itemPhonetic = item[j];
          if (itemPhonetic.containsKey('text') &&
              itemPhonetic.containsKey('audio') &&
              itemPhonetic['audio'] != '' &&
              itemPhonetic['text'] != '') {
            phonetic = itemPhonetic['text'];
            audioUrl = itemPhonetic['audio'];
            debugPrint(phonetic);
            debugPrint(audioUrl);
            dynamic duration = await player.setUrl(audioUrl);
            break;
          }
        }
        if (phonetic != '') {
          break;
        }
      }
      searchedVocab = Vocab(
        word: word,
        primaryMeaning: primaryMeaning,
        phonetic: phonetic,
        audioUrl: audioUrl,
      );
    } else {
      print('có lỗi');
      print(response.reasonPhrase);
    }
    isLoading.value = false;
  }
  Future<void> playAudio(String urlAudio) async {
    final duration = await player.setUrl(urlAudio);
      player.play();
      debugPrint('phát âm thanh');
  }

}
