import 'package:flutter_talkshare/core/models/wordset.dart';
import 'package:get/get.dart';

class VocabListFolderController extends GetxController {
  var isLoading = Rx<bool>(false);
  var listWordSet = Rx<List<WordSet>>([]);
}
