import 'package:flutter_talkshare/core/models/book.dart';
import 'package:flutter_talkshare/modules/books/view/detail_book_screen.dart';
import 'package:get/get.dart';

class BookWidgetCntroller extends GetxController{
  final Book book;

  BookWidgetCntroller({
    required this.book,
  });

  void moveToDetailBook(){
    
     Get.to(() => DetailBookScreen(book: book));
  }

}