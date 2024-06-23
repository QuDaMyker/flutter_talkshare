import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/models/listening.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/listening/controller/listening_screen_controller.dart';
import 'package:flutter_talkshare/modules/listening/controller/listening_write_screen_controller.dart';
import 'package:flutter_talkshare/modules/listening/controller/play_bar_controller.dart';
import 'package:flutter_talkshare/modules/listening/widgets/item_listening.dart';
import 'package:flutter_talkshare/modules/listening/widgets/play_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ListeningWriteScreen extends StatelessWidget {
  final Listening listening;
  const ListeningWriteScreen({Key? key, required this.listening}) : super(key: key);  

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final ListeningWriteScreenController listeningWriteScreenController = Get.put(ListeningWriteScreenController());
    listeningWriteScreenController.isTextFieldVisible = false.obs;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: _buildBody(deviceHeight, deviceWidth,listeningWriteScreenController,listening,)
      ),
    );
  }

 Container _buildBody (
    double deviceHeight,
    double deviceWidth,
    ListeningWriteScreenController controller,
    Listening listening,
  ) {
    return Container(      
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, AppColors.gray60],
        ),
      ),
      child: Column(
        children: [          
          Text(
            listening.name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.primary20,
              fontSize:24.0,
            ),
          ),

                 
          Text(
            listening.type,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.primary20,
              fontSize: 16.0,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,    
            children: [
              SvgPicture.asset(ImageAssets.icClockCircle_,height: 15,width: 15,),
              const SizedBox(width: 5,),
              Text(
                formatDuration(listening.time),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondary20,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),           

          const SizedBox(
            height: 5,
          ),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: deviceWidth * 0.07,
              vertical: deviceHeight *0.005,
            ),
            height: deviceHeight * 0.575, 
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: deviceHeight * 0.3, 
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: TextField(                        
                        decoration: InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Nghe và viết lại những gì bạn nghe được vào đây",
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.gray20,
                              fontSize: 14.0),
                          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  GestureDetector(
                    onTap: () => controller.toggleTextFieldVisibility(),
                    child: Obx(() => Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            decoration: const BoxDecoration(
                              color: AppColors.secondary20,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,    
                              children: [
                                Obx(() => SvgPicture.asset(controller.isTextFieldVisible.value ? ImageAssets.icEyeSlash_ : ImageAssets.icEye),),
                                SizedBox(width: 8),
                                Text(
                                  controller.isTextFieldVisible.value ? 'Ẩn transcript' : 'Hiện transcript',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Obx(() {
                    return controller.isTextFieldVisible.value
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.007,
                            vertical: deviceHeight *0.005,
                          ),
                          child: Text(
                              listening.script,
                              style: TextStyle(fontSize: 16),
                            ),
                        )
                      : SizedBox.shrink();
                  }),
                ],
              ),    
            ),
          ),
          
          const SizedBox(
            height: 5,
          ),

          PlayBar(listening: listening, type: 'write',list: listening.type), 
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
          Get.delete<PlayBarController>();
          Get.back();
        },
      ),

      centerTitle: true,
      title: const Text (
        'Nghe chép chính tả',
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

  String formatDuration(Duration duration) {
    int minutes = duration.inMinutes;
    int seconds = duration.inSeconds % 60;
    String result ="";
    if (minutes!=0) result+='$minutes phút ';
    if (seconds!=0) result+='$seconds giây';
    return result;
  }
}