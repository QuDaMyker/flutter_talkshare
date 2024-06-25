import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:get/get.dart';

class ItemSavedVocabController extends GetxController {
  final String word;

  ItemSavedVocabController({required this.word});
  final AuthController authController = Get.find<AuthController>();

  var isBookmarkOn = Rx<bool>(false);
  @override
  void onInit() async {
    isBookmarkOn.value = await SupabaseService.instance.isBookmarkOn(
      word,
      authController.user.user_id,
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
        .addRemoveBookmark(word, authController.user.user_id);
  }
}
