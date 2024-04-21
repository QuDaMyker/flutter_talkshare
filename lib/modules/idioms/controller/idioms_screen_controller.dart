import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/models/idiom.dart';
import 'package:get/get.dart';
class IdiomsScreenController extends GetxController{
  TextEditingController searchTextController = TextEditingController();
  var searched_list = <Idiom>[].obs;
  var first_list = IdiomsList.idiomList;
  var searchText = ''.obs;
  var showSuffixIcon = false.obs;
  
  
  @override
  void onInit() async {
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
          verb.idiom.toLowerCase().contains(text.toLowerCase())).toList();          
      showSuffixIcon.value = true;
    }    
  }

    void clearSearchText() {
      searchTextController.clear();
      onChangeSearchText ('');
  }
}