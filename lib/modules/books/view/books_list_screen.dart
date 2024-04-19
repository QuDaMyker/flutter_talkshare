import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/models/book.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/books/controller/book_list_screen_controller.dart';
import 'package:flutter_talkshare/modules/books/widgets/book_widget.dart';
import 'package:flutter_talkshare/modules/books/widgets/scrollable_books_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BooksListScreen extends StatelessWidget {
  BooksListScreen({super.key});

  final BookListScreenController boolListController =
      Get.put(BookListScreenController());

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: _buildBody(deviceHeight, deviceWidth, boolListController),
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
      title: const Text(
        'Đọc sách',
        style: TextStyle(
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

  Padding _buildBody(
      double deviceHeight, double deviceWidth, boolListController) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20, right: 20),
      child: Column(children: [
        TextField(
          controller: boolListController.searchController,
          onChanged: (value) => {
            boolListController.searchBook(value),
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary40,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.green, width: 2.0),
            ),
            hintText: "Tìm kiếm",
            hintStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.gray20,
                fontSize: 16.0),
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SvgPicture.asset(ImageAssets.icSearch),
            ),
            prefixIconConstraints: const BoxConstraints(),
            suffixIcon: GestureDetector(
              onTap: () {
                boolListController.searchController.clear();
                boolListController.isSearching.value = false;

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SvgPicture.asset(ImageAssets.icClose),
              ),
            ),
            suffixIconConstraints: const BoxConstraints(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          child: Obx(() => _buildListBook(deviceHeight *0.75, deviceWidth)) )
      ]),
    );
  }
  SizedBox _buildListBook(double deviceHeight, double deviceWidth) {
    if (boolListController.isSearching.value) {
      return _searchedBooks(deviceHeight, deviceWidth,
          boolListController, boolListController.searchedBooks);
    } else {
      return _allBooksInList(
          deviceHeight, deviceWidth - 25, boolListController);
    }
  }

  SizedBox _allBooksInList(
      double deviceHeight, double deviceWidth, boolListController) {
    return SizedBox(
      height: deviceHeight ,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
            child: ScrollableBooksWidget(deviceHeight * 0.35, deviceWidth - 25,
                boolListController.books),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
            child: ScrollableBooksWidget(deviceHeight * 0.35, deviceWidth - 25,
                boolListController.books),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
            child: ScrollableBooksWidget(deviceHeight * 0.35, deviceWidth - 25,
                boolListController.books),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
              child: ScrollableBooksWidget(deviceHeight * 0.35,
                  deviceWidth - 25, boolListController.books))
        ],
      ),
    );
  }

  SizedBox _searchedBooks(double deviceHeight, double deviceWidth,
      boolListController, List<Book> books) {
    return SizedBox(
      height: deviceHeight ,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: (deviceWidth / 3) / (deviceHeight/2.7),
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            return BookWidget(
                deviceHeight* 0.35 * 0.65, deviceWidth * 0.3, books[index]);
          }),
    );
  }
}
