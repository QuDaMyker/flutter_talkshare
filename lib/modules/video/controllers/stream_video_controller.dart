import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_talkshare/modules/video/models/caption_response.dart';
import 'package:flutter_talkshare/modules/video/models/item_caption_model.dart';
import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:flutter_talkshare/utils/helper.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StreamVideoController extends GetxController {
  final VideoModel videoModel;
  StreamVideoController({required this.videoModel});

  var isLoading = Rx<bool>(true);
  var isTimeout = Rx<bool>(false);
  var captions = Rx<List<CaptionResponse>>([]);
  var originCaptions = Rx<List<CaptionResponse>>([]);
  var listCaptionsShowing = Rx<List<ItemCaptionModel>>([]);
  var currentCaption = Rx<String>('');
  late YoutubeExplode yt;
  late Video video;
  late YoutubePlayerController ytController;
  late ScrollController scrollController;
  late ItemScrollController itemScrollController;

  @override
  void onInit() async {
    yt = YoutubeExplode();

    await fetchVideoInfo();
    // initScrollController();
    // initYtController();
    // await getCaptions(video.id.toString());
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    yt.close();
    Get.delete<StreamVideoController>();
    super.onClose();
  }

  Future<void> fetchVideoInfo() async {
    List<Map<String, dynamic>> url = [
      {
        "video_id": "0juLRi90kRg",
        "title":
            "A Palestinian and an Israeli, Face to Face | Aziz Abu Sarah and Maoz Inon | TED",
        "author": "TED",
        "number_of_views": 26175,
        "video_length": "17:30",
        "description": null,
        "is_live_content": null,
        "published_time": "17 hours ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/0juLRi90kRg/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCT3Z7_Av5R5ps81AS_C1cJAKO1ww",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/0juLRi90kRg/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBxu6-7b_D0K1rIB2oq3SH-2C9yDg",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/0juLRi90kRg/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBsb4F-YqYk_nKAI7jl6SltNfy6_A",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/0juLRi90kRg/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBkpjNPLLBZRTm7LGaKmn8PgU-UYg",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "hn5gytOCVgE",
        "title":
            "Why You Should Disappoint Your Parents | Desiree Akhavan | TED",
        "author": "TED",
        "number_of_views": 37641,
        "video_length": "9:37",
        "description": null,
        "is_live_content": null,
        "published_time": "1 day ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/hn5gytOCVgE/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLB_Hm4YdTv-vM2PoL0xMhQBR86Etw",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/hn5gytOCVgE/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCKcEqGwfPXQoIvv7MGI4qtc2ZZ5w",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/hn5gytOCVgE/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAHbUZvQ7Vvbe8JSMuxNalwFHlbNQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/hn5gytOCVgE/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLB3Afb1fCi4MXpFXu1QBASzQ3pDIg",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "b_boPcOY-FA",
        "title":
            "A Futuristic Vision for Latin America, Rooted in Ancient Design | Catalina Lotero | TED",
        "author": "TED",
        "number_of_views": 20871,
        "video_length": "11:50",
        "description": null,
        "is_live_content": null,
        "published_time": "2 days ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/b_boPcOY-FA/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDp3iyjiDT3NOzBA2Z_d80O7fQ7CQ",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/b_boPcOY-FA/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLB7ojoIEkvoH6HhWMMtxpgb0zlp8g",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/b_boPcOY-FA/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAcnTbP1F1_nr1oDaj4tTE-ggxr2Q",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/b_boPcOY-FA/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDaMxZxJiGMyN89tYyKkV1r0SAF2w",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "4o-S4VIg8Ys",
        "title": "Music, Movement and Poetry | Tunde Olaniran | TED",
        "author": "TED",
        "number_of_views": 19175,
        "video_length": "9:48",
        "description": null,
        "is_live_content": null,
        "published_time": "5 days ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/4o-S4VIg8Ys/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBRMZPNpry462gJPdKcdzPqi-giYQ",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/4o-S4VIg8Ys/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBAtl0euEgZyoJWvTZkPDZAa5Fu2A",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/4o-S4VIg8Ys/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLC-flLAeBPgDI_a04YLYRIDqRMyPQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/4o-S4VIg8Ys/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAv7sE5kC4qjXFkuHvXnerrm9bo-A",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "Xj_VDOZjds8",
        "title": "Can AI Catch Criminals at Sea? | Dyhia Belhabib | TED",
        "author": "TED",
        "number_of_views": 36313,
        "video_length": "10:54",
        "description": null,
        "is_live_content": null,
        "published_time": "6 days ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/Xj_VDOZjds8/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBDCy09UDtplJ4v6_O82Wk2qz_CWw",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/Xj_VDOZjds8/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAZjrNENqJmRnvbKnvPgBNZnaPuHA",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/Xj_VDOZjds8/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLClBEkjDyry-SVBDmGZDyk_HU0aWA",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/Xj_VDOZjds8/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLB_xeGLE8uFeyd_bGLPPk4rlGdMeQ",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "Gdi7uN-DQYo",
        "title":
            "A New National Park to Reclaim Indigenous Land | Tracie Revis | TED",
        "author": "TED",
        "number_of_views": 21796,
        "video_length": "7:03",
        "description": null,
        "is_live_content": null,
        "published_time": "7 days ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/Gdi7uN-DQYo/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDmuzrOZ0Um5BDVy_cDCVFxWVj6Nw",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/Gdi7uN-DQYo/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLC817e1gT6tqy7Ze2E87nEWXRpO8Q",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/Gdi7uN-DQYo/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLB3412m46VmKV-Sysmgyvi4-PAVlQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/Gdi7uN-DQYo/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCzAgcucW1h43Rss1qzWhFRucs30g",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "_uUskajC1Ps",
        "title":
            "Ideas Change Everything — and What’s Next for TED | Chris Anderson and Monique Ruff-Bell | TED",
        "author": "TED",
        "number_of_views": 23009,
        "video_length": "20:42",
        "description": null,
        "is_live_content": null,
        "published_time": "8 days ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/_uUskajC1Ps/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDDVN7--2RKeccdP3uP2ZUE-5LWqQ",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/_uUskajC1Ps/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBnWGvxOnkBIss96tX6yTxXMA3zfQ",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/_uUskajC1Ps/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLChlaA5LnDPxb9Ref_-tXNzB5yK3A",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/_uUskajC1Ps/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAy2FrhJiB7L8gP-Di236UWxu8RZQ",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "Im_ghczQEPw",
        "title":
            "Want to Succeed in Business? Find a Problem to Solve | Anthony Tan and Amane Dannouni | TED",
        "author": "TED",
        "number_of_views": 42038,
        "video_length": "18:02",
        "description": null,
        "is_live_content": null,
        "published_time": "9 days ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/Im_ghczQEPw/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCfwbsXrAEZRF-Yz-IZajM0RzSBXg",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/Im_ghczQEPw/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDiK4NATYtSszynXGPuek_qPE4gTQ",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/Im_ghczQEPw/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLA1xmIyaPgVqFe6IFH8MqArJQYOog",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/Im_ghczQEPw/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBZ4CkHdJ0WWHq5HlSNEi65TyoLXw",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "9TFi9Zo4FJc",
        "title":
            "Your Invitation to Help Build a Sustainable Future | Jim Snabe | TED",
        "author": "TED",
        "number_of_views": 34548,
        "video_length": "6:24",
        "description": null,
        "is_live_content": null,
        "published_time": "11 days ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/9TFi9Zo4FJc/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAxN_ajOCLns1s9FeiwNOVR3aep6w",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/9TFi9Zo4FJc/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLB9_man1erjjCShJJMlNoHq0DXNqg",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/9TFi9Zo4FJc/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLADTh2f7tr3im484_sOpuoGps8hhw",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/9TFi9Zo4FJc/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBjlT84u1-q1lmzsin4pXArJoZa2A",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "fa7uN2vo6rc",
        "title": "How to Spot a Cult | Sarah Edmondson | TED",
        "author": "TED",
        "number_of_views": 100377,
        "video_length": "17:42",
        "description": null,
        "is_live_content": null,
        "published_time": "12 days ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/fa7uN2vo6rc/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLA1D4rcB6kKinsu090tO1FANzJVUA",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/fa7uN2vo6rc/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBgPUqqOtTbNFCYIXFD9OUPTzBZeA",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/fa7uN2vo6rc/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBflVDapX162ID2XFapAepQopkbcQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/fa7uN2vo6rc/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBz8-ItzC6GHwHFq8i8GCIgbfWqrw",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "alYBnyxMuPk",
        "title":
            "What Happens to Sex in Midlife? A Look at the “Bedroom Gap” | Maria Sophocles | TED",
        "author": "TED",
        "number_of_views": 129279,
        "video_length": "14:15",
        "description": null,
        "is_live_content": null,
        "published_time": "13 days ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/alYBnyxMuPk/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDtiue1D9BPVNy6qdRuqPsEV5BJSQ",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/alYBnyxMuPk/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCkb8APwrvmZkUpgs-gUBBRibB4hA",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/alYBnyxMuPk/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDKZlb_TPIH-8R0HLR5uXU1Jm_-OA",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/alYBnyxMuPk/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLA4_ob9AbiA0-mfjSBQqx4pr26OtQ",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "x4Yhi7ggins",
        "title":
            "I'm Terrified of Wanting to Be a Billionaire | Pardis Parker | TED",
        "author": "TED",
        "number_of_views": 19259,
        "video_length": "5:37",
        "description": null,
        "is_live_content": null,
        "published_time": "2 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/x4Yhi7ggins/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBUqeklIUG84Pi_kH1jgSUbGWBvzQ",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/x4Yhi7ggins/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBELUNSkht8wvE-x9BdEO-0XE46Sw",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/x4Yhi7ggins/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBU8VrDez4iOEcCP1aXzY-PKVpPKw",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/x4Yhi7ggins/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBeo82xH4z-oab-RMBwVETq29TF1w",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "7ZVu5N4gOgY",
        "title":
            "The Human Cost of Coal Mining in China | Xiaojun \"Tom\" Wang | TED",
        "author": "TED",
        "number_of_views": 19605,
        "video_length": "14:12",
        "description": null,
        "is_live_content": null,
        "published_time": "2 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/7ZVu5N4gOgY/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLA14wInG64P7uCxyhPZDN5P_t4jYQ",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/7ZVu5N4gOgY/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAbABm6TYEu211-MeY6TV1oPatGlA",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/7ZVu5N4gOgY/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBex9miODjlDevJ5bhKokFQGQe52Q",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/7ZVu5N4gOgY/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAJv-bMNgKq4L8LpgGdLprN1SgITw",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "bUmHABnk9FY",
        "title":
            "A Comedian’s Take on How to Save Democracy | Jordan Klepper | TED",
        "author": "TED",
        "number_of_views": 389947,
        "video_length": "8:08",
        "description": null,
        "is_live_content": null,
        "published_time": "2 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/bUmHABnk9FY/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBpREnh981Xe0-HxpLsGT_kSOSmtA",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/bUmHABnk9FY/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAoeYfKK0m20b03vNufPM4CP51Rkw",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/bUmHABnk9FY/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCUx23o_KeHlPAltzndgsQ2HamgKg",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/bUmHABnk9FY/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBhEGkmKYnhgPIS1bpdIAlN23Zfsg",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "RKEsIkJRuW4",
        "title":
            "How to Live With Economic Doomsaying | Philipp Carlsson-Szlezak | TED",
        "author": "TED",
        "number_of_views": 42902,
        "video_length": "10:03",
        "description": null,
        "is_live_content": null,
        "published_time": "2 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/RKEsIkJRuW4/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCpO1w53lBO-kEbesyDzj71sfJsfQ",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/RKEsIkJRuW4/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLB2hVCqpVlXb423MuvzAWhUM041zw",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/RKEsIkJRuW4/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCa7YMROvRgclCML3OMdMhbCT3rSw",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/RKEsIkJRuW4/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAg_T52aMSQZYTucyhR8bqTokMS4w",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "qxgE0q1_m6U",
        "title": "Let Your Garden Grow Wild | Rebecca McMackin | TED",
        "author": "TED",
        "number_of_views": 237076,
        "video_length": "12:23",
        "description": null,
        "is_live_content": null,
        "published_time": "2 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/qxgE0q1_m6U/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDGcAlNbvdsOwdLXLfxTJO0zlpMKg",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/qxgE0q1_m6U/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAvw16DM35riJZYbEdhbHEAajRHtQ",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/qxgE0q1_m6U/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBmccpzsXuyn5OgvpoUaMy83QZKZw",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/qxgE0q1_m6U/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAIAA4QovyVC_Mi7HzuXpl8_UKFoQ",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "cUdl-Cp-LWw",
        "title": "Why Don’t We Have Better Robots Yet? | Ken Goldberg | TED",
        "author": "TED",
        "number_of_views": 106836,
        "video_length": "12:11",
        "description": null,
        "is_live_content": null,
        "published_time": "2 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/cUdl-Cp-LWw/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAk2YmzM8UQBRqDfOo7qAUkP7sL9w",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/cUdl-Cp-LWw/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAo_bmEcvl-9MO3XTx0AectOa23EA",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/cUdl-Cp-LWw/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCEehyH3eRLrUoAwc-DzSrrWpX1eQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/cUdl-Cp-LWw/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCy2iS8Wmi9yx2RNcmuq9r-KZgzvw",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "JNG3wwLqRok",
        "title":
            "Invisible AI, a Personal Time Machine and More: A Celebration of Creativity from the TED Conference",
        "author": "TED",
        "number_of_views": 25905,
        "video_length": "1:45:57",
        "description": null,
        "is_live_content": null,
        "published_time": "3 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/JNG3wwLqRok/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLB3K5c5oEq-eMfGSmS3yWAiMeSAxw",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/JNG3wwLqRok/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBjF3GD_Y_pZNgYiKL0t9MuXGt0tg",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/JNG3wwLqRok/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLC4aP_ohvsOkKkSQsv81lC5g9yOGw",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/JNG3wwLqRok/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDLjxv8V9GoBth8tgUju5pyPOuQ0w",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "dxA6D4dJWn8",
        "title":
            "3 Steps to Better Connect With Your Fellow Humans | Amber Cabral | TED",
        "author": "TED",
        "number_of_views": 40474,
        "video_length": "12:50",
        "description": null,
        "is_live_content": null,
        "published_time": "3 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/dxA6D4dJWn8/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAqN-fqHDgSmzHf08hNvQc8Rr1eFQ",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/dxA6D4dJWn8/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLC4yB9NKzLxImFWlulUCT4DoN4Kpg",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/dxA6D4dJWn8/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCsWCKh8ZYuvrm2a8FKmvWdT_NUVA",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/dxA6D4dJWn8/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBCfmF1F6_o9Je4Kxl0kxmsI_mcoQ",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "wXODvu8UfXc",
        "title":
            "How Business Leaders Can Renew Democracy | Daniella Ballou-Aares | TED",
        "author": "TED",
        "number_of_views": 25890,
        "video_length": "11:35",
        "description": null,
        "is_live_content": null,
        "published_time": "3 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/wXODvu8UfXc/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLB3RDW9UeyYVxzK5hkvcLnIlOEpAA",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/wXODvu8UfXc/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAfOX2ppHMMZXnqHSMGFaHKWAF0NA",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/wXODvu8UfXc/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAok8lTsypXP5IS1H77X5j-pr-daQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/wXODvu8UfXc/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAQt43RNneBseM94FKmmOiJ3b5NPg",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "LbZC0DjnhGs",
        "title":
            "How to Choose Clothes for Longevity, Not the Landfill | Diarra Bousso | TED",
        "author": "TED",
        "number_of_views": 36512,
        "video_length": "10:48",
        "description": null,
        "is_live_content": null,
        "published_time": "3 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/LbZC0DjnhGs/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCFW8FMSbRr1EFD1YA60IMD-PtFsg",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/LbZC0DjnhGs/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDTiv4TFRxWVStRsfsEWplIBJfdWg",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/LbZC0DjnhGs/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAc1bfsgHZUmKVVQU-G2UcZaT6oxw",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/LbZC0DjnhGs/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBftIYaKZVTqtYxjHee7Yl8CIve-g",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "DbQjrA9VPjY",
        "title":
            "AI and the Paradox of Self-Replacing Workers | Madison Mohns | TED",
        "author": "TED",
        "number_of_views": 51090,
        "video_length": "9:18",
        "description": null,
        "is_live_content": null,
        "published_time": "3 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/DbQjrA9VPjY/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCk1zgJQpufouWIPXBtOexxxXFE1Q",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/DbQjrA9VPjY/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCKCaftVBdVYnFd9dtVRK8HkKch7Q",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/DbQjrA9VPjY/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCcrJhicDRLfV39R4dF2aMmeJO9Sg",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/DbQjrA9VPjY/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCfSMJaNhnIWDXTxch-UCbSJWOpZw",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "akNqFXCVPwU",
        "title":
            "Dear Fellow Refugees, Here’s How I Found Resilience | Chantale Zuzi Leader | TED",
        "author": "TED",
        "number_of_views": 15733,
        "video_length": "11:36",
        "description": null,
        "is_live_content": null,
        "published_time": "3 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/akNqFXCVPwU/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDbG8rfJENh021qKmev92yD7NDkog",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/akNqFXCVPwU/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCq3IeET1KxvgegIgtu9t-z3poogw",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/akNqFXCVPwU/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDkbAQk3iLUE_AHWdrcqWl8H-x6tQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/akNqFXCVPwU/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLABmDKP1r3WJcp9l80Yg1wdrt5YRg",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "spwXNUFHhAg",
        "title":
            "How a Sanctuary for Self-Expression Can Change Lives | Lindsay Morris and Reed J. Williams | TED",
        "author": "TED",
        "number_of_views": 9796,
        "video_length": "15:35",
        "description": null,
        "is_live_content": null,
        "published_time": "3 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/spwXNUFHhAg/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDFqkAMD2yS5GgL99kMeUQdtF57MQ",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/spwXNUFHhAg/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLC5CQyzoA50036MxgGHHguyBWBxlA",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/spwXNUFHhAg/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDAWo0ejQNeFz11xPwuudISPhOYCw",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/spwXNUFHhAg/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAUXxFKqmFnOUvkGPTG1n9fBwpAEA",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "Y8tqH6MnJUU",
        "title":
            "The Unsung Heroes Fighting Malnutrition | Shruthi Baskaran-Makanju | TED",
        "author": "TED",
        "number_of_views": 12971,
        "video_length": "12:23",
        "description": null,
        "is_live_content": null,
        "published_time": "3 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/Y8tqH6MnJUU/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCvUq5N5AU7XDwhVMh-0BV_MQraQg",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/Y8tqH6MnJUU/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDasS0hRRDLqlgvMchX5_x-Psw9xQ",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/Y8tqH6MnJUU/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLB5tx6eeZbht0M1xMUgatIOiMhJiA",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/Y8tqH6MnJUU/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDYvx5o6mdh4HDNGKtwzR2AnqdJAg",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "8qojNkkvzSQ",
        "title":
            "5 Lessons on Happiness — from Pop Fame to Poisonous Snakes | Mike Posner | TED",
        "author": "TED",
        "number_of_views": 63209,
        "video_length": "18:00",
        "description": null,
        "is_live_content": null,
        "published_time": "4 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/8qojNkkvzSQ/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDqlhlGkVkGQQiwESlWh5W9XIeBrw",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/8qojNkkvzSQ/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBabNz1SJPwptHJUZyWD45UjxUfng",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/8qojNkkvzSQ/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLC4kQdKw4fLuz7rYpssvJImS7kAhQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/8qojNkkvzSQ/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBNeVQEpPmtBxL-6vnFp7QW9iUbTQ",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "Q69o7mr-0S4",
        "title":
            "The Miracle of Organ Donation — and a Breakthrough for the Future | Abbas Ardehali | TED",
        "author": "TED",
        "number_of_views": 27826,
        "video_length": "10:12",
        "description": null,
        "is_live_content": null,
        "published_time": "4 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/Q69o7mr-0S4/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAeCTdXCFjNPJ9eIcuPjTAaLs6tcA",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/Q69o7mr-0S4/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBMvbGvV1R7mzJ-YxXXhLJttxayMA",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/Q69o7mr-0S4/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCJflUpTLEgBpCRfgI-vQZ1_5h8PA",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/Q69o7mr-0S4/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAYxZQG_y2VGQU9r-K0bYUzwCLEUA",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "syxEMoU8KWg",
        "title":
            "The 5 Tenets of Turning Pain Into Power | Christine Schuler Deschryver | TED",
        "author": "TED",
        "number_of_views": 12523,
        "video_length": "11:39",
        "description": null,
        "is_live_content": null,
        "published_time": "4 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/syxEMoU8KWg/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCM03Dj_jNKtNWXa8t5q7RPqlqy6g",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/syxEMoU8KWg/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCYpsG2ROeTlRhiUsWsgsr6AmnShA",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/syxEMoU8KWg/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLA3IVkgGwnUkkL2nIpJ9MkSSi2WXw",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/syxEMoU8KWg/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLB702yNhQj9MnntKBOllDsV545QGQ",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "ngk7VVyveu8",
        "title":
            "Meet Mini-Grids — the Clean Energy Solution Bringing Power to Millions | Tombo Banda | TED",
        "author": "TED",
        "number_of_views": 35473,
        "video_length": "10:31",
        "description": null,
        "is_live_content": null,
        "published_time": "4 weeks ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/ngk7VVyveu8/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCM30j9U67OYvRWcwXO2ulkMejK2g",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/ngk7VVyveu8/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLARSiHl-IN4ACTjnSNaLwmdo3Z4Vw",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/ngk7VVyveu8/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAvehG_qLSOYw-Zs-zMIxfK4tmD5g",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/ngk7VVyveu8/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLA2o7XPD4V7KgnpJzfH1HUoljHY7g",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "FzhI2D_kaCY",
        "title":
            "A Path to Social Safety for Migrant Workers | Ashif Shaikh | TED",
        "author": "TED",
        "number_of_views": 29021,
        "video_length": "8:01",
        "description": null,
        "is_live_content": null,
        "published_time": "1 month ago",
        "channel_id": "UCAuUUnT6oDeKwE6v1NGQxug",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/FzhI2D_kaCY/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBVr6XjUNgLb67zwkOkqN7Z-7b4Sg",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/FzhI2D_kaCY/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLA5H3vWn40HrwABuZooA5G34aGT8Q",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/FzhI2D_kaCY/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBZpNXNJUAVeLFLBZGX9j1zldWIkw",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/FzhI2D_kaCY/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAJjTLJHfPrdkxvbooyPQbta7PLeQ",
            "width": 336,
            "height": 188
          }
        ]
      }
    ];

    for (int i = 0; i < url.length; i++) {
      var videoId = VideoId(
          'https://www.youtube.com/watch?v=${url[i]['video_id']}&ab_channel=TED');
      video = await yt.videos.get(videoId);
      print(
          'log-data: "${video.title}"|${video.thumbnails.maxResUrl}|056418c5-f39d-4451-ab1c-ae54fae8322a|${video.duration!.inSeconds}|${video.url}');
    }
    //   var videoId =
    //       VideoId('https://www.youtube.com/watch?v=XezfOVE9RFM&ab_channel=TED');
    // video = await yt.videos.get(videoId);
  }

  void initScrollController() {
    scrollController = ScrollController();
    itemScrollController = ItemScrollController();
  }

  void scrollToIndex(int index) {
    // scrollController.animateTo(
    //   index * 60,
    //   duration: const Duration(seconds: 1),
    //   curve: Curves.fastOutSlowIn,
    // );
    itemScrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 1),
    );
  }

  void initYtController() {
    ytController = YoutubePlayerController(
      initialVideoId: video.id.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        controlsVisibleAtStart: false,
        hideThumbnail: true,
        forceHD: true,
        hideControls: true,
      ),
    );
    // ytController.addListener(() {

    // });
    ytController.addListener(() {
      if (ytController.value.playerState == PlayerState.playing) {
        String duration = formatDuration(captions.value[0].start as double);
        String positon =
            formatMilliseconds(ytController.value.position.inMilliseconds);
        if (duration == positon) {
          debugPrint('compare: $duration - $positon');

          currentCaption.value =
              '${captions.value[0].start!}: ${captions.value[0].text!}';

          int selectedIndex = originCaptions.value.indexOf(captions.value[0]);

          scrollToIndex(selectedIndex);

          ItemCaptionModel itemCaptionModel = ItemCaptionModel(
              captionResponse: originCaptions.value[selectedIndex],
              isSelected: true);

          listCaptionsShowing.value = [
            ...listCaptionsShowing.value.sublist(0, selectedIndex),
            itemCaptionModel,
            ...listCaptionsShowing.value.sublist(selectedIndex + 1)
          ];

          if (listCaptionsShowing.value.length != originCaptions.value.length) {
            Get.snackbar('title',
                '${listCaptionsShowing.value.length} - ${originCaptions.value.length}');
          }
          update();

          captions.value = [...captions.value.sublist(1)];
        }
      }
    });

    print('log-data: title ${video.title}');
    print('log-data: id ${video.id}');
    print('log-data: url ${video.url}');
    print('log-data: thumbnails ${video.thumbnails.maxResUrl}');
    print('log-data: inminute ${video.duration!.inMinutes}');
    print('log-data:  inseconds ${video.duration!.inSeconds}');
    print('log-data:  duration ${video.duration}');

    print(
        'log-data: "${video.title}"|${video.thumbnails.maxResUrl}|056418c5-f39d-4451-ab1c-ae54fae8322a|${video.duration!.inSeconds}|${video.url}');
  }

  Future<void> getCaptions(String videoId) async {
    var headers = {
      'X-RapidAPI-Key': dotenv.get('X-RapidAPI-Key'),
      'X-RapidAPI-Host': dotenv.get('X-RapidAPI-Host')
    };
    var data = '''''';
    var dio = Dio();
    var response = await dio
        .request(
      'https://subtitles-for-youtube.p.rapidapi.com/subtitles/$videoId',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    )
        .timeout(
      Durations.extralong4,
      onTimeout: () {
        throw TimeoutException('The request timed out');
      },
    );

    if (response.statusCode == 200) {
      captions.value = (response.data as List<dynamic>)
          .map((item) => CaptionResponse.fromMap(item))
          .toList();
      originCaptions.value = [...captions.value];
      listCaptionsShowing.value = originCaptions.value
          .map((item) => ItemCaptionModel(captionResponse: item))
          .toList();
    } else {
      debugPrint('response.statusMessage: ${response.statusMessage}');
    }
  }
}
