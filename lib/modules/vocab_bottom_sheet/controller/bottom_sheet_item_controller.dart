import 'dart:convert';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;

class BottomSheetItemController extends GetxController {
  final String word;
  final String second;
  BottomSheetItemController({this.word = '', this.second = ''});
  final player = AudioPlayer();
  var isLoading = Rx<bool>(false);
  var data = Rx<String>('');

  Future<void> getWord(String word) async {
    isLoading.value = true;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET',
        Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'));
    request.body = '''{"query":"","variables":{}}''';

    request.headers.addAll(headers);
    var url = Uri.https('api.dictionaryapi.dev', 'api/v2/entries/en/$word');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      //print(response.body);

      List<dynamic> body = json.decode(response.body);
      Map<String, dynamic> item = body[0];
      data.value = item['meanings'][0]['definitions'][0]['example'];
      print(item['phonetics'][0]['audio']);
      final duration = await player.setUrl(// Load a URL
          item['phonetics'][0]['audio']);
      player.play();
    } else {
      print(response.reasonPhrase);
    }

    isLoading.value = false;
  }
}
