import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

class AudioRoomPage extends StatelessWidget {
  final String roomID;
  final bool isHost;

  const AudioRoomPage({Key? key, required this.roomID, this.isHost = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveAudioRoom(
        appID: int.parse(dotenv.get("AppID")),
        appSign: dotenv.get("AppSign"),
        userID: '0910',
        userName: 'ethan',
        roomID: roomID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
            : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience(),
      ),
    );
  }
}
