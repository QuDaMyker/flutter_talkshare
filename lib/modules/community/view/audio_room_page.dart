import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

class AudioRoomPage extends StatelessWidget {
  final String roomID;
  final bool isHost;
  final String name;
  final String topic;
  final String userId;
  final String userName;

  const AudioRoomPage(
      {Key? key,
      required this.roomID,
      required this.name,
      required this.topic,
      required this.userId,
      required this.userName,
      this.isHost = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltLiveAudioRoom(
      appID: int.parse(dotenv.get("AppID")),
      appSign: dotenv.get("AppSign"),
      userID: userId,
      userName: userName,
      roomID: roomID,
      config: isHost
          ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
          : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience(),
      events: ZegoUIKitPrebuiltLiveAudioRoomEvents(
        onEnded: (event, defaultAction) {
          if (isHost) {
            SupabaseService.instance.endRoom(roomID);
          }
          defaultAction();
        },
      ),
      name: name,
      topic: topic,
    );
  }
}
