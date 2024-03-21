import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_talkshare/core/models/definition.dart';
import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:flutter_talkshare/modules/vocab_bottom_sheet/widgets/bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;

class BottomSheetVocabController extends GetxController {
  final String word;

  BottomSheetVocabController({required this.word});
  final player = AudioPlayer();
  var isLoading = Rx<bool>(false);
  late Vocab searchedVocab;
  Map<String, List<Definition>> listDefinitions ={};
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
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('onClose');
    Get.delete<BottomSheetVocabController>();
  }

  //call api lấy Vocab từ word
  Future<void> getWord(String word) async {

    String search  = word.toLowerCase();
    print('bắt đầu lấy nghĩa của ' + search);

    isLoading.value = true;

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.dictionaryapi.dev/api/v2/entries/en/$search')); //lấy nghĩa TA
    request.body = '''{"query":"","variables":{}}''';

    request.headers.addAll(headers);
    var url = Uri.https('api.dictionaryapi.dev', 'api/v2/entries/en/$search');
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

      //lấy Vocab
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
        word: search,
        primaryMeaning: primaryMeaning,
        phonetic: phonetic,
        audioUrl: audioUrl,
      );

      //lấy definitions 
      for (int i =0; i<body.length; i++){
          int defId = 0;
          List<dynamic> mapMeanings = body[i]['meanings'];
          debugPrint('Độ dài cảu meanings');
          debugPrint(mapMeanings.length.toString());
          for (int j = 0; j< mapMeanings.length; j++){
              String key = mapMeanings[j]['partOfSpeech'];
              //check key đã có trong map listDefinitions hay chưa => chưa thì thêm key vô map
              if(!listDefinitions.containsKey(key)){
                listDefinitions[key] =[];
              }

              List<dynamic> mapDefinitions = mapMeanings[j]['definitions'];
                for (int z = 0; z< mapDefinitions.length; z++){
                  Map<String, dynamic> itemDefinition = mapDefinitions[z];
                  String definiton = itemDefinition['definition'].toString();
                  debugPrint(definiton);
                
                  String example ='';

                  if(itemDefinition.containsKey('example'))
                  {
                    example = itemDefinition['example'].toString();
                    debugPrint(example);
                  }

                  Definition def = Definition(definitionId: (defId++).toString(), word: word, partOfSpeech: key, meaning: definiton, example: example);

                  listDefinitions[key]!.add(def);
                

                }
          }
      }
      debugPrint('kết thúc đau khổ');




    } else {
      print('có lỗi');
      print(response.reasonPhrase);
    }
    isLoading.value = false;

    listDefinitions.forEach((key, value) {
      print('$key: ');
      value.forEach((element) { print(element.meaning.toString());});
    });
  }
  Future<void> playAudio(String urlAudio) async {
    final duration = await player.setUrl(urlAudio);
      player.play();
      debugPrint('phát âm thanh');
  }

  Future<void>getListMeanings() async {

  }

}
