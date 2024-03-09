import 'package:flutter_talkshare/modules/vocab/services/vocab_services.dart';
import 'package:get/get.dart';

class VocabScreenController extends GetxController {
  var isLoading = Rx<bool>(false);
  var listVocabSaved = Rx<List<Map<String, dynamic>>>([]);
  var listVocabRecent = Rx<List<Map<String, dynamic>>>([]);
  var listVocabCollection = Rx<List<Map<String, dynamic>>>([]);
  @override
  void onInit() async {
    isLoading.value = true;
    await getListVocabSaved();
    await getListVocabRecent();
    await getListVocabCollection();
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
    });

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getListVocabSaved() async {
    listVocabSaved.value = await VocabService().getVocabSavedScrollable();
  }

  Future<void> getListVocabRecent() async {
    listVocabRecent.value = await VocabService().getVocabRecentScrollable();
  }

  Future<void> getListVocabCollection() async {
    listVocabCollection.value =
        await VocabService().getVocabCollectionScrollable();
  }
}
