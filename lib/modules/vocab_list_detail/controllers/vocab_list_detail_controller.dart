import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_talkshare/core/models/definition.dart';
import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:flutter_talkshare/modules/auth/controller/auth_controller.dart';
import 'package:flutter_talkshare/modules/profile/services/point_learning_services.dart';
import 'package:flutter_talkshare/modules/vocab_list_detail/widgets/custom_dialog.dart';
import 'package:flutter_talkshare/modules/vocab_list_detail/widgets/item_detail_vocab.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../../../core/configuration/injection.dart';

class VocabListDetailController extends GetxController {
  final List<Vocab> listVocabAddToCard;

  VocabListDetailController({required this.listVocabAddToCard});

  late final CardSwiperController controllerCard;
  var isLoading = Rx<bool>(false);
  var currentIndexCard = Rx<int>(0);
  var listVocab = Rx<List<ItemDetailVocav>>([]);
  RxList<ItemDetailVocav> listStuying = <ItemDetailVocav>[].obs;
  RxList<ItemDetailVocav> listStudied = <ItemDetailVocav>[].obs;
  @override
  void onInit() async {
    controllerCard = CardSwiperController();
    await getData();
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getData() async {
    List<ItemDetailVocav> cards = [];
    isLoading.value = true;
    for (var item in listVocabAddToCard) {
      cards.add(ItemDetailVocav(
        word: item.word,
        primaryMeaning: item.primaryMeaning,
      ));
    }

    listVocab.value = cards;
  }

  Future<bool> onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) async {
    // if (direction.name == CardSwiperDirection.right) {
    //   currentIndexCard.value = currentIndex! + 1;
    // } else {
    //   currentIndexCard.value = currentIndex! - 1;
    // }

    if (direction == CardSwiperDirection.right) {
      listStudied.add(listVocab.value[previousIndex]);
      // listVocab.value.removeAt(previousIndex);
    } else if (direction == CardSwiperDirection.left) {
      listStuying.add(listVocab.value[previousIndex]);
    }

    currentIndexCard.value = currentIndex!;
    update();
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );

    // if (currentIndexCard.value + 1 == listVocab.value.length) {
    //   Get.dialog(
    //     PopScope(
    //       canPop: true,
    //       child: CustomDialog(
    //         countStudied: listStudied.length.toString(),
    //         countStudying: listStuying.length.toString(),
    //       ),
    //     ),
    //   );
    // }

    if (currentIndexCard.value + 1 == listVocab.value.length) {
      String user_id = Get.find<AuthController>().user.user_id;
      await PointLearningServices.instance.addPoint(
        pointValue: 10,
        userId: user_id,
      );
      Get.dialog(
        PopScope(
          canPop: true,
          child: CustomDialog(
            countStudied:
                (listVocab.value.length - listStudied.length).toString(),
            countStudying: listStuying.length.toString(),
          ),
        ),
      );
    }
    return true;
  }

  bool onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    currentIndexCard.value = currentIndex;

    //currentIndexCard.value = currentIndex + 1;
    // debugPrint(
    //   'The card $currentIndex was undod from the ${direction.name}',
    // );
    return true;
  }
}
