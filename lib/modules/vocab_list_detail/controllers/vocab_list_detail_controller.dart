import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_talkshare/modules/vocab_list_detail/widgets/item_detail_vocab.dart';
import 'package:get/get.dart';

class VocabListDetailController extends GetxController {
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
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getData() async {
    List<ItemDetailVocav> cards = [
      ItemDetailVocav(word: '1'),
      ItemDetailVocav(word: '2'),
      ItemDetailVocav(word: '3'),
      ItemDetailVocav(word: '4'),
    ];

    listVocab.value = cards;
  }

  bool onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
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
