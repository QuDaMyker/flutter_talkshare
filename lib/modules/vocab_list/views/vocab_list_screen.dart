import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/vocab_list/controllers/vocab_list_screen_controller.dart';
import 'package:flutter_talkshare/modules/vocab_list/widgets/item_vocab_list.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

class VocabListScreen extends StatelessWidget {
  const VocabListScreen({super.key, required this.nameOfCollection});
  final String nameOfCollection;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final VocabListScreenController vocabListScreenController =
        Get.put(VocabListScreenController());
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(deviceHeight, deviceWidth, vocabListScreenController),
      ),
    );
  }

  Padding _buildBody(
    double deviceHeight,
    double deviceWidth,
    VocabListScreenController controller,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        right: deviceWidth * 0.05,
        left: deviceWidth * 0.05,
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          child: Obx(
            () => controller.isLoading.value
                ? _buildLoading()
                // : controller.listVocab.value.isEmpty
                //     ? Lottie.asset('assets/images/lottie/ic_nodata1.json')
                : _buildListviewBuilder(deviceHeight, deviceWidth),
          ),
        ),
      ),
    );
  }

  Widget _buildListviewBuilder(
    double deviceHeight,
    double deviceWidth,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: deviceHeight * 0.6,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 20,
            itemBuilder: (context, index) {
              return ItemVocabList(
                enWordForm: 'Car',
                translatedWordForm: 'Xe',
                typeOfWord: 'Noun',
                onSpeak: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(index.toString())));
                },
              );
            },
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: deviceHeight * 0.1,
            ),
            padding: EdgeInsets.symmetric(
              vertical: deviceHeight * 0.012,
            ),
            decoration: const BoxDecoration(
              color: AppColors.secondary20,
              border: Border(
                top: BorderSide(color: Colors.transparent, width: 0),
                bottom: BorderSide(color: Colors.transparent, width: 0),
                right: BorderSide(color: Colors.transparent, width: 0),
                left: BorderSide(color: Colors.transparent, width: 0),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8,
                ),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.copy_outlined,
                  color: Colors.white,
                ),
                Text(
                  'Học bộ từ này',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Center _buildLoading() {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: AppColors.primary40,
        size: 200,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        nameOfCollection,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
    );
  }
}
