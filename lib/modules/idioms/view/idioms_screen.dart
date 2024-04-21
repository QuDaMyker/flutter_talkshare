import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_talkshare/core/models/idiom.dart';
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

    final IdiomsScreenController idiomsScreenController = Get.put(IdiomsScreenController());

     return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: _buildBody(deviceHeight, deviceWidth, idiomsScreenController),
      ),
    );
  }

 Container _buildBody (
    double deviceHeight,
    double deviceWidth,
    IdiomsScreenController controller,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.05,
        vertical: deviceHeight *0.02,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, AppColors.gray60],
        ),
      ),
      child: Column(
        children: [
          TextField (
            textInputAction: TextInputAction.search,
            style:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
            controller: controller.searchTextController,
            onChanged: controller.onChangeSearchText,
            decoration: InputDecoration(
              isDense: true,
              isCollapsed: true,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),          
              ),  
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.black),              
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
              suffixIcon: Obx(() => Visibility( 
                visible: controller.showSuffixIcon.value,
                child: GestureDetector(
                  onTap: () {
                    controller.clearSearchText();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SvgPicture.asset(ImageAssets.icClose),
                  ),
                ),
              ),),
              suffixIconConstraints: const BoxConstraints(),
            ),
          ),
          
          const SizedBox(
            height: 20,
          ),

          Expanded(
            child: Obx(() =>SingleChildScrollView(  
              child: SizedBox(
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.75,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.searched_list.length,
                        itemBuilder: (context, index) {
                          Idiom verb = controller.searched_list[index];
                          return ItemIdioms(
                            idioms: verb.idiom,
                            translatedIdioms: verb.meaning,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),),
          ),
        ],                  
      ),
    );  
  }

  AppBar _buildAppBar(
    BuildContext context
  ) {
    return AppBar(
      leading: IconButton(          
        icon: SvgPicture.asset(ImageAssets.icBack),
        onPressed: () {
          Navigator.pop(context); 
        },
      ),

      centerTitle: true,
      title: const Text (
        'Thành ngữ Tiếng Anh',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

      bottom: PreferredSize(
        preferredSize: Size.fromHeight(3.0), 
        child: Container(
          color: AppColors.gray60, 
          height: 1.3, 
        ),
      ),
    );
  }
}