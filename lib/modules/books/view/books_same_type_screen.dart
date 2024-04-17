import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/models/book.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/books/widgets/book_widget.dart';

class BooksSameTypeScreen extends StatelessWidget {
  final List<Book> books = listBooks;
  final String type = "Viễn tưởng";

  // BooksSameTypeScreen(this.type, this.books);

  get controller => null;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height*0.85;
    final screenWidth = MediaQuery.of(context).size.width - 20;


    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: _buildBody(screenHeight, screenWidth, controller),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(ImageAssets.icBack),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: Text(
        type,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(3.0),
        child: Container(
          color: AppColors.gray60,
          height: 1.3,
        ),
      ),
    );
  }

  Padding _buildBody(double screenHeight, double screenWidth, controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 10),
      child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: (screenWidth/3)  / (screenHeight *0.75/2.5), 
              crossAxisSpacing: 15,
              mainAxisSpacing: 20,
            ),
            itemCount: books.length,
            itemBuilder: (context, index) {
              return BookWidget(screenHeight * 0.75 * 0.26, screenWidth* 0.3, books[index]);
            }),
      ),
    );
  }
}
