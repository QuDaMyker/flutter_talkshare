import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/models/book.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/books/controller/book_widget_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BookWidget extends StatelessWidget {
  final Book book;
  final double heightOfBook;
  final double widthOfBook;
  late BookWidgetCntroller controller;

  BookWidget(this.heightOfBook, this.widthOfBook, this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    controller  = Get.put(BookWidgetCntroller(book: book));

    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: SizedBox(
        width: widthOfBook,
        child: GestureDetector (
          onTap: () {
            debugPrint(book.title);
            controller.moveToDetailBook();
          },
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: heightOfBook,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(book.imageUrl),
                  fit: BoxFit.cover,
                )),
          ),
          
          Text(
            book.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.gray20,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
                )
      ),
        )
    );
  }
}
