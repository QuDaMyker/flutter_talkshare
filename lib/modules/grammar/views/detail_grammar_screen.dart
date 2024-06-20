import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/grammar.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/grammar/controllers/gramar_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

class DetailGrammarScreen extends StatelessWidget {
  final String grammar;
  final String meaning;

  DetailGrammarScreen(
      {super.key, required this.grammar, required this.meaning});

  @override
  Widget build(BuildContext context) {
    final GrammarController controller =
        Get.put(GrammarController(grammar: grammar));

    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context, deviceHeight, deviceWidth, controller),
    ));
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
        grammar,
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

  Padding _buildBody(BuildContext context, double deviceHeight,
      double deviceWidth, GrammarController grammarController) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            height: deviceHeight * 0.1,
            width: deviceWidth - 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(colors: AppColors.primaryGradient)),
            child: Row(
              children: [
                Container(
                    width: 80,
                    child: SvgPicture.asset(
                      ImageAssets.bookGrammar,
                      height: 48,
                      width: 48,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      grammar,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      meaning,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              height: deviceHeight * 0.632,
              width: deviceWidth - 40,
              child: ListView.builder(
                  itemCount: grammarController.lines.length,
                  itemBuilder: (context, index) {
                    final line = grammarController.lines[index];
                    if (line.startsWith('###')) {
                      return Text(
                        line.substring(3).trim(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary40,
                          fontSize: 16,
                        ),
                      );
                    } else if (line.startsWith('*')) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: Text(
                          line.substring(1).trim(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary20,
                            fontSize: 16,
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          line.trim(),
                          style: TextStyle(
                            color: AppColors.gray20,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }
                  })),
          SizedBox(
            height: 15,
          ),
          Container(
            height: deviceHeight * 0.08,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.gray20,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Làm bài tập",
                  style: TextStyle(
                    color: AppColors.gray20,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "(sắp ra mắt)",
                  style: TextStyle(
                    color: AppColors.gray20,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
