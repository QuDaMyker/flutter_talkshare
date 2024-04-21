import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_talkshare/core/models/book.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class BookListScreenController extends GetxController {
  var books = <Book>[].obs;
  var bookPop = <Book>[].obs;
  var bookAd = <Book>[].obs;
  var bookChild = <Book>[].obs;
  var isInputNotEmpty = false.obs;

  RxBool isSearching = false.obs;
  var searchedBooks = <Book>[].obs;

  late TextEditingController searchController;
  
  @override
  void onInit() {
    super.onInit();
    books.addAll(listBooks);
  
    bookPop.addAll(listPopular);
    bookAd.addAll(listAdventure);
    bookChild.addAll(listChild);
  
    searchController = TextEditingController();
  }
  
  void updateIsInputNotEmpty(String value){
    isInputNotEmpty.value = value.isNotEmpty;
  }

  void searchBook(String value) {
    String search = value.trim();
    if (search.isNotEmpty) {
      isSearching.value = true;
      List<Book> result = books
          .where(
              (book) => book.title.toLowerCase().contains(search.toLowerCase()))
          .toList();
      searchedBooks.assignAll(result);
    }
    else {
      isSearching.value = false;

    }
  }
}
