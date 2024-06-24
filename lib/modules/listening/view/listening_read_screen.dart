import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/models/listening.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/listening/controller/listening_screen_controller.dart';
import 'package:flutter_talkshare/modules/listening/controller/play_bar_controller.dart';
import 'package:flutter_talkshare/modules/listening/widgets/item_listening.dart';
import 'package:flutter_talkshare/modules/listening/widgets/play_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ListeningReadScreen extends StatelessWidget {
  final Listening listening;
  ListeningReadScreen({Key? key, required this.listening}) : super(key: key);  
  final PlayBarController playBarController = Get.put(PlayBarController());

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    playBarController.audioUrl = listening.audioURL;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: _buildBody(deviceHeight, deviceWidth,listening,)
      ),
    );
  }

 Container _buildBody (
    double deviceHeight,
    double deviceWidth,
    Listening listening,
  ) {
    return Container(           
      child: Column(
        children: [          
          Text(
            listening.name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.primary20,
              fontSize: 24.0,
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
              child: Text(
                listening.script,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          PlayBar(listening: listening, type: 'read', list: listening.type),       
        ],                  
      ),
    );  
  }

  AppBar _buildAppBar(
    BuildContext context
  ) {
    return AppBar(
      backgroundColor: AppColors.gray80,
      leading: IconButton(          
        icon: SvgPicture.asset(ImageAssets.icBack),
        onPressed: () {
          Get.delete<PlayBarController>();
          Get.back();
        },
      ),

      centerTitle: true,
      title: const Text (
        'Nghe và đọc',
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