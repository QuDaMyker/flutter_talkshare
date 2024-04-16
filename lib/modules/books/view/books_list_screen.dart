import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/models/book.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/books/widgets/scrollable_books_widget.dart';

class BooksListScreen extends StatelessWidget {
  const BooksListScreen({super.key});

  get controller => null;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: _buildBody(deviceHeight, deviceWidth, controller),
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

  Padding _buildBody(double deviceHeight, double deviceWidth, controller) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        TextField(
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
                controller.clear();
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
        SizedBox(
          height: deviceHeight * 0.75,

          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
                child: ScrollableBooksWidget(
                    deviceHeight * 0.26, deviceWidth - 40, listBooks),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
                child: ScrollableBooksWidget(
                    deviceHeight * 0.26, deviceWidth - 40, listBooks),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
                child: ScrollableBooksWidget(
                    deviceHeight * 0.26, deviceWidth - 40, listBooks),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
                child: ScrollableBooksWidget(
                    deviceHeight * 0.26, deviceWidth - 40, listBooks),
              )
            ],
          ),
        )
      ]),
    );
  }
}
