import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_talkshare/core/models/definition.dart';
import 'package:flutter_talkshare/core/models/translation_model.dart';
import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'package:translator_plus/translator_plus.dart';

class BottomSheetVocabController extends GetxController {
  final String word;
  var searchedVocab;

  TranslationModel? translationModel;

  BottomSheetVocabController({required this.word});
  final translator = GoogleTranslator();
  final player = AudioPlayer();
  var isLoading = Rx<bool>(false);
  var isNotFound = Rx<bool>(false);
  var isSave = false.obs;
  final AuthController authController = Get.find<AuthController>();


  //Map<String, List<Definition>> listDefinitions ={};

  @override
  Future<void> onInit() async {
    super.onInit();
    //await getWord(word);
    await getTranslate();
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('onClose');
    Get.delete<BottomSheetVocabController>();
  }

  void onPressBookmark() async {
    isSave.value = !isSave.value;
    await SupabaseService.instance
        .addRemoveBookmark(word, authController.user.user_id);
  }

  Future<void> getTranslate() async {
    isLoading.value = true;
    translationModel =
        await SupabaseService.instance.getTranslation(word: word);
    isLoading.value = false;
  }

  //call api lấy Vocab từ word
  // Future<void> getWord(String word) async {

  //   String search  = word.toLowerCase();

  //   isLoading.value = true;

  //   var headers = {'Content-Type': 'application/json'};
  //   var request = http.Request(
  //       'GET',
  //       Uri.parse(
  //           'https://api.dictionaryapi.dev/api/v2/entries/en/$search')); //lấy nghĩa TA
  //   request.body = '''{"query":"","variables":{}}''';

  //   request.headers.addAll(headers);
  //   var url = Uri.https('api.dictionaryapi.dev', 'api/v2/entries/en/$search');
  //   var response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     //print(response.body);

  //     List<dynamic> body = json.decode(response.body);
  //     debugPrint(body.length.toString());
  //     Map<String, dynamic> item = body[0];
  //     // data.value = item['meanings'][0]['definitions'][0]['example'];
  //     // List<dynamic> meanings = item['meanings'];

  //     String temp =
  //         item['meanings'][0]['definitions'][0]['definition'];
  //     String primaryMeaning = await tranlateToVN(temp);
  //     //lấy Vocab
  //     String phonetic = '';
  //     String audioUrl = '';

  //     for (int i = 0; i < body.length; i++) {
  //       List<dynamic> item = body[i]['phonetics'];
  //       debugPrint(item.length.toString());
  //       for (int j = 0; j < item.length; j++) {
  //         Map<String, dynamic> itemPhonetic = item[j];
  //         if (itemPhonetic.containsKey('text') &&
  //             itemPhonetic.containsKey('audio') &&
  //             itemPhonetic['audio'] != '' &&
  //             itemPhonetic['text'] != '') {
  //           phonetic = itemPhonetic['text'];
  //           audioUrl = itemPhonetic['audio'];
  //           debugPrint(phonetic);
  //           debugPrint(audioUrl);
  //           break;
  //         }
  //       }
  //       if (phonetic != '') {
  //         break;
  //       }
  //     }

  //     searchedVocab = Vocab(
  //       word: search,
  //       primaryMeaning: primaryMeaning,
  //       phonetic: phonetic,
  //       audioUrl: audioUrl,
  //     );
  //   debugPrint('bắt đầu lưu');

  //   await saveWordToHistory(searchedVocab);

  //     //lấy definitions
  //     for (int i =0; i<body.length; i++){
  //         int defId = 0;
  //         List<dynamic> mapMeanings = body[i]['meanings'];
  //         debugPrint('Độ dài cảu meanings');
  //         debugPrint(mapMeanings.length.toString());
  //         for (int j = 0; j< mapMeanings.length; j++){
  //             String key = mapMeanings[j]['partOfSpeech'];
  //             //check key đã có trong map listDefinitions hay chưa => chưa thì thêm key vô map
  //             if(!listDefinitions.containsKey(key)){
  //               listDefinitions[key] =[];
  //             }
  //             //tạo các definition, có example thì thêm vô partofSpeech tương ứng
  //             List<dynamic> mapDefinitions = mapMeanings[j]['definitions'];
  //               for (int z = 0; z< mapDefinitions.length; z++){
  //                 Map<String, dynamic> itemDefinition = mapDefinitions[z];

  //                 String example ='';

  //                 if(itemDefinition.containsKey('example'))
  //                 {
  //                   example = itemDefinition['example'].toString();
  //                 }

  //                 String definiton = itemDefinition['definition'].toString();

  //                 var translation = await translator.translate(definiton, from: 'en',to: 'vi');
  //                 debugPrint('Dịch $translation');
  //                 definiton = translation.text;
  //                 Definition def = Definition(definitionId: (defId++).toString(), word: word, partOfSpeech: key, meaning: definiton, example: example);
  //                 listDefinitions[key]!.add(def);
  //               }
  //         }
  //     }
  //     debugPrint('kết thúc đau khổ');

  //   } else {
  //     isNotFound.value = true;
  //     print('có lỗi');
  //     print(response.reasonPhrase);
  //   }
  //   isLoading.value = false;
  // }

  Future<String> tranlateToVN(String word) async {
    var translation = await translator.translate(word, from: 'en', to: 'vi');
    return translation.text;
  }

  Future<void> playAudio(String urlAudio) async {
    final duration = await player.setUrl(urlAudio);
    player.play();
    debugPrint('phát âm thanh');
  }

  Future<void> saveWordToHistory(Vocab word) async {
    await SupabaseService.instance.saveVocabToSharedPreferences(word.word);
  }
}
