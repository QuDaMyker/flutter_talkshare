import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/idioms/controller/idioms_screen_controller.dart';
import 'package:flutter_talkshare/modules/idioms/widgets/item_idioms.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class IdiomsScreen extends StatelessWidget {
  const IdiomsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final IdiomsScreenController idiomsScreenController =
        Get.put(IdiomsScreenController());

     return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(deviceHeight, deviceWidth, idiomsScreenController),
      ),
    );
  }

  Padding _buildBody (
    double deviceHeight,
    double deviceWidth,
    IdiomsScreenController controller,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.05,
        vertical: deviceHeight *0.02,
      ),
      child: Column(
        children: [
          TextField (
            textInputAction: TextInputAction.search,
            style:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            // controller: controller.searchTextController,
            // onChanged: controller.onChangeSearchText,
            decoration: InputDecoration(
              isDense: true,
              isCollapsed: true,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.gray40),              
              ),            
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SvgPicture.asset(ImageAssets.icSearch),
              ),
              hintText: "Tìm kiếm",
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.gray20,
                  fontSize: 16.0),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),            
              prefixIconConstraints: const BoxConstraints(),
              suffixIcon: GestureDetector(
                onTap: () {
                  // controller.clearSearchText();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(ImageAssets.icClose),
                ),
              ),
              suffixIconConstraints: const BoxConstraints(),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: SingleChildScrollView(  
              child: SizedBox(
                child: Obx(
                  () => controller.isLoading.value
                  ? _buildLoading()
                  : _buildListviewBuilder(deviceHeight, deviceWidth),
                )
              ),
            )
          )
      ],)
    );
  }

  Widget _buildListviewBuilder(
    double deviceHeight,
    double deviceWidth,
  ) {
    return Column (
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: deviceHeight * 0.773,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 10,
            itemBuilder: (context, index) {
              return ItemIdioms(
                idioms: 'Rain cat and dog',
                translatedIdioms: 'Mưa rất to',
              );
            },
          ),
        ),                  
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
      title: const Text(
        'Thành ngữ Tiếng Anh',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 30,
        ),
      ),
      bottom: PreferredSize(
            preferredSize: Size.fromHeight(5.0), 
            child: Container(
              color: AppColors.gray60, 
              height: 1.3, 
            ),
          ),
    );
  }
}