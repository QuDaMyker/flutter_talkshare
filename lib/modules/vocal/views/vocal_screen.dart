import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/vocal/widgets/item_collection_vocal.dart';
import 'package:flutter_talkshare/modules/vocal/widgets/item_recent_vocal.dart';
import 'package:flutter_talkshare/modules/vocal/widgets/item_saved_vocal.dart';

class VocalScreen extends StatelessWidget {
  const VocalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(deviceHeight, deviceWidth),
      ),
    );
  }

  Padding _buildBody(double deviceHeight, double deviceWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.05,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.01,
              ),
              child: _buildVocalSavedScrollable(deviceHeight, deviceWidth),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.01,
              ),
              child: _buildVocalRecentScrollable(deviceHeight, deviceWidth),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.01,
              ),
              child: _buildVocalCollectionScrollable(deviceHeight, deviceWidth),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildVocalCollectionScrollable(
    double deviceHeight,
    double deviceWidth,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Bộ từ của bạn',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(
                  AppColors.primary40.withOpacity(0.1),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Tạo thư mục mới',
                style: TextStyle(
                  color: AppColors.primary40,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          child: GridView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              //childAspectRatio: 0.66,
              crossAxisSpacing: 2,
              mainAxisSpacing: 5,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return ItemCollectionVocal(
                image: 'image',
                title: 'Tạo bộ từ mới',
                isCreateButton: false,
                onPressed: () {},
              );
            },
          ),
        ),
      ],
    );
  }

  Column _buildVocalRecentScrollable(double deviceHeight, double deviceWidth) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: deviceHeight * 0.01,
            ),
            child: const Text(
              'Các từ gần đây',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ),
        SizedBox(
          height: deviceHeight * 0.2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return ItemRecentVocal(
                phonetic: '/kɑː/',
                enWordForm: 'Car',
                translatedWordForm: 'Xe',
                onSpeak: () {},
                onSaving: () {},
              );
            },
          ),
        ),
      ],
    );
  }

  Column _buildVocalSavedScrollable(double deviceHeight, double deviceWidth) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: deviceHeight * 0.01,
            ),
            child: const Text(
              'Từ vựng đã lưu',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ),
        SizedBox(
          height: deviceHeight * 0.2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return ItemSavedVocal(
                phonetic: '/kɑː/',
                enWordForm: 'Car',
                translatedWordForm: 'Xe',
                onSpeak: () {},
                onSaving: () {},
              );
            },
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Kho từ',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 30,
        ),
      ),
    );
  }
}
