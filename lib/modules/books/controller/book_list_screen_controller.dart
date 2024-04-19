import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_talkshare/core/models/book.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class BookListScreenController extends GetxController {
  var books = <Book>[].obs;

  RxBool isSearching = false.obs;
  var searchedBooks = <Book>[].obs;

  late TextEditingController searchController;
  @override
  void onInit() {
    super.onInit();
    books.addAll(listBooks);
    searchController = TextEditingController();
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
