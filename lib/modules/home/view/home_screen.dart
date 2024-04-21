import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_talkshare/modules/video/views/video_dashboard_screen.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/books/view/books_list_screen.dart';
import 'package:flutter_talkshare/modules/idioms/view/idioms_screen.dart';
import 'package:flutter_talkshare/modules/irregular_verbs/view/irregular_verbs_screen.dart';
import 'package:flutter_talkshare/modules/irregular_verbs/view/irregular_verbs_screen.dart';
import 'package:flutter_talkshare/modules/create_new_list_vocab/view/creare_new%20_list_vocab_screen.dart';
import 'package:flutter_talkshare/modules/home/controller/home_controller.dart';
import 'package:flutter_talkshare/modules/home/widgets/item_recent_word.dart';
import 'package:flutter_talkshare/modules/vocab/views/vocab_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final double _appBarheight = math.min(
    AppBar().preferredSize.height,
    Get.statusBarHeight,
  );

  final List<Vocab> listVocab = [
    const Vocab(word: 'word', primaryMeaning: 'primaryMeaning'),
    const Vocab(word: 'word', primaryMeaning: 'primaryMeaning')
  ];

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    late TextEditingController suggessController;
    return Stack(children: [
      Container(
        padding: EdgeInsets.fromLTRB(20, _appBarheight * 1.2, 20, 20),
        width: double.infinity,
        height: 300,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageAssets.bgHome), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Xin chào,',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 16.0),
            ),
            const SizedBox(height: 4),
            const Text(
              'Lê Bảo Như',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 22.0),
            ),
            const SizedBox(
              height: 20,
            ),
            TypeAheadField<String>(
              suggestionsCallback: (search) async {
                if (search != '') {
                  List<String> result = homeController.searchSuggest(search);
                  return result;
                }
              },
              emptyBuilder: (context) =>
                  const Text('Không tìm thấy từ bạn cần!'),
              builder: (context, controller, focusNode) {
                homeController.textSearchController = controller;
                return Obx((){
                  return TextField(
                  controller: homeController.textSearchController,
                  focusNode: focusNode,
                  onSubmitted: (value) {
                    debugPrint('gọi ở thanh search $value');
                    homeController.handleSearchSubmit(context, value);
                    controller.clear();
                  },
                  onChanged: (value) {
                    homeController.updateInputNotEmpty(value);
                    debugPrint(homeController.isInputNotEmpty.toString());
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Tra từ điển",
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
                    suffixIcon: homeController.isInputNotEmpty.value ? GestureDetector(
                      onTap: () {
                        homeController.textSearchController.clear();
                        homeController.isInputNotEmpty.value = false;
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SvgPicture.asset(ImageAssets.icClose),
                      ),
                    ) : null,
                    suffixIconConstraints: const BoxConstraints(),
                  ),
                );  

                });
              },
              itemBuilder: (context, value) {
                return ListTile(
                  title: Text(value),
                  subtitle: FutureBuilder<String>(
                    future: homeController.translate(
                        value), // Gọi phương thức translate và trả về Future<String>
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('');
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(snapshot.data ?? '');
                      }
                    },
                  ),
                );
              },
              onSelected: (value) {
                debugPrint('gọi từ tab đề xuất $value');
                homeController.handleSearchSubmit(context, value);

                //uggessController.clear();
                // homeController.showBottomSheet(context, value);
                // homeController.textSearchController.clear();

                //homeController.textSearchController.clear();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 36.0,
                  maxHeight: 36.0,
                ),
                child: Obx(
                  () => homeController.recentSharedVocab.isEmpty
                      ? Container()
                      : ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: homeController.recentSharedVocab.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                child: ItemRecentWord(
                                  vocab:
                                      homeController.recentSharedVocab[index],
                                ),
                                onTap: () {
                                  debugPrint('gọi từ recent');
                                  homeController.showBottomSheet(context,
                                      homeController.recentSharedVocab[index]);
                                });
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 8,
                            );
                          },
                        ),
                )),
          ],
        ),
      ),
      Positioned.fill(
          top: 280,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Từ vựng",
                    style: TextStyle(
                        color: AppColors.primary20,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.secondary90,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        SvgPicture.asset(ImageAssets.bannerVocab),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "Hãy bắt đầu học để ghi nhớ từ trong kho từ vựng của bạn ngay bây giờ!",
                              style: TextStyle(
                                  color: AppColors.primary20,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10),
                              textAlign: TextAlign.end,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => VocabScreen());
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                decoration: BoxDecoration(
                                    color: AppColors.secondary20,
                                    borderRadius: BorderRadius.circular(12)),
                                child: const Text(
                                  "Đến Kho từ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Nguồn học",
                    style: TextStyle(
                        color: AppColors.primary20,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: sourceItem(
                              "Bài nghe", ImageAssets.icHeadphone, () {})),
                      Expanded(
                          child: sourceItem("Đọc sách", ImageAssets.icBook, () {
                        
                        Get.to(() => BooksListScreen());
                      })),
                      Expanded(
                          child: sourceItem("Video", ImageAssets.icVideo, () {
                        Get.to(
                          () => const VideoDashBoardScreen(),
                        );
                      })),
                      Expanded(
                          child: sourceItem(
                              "Ngữ pháp", ImageAssets.icGrammar, () {}))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Ghi nhớ",
                    style: TextStyle(
                        color: AppColors.primary20,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IdiomsScreen()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: AppColors.secondary80,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                SvgPicture.asset(ImageAssets.icIdiom),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text(
                                  "Idioms",
                                  style: TextStyle(
                                      color: AppColors.primary20,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text(
                                  "Thành ngữ Tiếng Anh",
                                  style: TextStyle(
                                      color: AppColors.primary20, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IrregulerVerbs()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: const Color(0xFFEBFFDE),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                SvgPicture.asset(ImageAssets.icIrrVerb),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text(
                                  "Irregular Verbs",
                                  style: TextStyle(
                                      color: AppColors.primary20,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const Text(
                                  "Động từ bất quy tắc",
                                  style: TextStyle(
                                      color: AppColors.primary20, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ))
    ]);
  }

  Widget sourceItem(String title, String icon, Function onPress) {
    return InkWell(
      onTap: () => onPress(),
      child: Column(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: const TextStyle(
                color: AppColors.primary20,
                fontWeight: FontWeight.w600,
                fontSize: 14),
          ),
        ],
      ),
    );
  }
}
