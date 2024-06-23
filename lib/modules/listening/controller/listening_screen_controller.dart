import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/models/listening.dart';
import 'package:get/get.dart';
class ListeningScreenController extends GetxController{
  var first_list = <Listening>[].obs;  
  var second_list = <Listening>[].obs;  
  var third_list = <Listening>[].obs;  
  
  @override
  void onInit() async {
    first_list.assignAll(ListeningList.listeningShortList);
    second_list.assignAll(ListeningList.listeningDailyList);
    third_list.assignAll(ListeningList.listeningToeicList);
    super.onInit();
  }
}