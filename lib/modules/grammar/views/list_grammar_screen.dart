import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/books/view/detail_book_screen.dart';
import 'package:flutter_talkshare/modules/grammar/views/detail_grammar_screen.dart';

class ListGrammaScreen extends StatelessWidget {
  ListGrammaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final List<String> grammars = [
      "Nouns",
      "Pronouns",
      "Adjective",
      "Verbs",
      "Adverbs",
      "Prepositions",
      "Conjunctions",
      "Interjections",
      "Articles",
      "Determiners",
      "Present Simple",
      "Present Continuous",
      "Present Perfect",
      "Present Perfect Continuous",
      "Past Simple",
      "Past Continuous",
      "Past Perfect",
      "Past Perfect Continuous",
      "Future Simple",
      "Future Continuous",
      "Future Perfect",
      "Future Perfect Continuous",
      "Modals",
      "Zero Conditional",
      "First Conditional",
      "Second Conditional",
      "Third Conditional",
      "Mixed Conditional",
      "Passice Voice",
      "Reported Speech",
      "Yes/No Questions",
      "Wh- Questions",
      "Tag Questions",
      "Defining and Non-defining relative clauses",
      "Relative pronouns",
    ];
    final List<String> meanings = [
      "Danh từ",
      "Đại từ",
      "Tính từ",
      "Động từ",
      "Trạng từ",
      "Giới từ",
      "Liên từ",
      "Thán từ",
      "Mạo từ",
      "Từ hạn định",
      "Hiện tại đơn",
      "Hiện tại tiếp diễn",
      "Hiện tại hoàn thành",
      "Hiện tại hoàn thành tiếp diễn",
      "Quá khứ đơn",
      "Quá khứ tiếp diễn",
      "Quá khứ hoàn thành",
      "Quá khứ hoàn thành tiếp diễn",
      "Tương lai đơn",
      "Tương lai tiếp diễn",
      "Tương lai hoàn thành",
      "Tương lai hoàn thành tiếp diễn",
      "Động từ khiếm khuyết",
      "Điều kiện loại 0",
      "Điểu kiện loại 1",
      "Điểu kiện loại 2",
      "Điểu kiện loại 3",
      "Điều kiện hỗn hợp",
      "Câu bị động",
      "Câu gián tiếp",
      "Câu hỏi Yes/No",
      "Câu hỏi Wh-",
      "Câu hỏi đuôi",
      "Mệnh đề quan hệ xác định và không xác định",
      "Đại từ quan hệ",
    ];

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: _buildBody(deviceHeight, deviceWidth, grammars, meanings),
      ),
    );
  }
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
      'Ngữ pháp',
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

Padding _buildBody(double deviceHeight, double deviceWidth,
    List<String> grammars, List<String> meanings) {
  return Padding(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
          itemCount: grammars.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailGrammarScreen(
                            grammar: grammars[index], meaning: meanings[index]),
                      ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.gray60,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: deviceWidth * 0.7,
                            child: Text(
                            grammars[index],
                            style: TextStyle(
                              color: AppColors.primary20,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: deviceWidth*0.7,
                            child: Text(
                              meanings[index],
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                color: AppColors.primary40,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                      SvgPicture.asset(
                        ImageAssets.icRight,
                        colorFilter: ColorFilter.mode(
                            AppColors.primary40, BlendMode.srcIn),
                        height: 25,
                        width: 25,
                      )
                    ],
                  ),
                ),
              ),
            );
          }));
}
