import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/models/book.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';

class DetailBookScreen extends StatelessWidget {
  final Book book;

  const DetailBookScreen({required this.book});

  get controller => null;

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(deviceHeight, deviceWidth, book),
    ));
  }

  AppBar _buildAppBar(BuildContext context) {
    debugPrint(book.author);
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(ImageAssets.icBack),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Stack _buildBody(double deviceHeight, double deviceWidth, Book book) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: deviceHeight * 0.25,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.backgroundGradient,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Container(
              height: deviceHeight * 0.64,
              width: deviceWidth,
              color: AppColors.gray80,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Mô tả',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        book.description,
                        style: const TextStyle(
                          color: AppColors.gray20,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Trích đoạn',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        book.snippet,
                        style: const TextStyle(
                          color: AppColors.gray20,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Positioned(
          top: deviceHeight * 0.03,
          left: 33.0,
          child: Container(
            height: deviceHeight * 0.3,
            width: (deviceWidth - 70),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: deviceHeight * 0.17,
                  width: (deviceWidth - 100) / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.gray20,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        book.author,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.primary40,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: deviceWidth * 0.25,
                        height: deviceHeight * 0.04,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: AppColors.primaryGradient),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Xử lý sự kiện khi nút được nhấn
                          },
                          child: const Text(
                            'Đọc sách',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: deviceHeight * 0.3,
                  width: (deviceWidth - 70) / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(book.imageUrl),
                        fit: BoxFit.cover,
                      )),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
