import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_talkshare/core/models/listening.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/core/values/image_assets.dart';
import 'package:flutter_talkshare/modules/listening/controller/play_bar_controller.dart';
import 'package:flutter_talkshare/modules/listening/view/listening_read_screen.dart';
import 'package:flutter_talkshare/modules/listening/view/listening_write_screen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';


class PlayBar extends StatelessWidget {
  final Listening listening;
  final String type;
  final String list;
  // PlayBarController controller = Get.find(PlayBarController()); 

  PlayBar({Key? key, required this.listening, required this.type, required this.list})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final PlayBarController controller = Get.find<PlayBarController>();

    var list_;
    switch(list){
      case 'Short Stories':{
        list_ = ListeningList.listeningShortList;
        break;
      }
      case 'Daily Conversations':{
        list_ = ListeningList.listeningDailyList;
        break;
      }
      case 'TOEIC Listening':{
        list_ = ListeningList.listeningToeicList;
        break;
      }      
    }
    // if (controller.audioUrl != listening.audioURL) {
    //   controller.audioUrl = listening.audioURL;
    //   if (controller.isPlaying!= true) {
    //   controller.initializeAudio();
    //   }
    // }
    controller.initializeAudio();
    controller.currentIndex.value = list_.indexWhere((item) => item.audioURL == listening.audioURL); 
    //controller.isPlaying = true.obs;
    
    return Container(
      width: deviceWidth,
      height: deviceHeight * 0.195,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.bgHome),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 15),
          Flexible(
            flex: 1,
            child: Column(
              children: [                
                Obx(() => Slider(
                  value: controller.currentPosition.value.inSeconds.toDouble(),
                  min: 0.0,
                  max: controller.totalDuration.value.inSeconds.toDouble(),
                  onChanged: (newValue){
                    controller.seekTo(newValue);
                  },
                  activeColor: AppColors.gray80,
                  inactiveColor: Colors.white.withOpacity(0.5),
                ),),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: deviceWidth * 0.07,
                    vertical: deviceHeight * 0.00005,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(
                        formatDuration(controller.currentPosition.value),                        
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gray80,
                        ),
                      ),),
                      Obx(() => Text(
                        formatDuration(controller.totalDuration.value),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.gray80,
                        ),
                      ),),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() =>
                 IconButton(
                  icon: SvgPicture.asset(
                    _getVolumeIcon(controller.volumeState.value),
                  ),
                  onPressed: () {
                    _toggleVolume(controller);
                  },
                ),
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: SvgPicture.asset(ImageAssets.icPrevious_),
                  onPressed: () => controller.currentIndex.value > 0
                    ? (type == 'write'
                        ? (() {
                            Navigator.pop(context);
          //Get.delete<PlayBarController>();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ListeningWriteScreen(listening: list_[controller.currentIndex.value - 1]),
                              ),
                            );
                          })()
                        : (() {
                            Navigator.pop(context);
          //Get.delete<PlayBarController>();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ListeningReadScreen(listening: list_[controller.currentIndex.value - 1]),
                              ),
                            );
                          })())
                    : {},
                ),
                SizedBox(width: 20),
                Obx(() => 
                  IconButton(
                        icon: SvgPicture.asset(
                          controller.isPlaying.value ? ImageAssets.icPause : ImageAssets.icPlay_,
                        ),
                        onPressed: () {
                          controller.playPause();
                        },
                      ),
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: SvgPicture.asset(ImageAssets.icNext_),
                  onPressed: () => controller.currentIndex.value < ListeningList.listeningShortList.length - 1
                    ? (type == 'write'
                        ? (() {
                            Navigator.pop(context);
          //Get.delete<PlayBarController>();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ListeningWriteScreen(listening: list_[controller.currentIndex.value + 1]),
                              ),
                            );
                          })()
                        : (() {
                            Navigator.pop(context);
          //Get.delete<PlayBarController>();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ListeningReadScreen(listening: list_[controller.currentIndex.value + 1]),
                              ),
                            );
                          })())
                    : {},
                ),
                SizedBox(width: 20),
                Obx(() =>IconButton(
                  icon: SvgPicture.asset(
                    _getSpeedIcon(controller.speedState.value),
                  ),
                  onPressed: () {
                    _toggleSpeed(controller);
                  },
                ),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
  
  String _getVolumeIcon(VolumeState state) {
    switch (state) {
      case VolumeState.muted:
        return ImageAssets.icMuted;
      case VolumeState.min:
        return ImageAssets.icVolume;
      case VolumeState.max:
        return ImageAssets.icMaxVolume;
      default:
        return ImageAssets.icMaxVolume; 
    }
  }

  void _toggleVolume(PlayBarController controller) {
    switch (controller.volumeState.value) {
      case VolumeState.muted:
        controller.setVolume(VolumeState.max);
        break;
      case VolumeState.min:
        controller.setVolume(VolumeState.muted);
        break;
      case VolumeState.max:
        controller.setVolume(VolumeState.min);
        break;
    }
  }

  String _getSpeedIcon(SpeedState state) {
    switch (state) {
      case SpeedState.x0_5:
        return ImageAssets.icSpeed05;
      case SpeedState.x1_0:
        return ImageAssets.icSpeed10;
      case SpeedState.x2_0:
        return ImageAssets.icSpeed20;
      default:
        return ImageAssets.icSpeed10; 
    }
  }

  void _toggleSpeed(PlayBarController controller) {
    switch (controller.speedState.value) {
      case SpeedState.x0_5:
        controller.setSpeed(SpeedState.x1_0);
        break;
      case SpeedState.x1_0:
        controller.setSpeed(SpeedState.x2_0);
        break;
      case SpeedState.x2_0:
        controller.setSpeed(SpeedState.x0_5);
        break;
    }
  }
}
