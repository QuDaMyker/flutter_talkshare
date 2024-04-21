import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/models/irregular_verb.dart';
import 'package:get/get.dart';

class IrregularVerbScreenController extends GetxController{  
  TextEditingController searchTextController = TextEditingController();
  var first_list = IrregularVerbList.irregularList;
  var searchText = ''.obs;
  var searched_list = <IrregularVerb>[].obs;
  var showSuffixIcon = false.obs;

  @override
  void onInit() {
    searched_list.assignAll(first_list);
    super.onInit();
  }

  void onChangeSearchText (String text) {
    searchText.value = text;
    if (text.isEmpty) {        
      searched_list.assignAll(first_list);
      showSuffixIcon.value = false;
    }
    else {
      searched_list.value = first_list.where((verb) =>
          verb.infinitive.toLowerCase().contains(text.toLowerCase()) ||
          verb.pastSimple.toLowerCase().contains(text.toLowerCase()) ||
          verb.pastParticiple.toLowerCase().contains(text.toLowerCase())).toList();
          
      showSuffixIcon.value = true;
    }    
  }

  void clearSearchText() {
    searchTextController.clear();
    onChangeSearchText ('');
  }
} 

  

