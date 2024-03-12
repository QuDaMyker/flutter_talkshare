import 'package:flutter_talkshare/modules/vocab_list/services/vocab_list_service.dart';
import 'package:get/get.dart';

class VocabListScreenController extends GetxController {
  var isLoading = Rx<bool>(false);
  var listVocab = Rx<List<Map<String, dynamic>>>([]);

  @override
  void onInit() async {
    isLoading.value = true;
    await getListVocab();

    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getListVocab() async {
    listVocab.value = await VocabListServices().getVocabList();
  }
}
