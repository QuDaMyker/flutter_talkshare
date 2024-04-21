import 'package:flutter/cupertino.dart';
import 'package:flutter_talkshare/core/models/book.dart';
import 'package:flutter_talkshare/modules/books/view/books_same_type_screen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

class ScrollableBooksWidgetController extends GetxController{
  RxList<Book> books = <Book>[].obs;
  
  ScrollableBooksWidgetController({
    required this.books,
  });

   void viewAllBooksInType() {
    String type = books.first.type;

    debugPrint(type);

    Get.to(() => BooksSameTypeScreen(type: type, books: books));
  }
}