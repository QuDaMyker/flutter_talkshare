import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/configuration/injection.dart';
import '../../../services/supabase_service.dart';

class ItemDetailVocabController extends GetxController {
  final con1 = FlipCardController();
  final cong = GestureFlipCardController();
  var isBookmarkOn = Rx<bool>(false);

  ItemDetailVocabController({required this.word, required this.primaryMeaning});

  final String word;
  final String primaryMeaning;
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
    super.onClose();
  }

  void onPressBookmark() async {
    isBookmarkOn.value = !isBookmarkOn.value;
    await SupabaseService.instance
        .addRemoveBookmark(word, 'f6d32d14-961c-4fba-94ff-7e76f9031a09');
  }

  void onSpeaker() async {
    var player = getIt.get<AudioPlayer>();
    //await player.setUrl(audio);
    player.play();
  }
}
