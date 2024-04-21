import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';

class ItemSavedVocabController extends GetxController {
  final String word;

  ItemSavedVocabController({required this.word});
  var isBookmarkOn = Rx<bool>(false);
  @override
  void onInit() async {
    isBookmarkOn.value = await SupabaseService.instance.isBookmarkOn(
      word,
      'f6d32d14-961c-4fba-94ff-7e76f9031a09',
    );
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void onPressBookmark() async {
    isBookmarkOn.value = !isBookmarkOn.value;
    await SupabaseService.instance
        .addRemoveBookmark(word, 'f6d32d14-961c-4fba-94ff-7e76f9031a09');
  }
}
