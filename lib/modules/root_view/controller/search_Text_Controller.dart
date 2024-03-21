import 'package:flutter/material.dart';
import 'package:flutter_talkshare/modules/vocab_bottom_sheet/controller/bottom_sheet_vocab_controller.dart';
import 'package:flutter_talkshare/modules/vocab_bottom_sheet/widgets/bottom_sheet.dart';
import 'package:get/get.dart';

class SearchTextController extends TextEditingController {
    String searchText;
    late final BottomSheetVocabController controllerBottom;
  SearchTextController({this.searchText = ''} );


  void clearSearchText(){
      super.clear();
  }

   void showBottomSheet(BuildContext context, String vocab) {
    if(vocab.isNotEmpty)
    {

      showModalBottomSheet(context: context,
      builder: (context)=>  BottomSheetVocab(word: vocab),).whenComplete(() {
        debugPrint('whenComplete');
        Get.delete<BottomSheetVocabController>();
      });

      print('hiện xong bottom sheet cho từ này:  '+ vocab);

    }
    
    // showModalBottomSheet(
    //   context: context,
    //   builder: (context) => const BottomSheetVocab(word: 'trace'),
    //   // builder: (context) => const BottomSheetItem(word: searchText),
    // );
  }


}