import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/models/listening.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/listening/controller/listening_screen_controller.dart';
import 'package:flutter_talkshare/modules/listening/widgets/item_listening.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ListeningScreen extends StatelessWidget {
  const ListeningScreen({Key? key}) : super(key: key);  

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final ListeningScreenController listeningScreenController = Get.put(ListeningScreenController());

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: _buildBody(deviceHeight, deviceWidth,listeningScreenController,)
      ),
    );
  }

 Container _buildBody (
    double deviceHeight,
    double deviceWidth,
    ListeningScreenController controller,
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
          Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Short Stories',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.secondary20,
                fontSize: 16.0,
              ),
            ),
          ),
        
          const SizedBox(
            height: 10,
          ),

          Flexible(
            flex: 2,
            child: Obx(() =>SingleChildScrollView(  
              child: SizedBox(
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.18,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.first_list.length,
                        itemBuilder: (context, index) {
                          Listening item = controller.first_list[index];
                          return ItemListening(
                            listening: item,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),),
          ),

          const SizedBox(
            height: 10,
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Daily Conversations',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.secondary20,
                fontSize: 16.0,
              ),
            ),
          ),
        
          const SizedBox(
            height: 10,
          ),

          Flexible(
            flex: 3,
            child: Obx(() =>SingleChildScrollView(  
              child: SizedBox(
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.27,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.second_list.length,
                        itemBuilder: (context, index) {
                          Listening item = controller.second_list[index];
                          return ItemListening(
                            listening: item,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),),
          ),
          
          const SizedBox(
            height: 10,
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              'TOEIC Listening',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.secondary20,
                fontSize: 16.0,
              ),
            ),
          ),
        
          const SizedBox(
            height: 10,
          ),

          Flexible(
            flex: 3,
            child: Obx(() =>SingleChildScrollView(  
              child: SizedBox(
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.27,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.third_list.length,
                        itemBuilder: (context, index) {
                          Listening item = controller.third_list[index];
                          return ItemListening(
                            listening: item,
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
        'Bài nghe',
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