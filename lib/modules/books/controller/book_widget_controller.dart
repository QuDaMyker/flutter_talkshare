import 'package:flutter/cupertino.dart';
import 'package:flutter_talkshare/core/models/book.dart';
import 'package:flutter_talkshare/modules/books/view/detail_book_screen.dart';
import 'package:get/get.dart';

class BookWidgetCotroller extends GetxController{
  Book book;

  BookWidgetCotroller({
    required this.book,
  });

  void moveToDetailBook(){

     debugPrint(book.title);
     Get.to(() => DetailBookScreen(book: book));
  }

}