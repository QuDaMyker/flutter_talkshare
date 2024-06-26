import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class LivePage extends StatelessWidget {
  final String liveID;
  final String userId;
  final String userName;
  final bool isHost;

  const LivePage(
      {Key? key,
      required this.liveID,
      required this.userId,
      required this.userName,
      this.isHost = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: int.parse(dotenv.get("AppID")),
        appSign: dotenv.get("AppSign"),
        userID: userId,
        userName: userName,
        liveID: liveID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host(
                plugins: [ZegoUIKitSignalingPlugin()],
              )
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(
                plugins: [ZegoUIKitSignalingPlugin()],
              ),
        events: ZegoUIKitPrebuiltLiveStreamingEvents(
          onEnded: (event, defaultAction) {
            if (isHost) {
              SupabaseService.instance.endStream(liveID);
            }
            defaultAction();
          },
        ),
      ),
    );
  }
}
