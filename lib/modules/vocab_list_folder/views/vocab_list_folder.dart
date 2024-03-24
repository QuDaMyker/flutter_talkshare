import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/vocab/widgets/item_collection_vocal.dart';
import 'package:flutter_talkshare/modules/vocab_list_folder/controller/vocab_list_folder_controller.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

class VocabListFolder extends StatelessWidget {
  const VocabListFolder({super.key, required this.nameOfFolder});
  final String nameOfFolder;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final VocabListFolderController vocabListFolderController =
        Get.put(VocabListFolderController());
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(deviceHeight, deviceWidth, vocabListFolderController),
      ),
    );
  }

  Padding _buildBody(
    double deviceHeight,
    double deviceWidth,
    VocabListFolderController controller,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.05,
      ),
      child: SizedBox(
        child: Obx(
          () => controller.isLoading.value
              ? _buildLoading()
              : controller.listWordSet.value.isEmpty
                  ? Center(
                      child: SizedBox(
                        width: deviceWidth * 0.5,
                        height: deviceWidth * 0.5,
                        child: Lottie.asset(
                            'assets/images/lottie/ic_nodata3.json'),
                      ),
                    )
                  : _buildGridviewBuilder(),
        ),
        // child: _buildGridviewBuilder(),
      ),
    );
  }

  GridView _buildGridviewBuilder() {
    return GridView.builder(
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
        return ItemCollectionVocab(
          image: 'image',
          title: 'Tạo bộ từ mới',
          isCreateButton: false,
          onPressed: () {},
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        nameOfFolder,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: AppColors.primary40,
        size: 200,
      ),
    );
  }
}
