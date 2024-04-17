import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_talkshare/core/models/book.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/books/widgets/book_widget.dart';

class ScrollableBooksWidget extends StatelessWidget {
  final double height;
  final double width;
  final List<Book> books;

  ScrollableBooksWidget(this.height, this.width, this.books);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            const Text(
              "Xem tất cả",
              style: TextStyle(
                color: AppColors.primary40,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10,),
        SizedBox(
          width: width,
          height: height,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: books.map((book) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: BookWidget(height*0.65, width*0.3, book),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
