import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_talkshare/core/models/book.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/books/controller/scrollable_books_widget.dart';
import 'package:flutter_talkshare/modules/books/widgets/book_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class ScrollableBooksWidget extends StatelessWidget {
  final double height;
  final double width;
  final RxList<Book> books;

  const ScrollableBooksWidget(this.height, this.width, this.books, {super.key});

  @override
  Widget build(BuildContext context) {
  ScrollableBooksWidgetController  controller = Get.put(ScrollableBooksWidgetController(books: books));
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                books[0].type,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                onTap: () {
                  debugPrint('nhấn vào xem tất cả');
                  controller.viewAllBooksInType();
                },
                child: const Text(
                "Xem tất cả",
                style: TextStyle(
                  color: AppColors.primary40,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              )
            ],
          ),
           const SizedBox(height: 8,),
           SizedBox (
            height: height,
            child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: books.map((book) {
                  return Padding(
                    padding: const EdgeInsets.only(right:15,),
                    child: BookWidget(height*0.7, width*0.3, book),
                  );
                }).toList(),
              ),
           ),
        ],
      ),
    );
  }
}
