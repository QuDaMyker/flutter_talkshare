import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_talkshare/modules/video/models/caption_response.dart';
import 'package:flutter_talkshare/modules/video/models/item_caption_model.dart';
import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';
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
        "video_id": "XBCq6JGKqUg",
        "title":
            "Take a ride inside Ehang’s fully autonomous, two-seater air taxi",
        "author": "CNBC International",
        "number_of_views": 220,
        "video_length": "5:32",
        "description": null,
        "is_live_content": null,
        "published_time": "18 minutes ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/XBCq6JGKqUg/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDzaIWSVuq2RJg50hTrk4jDorGJgA",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/XBCq6JGKqUg/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCfWOElOeDyIwOXuExlj7wO-DJwHw",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/XBCq6JGKqUg/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAwqra-t0e-Vlk059tfxastsDX2Uw",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/XBCq6JGKqUg/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBaQX30cUbdgGN3j78c-RKLULXcQg",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "ZBGWSyxGqBw",
        "title": "Will Israel retaliate to Iran's attack?",
        "author": "CNBC International",
        "number_of_views": 2664,
        "video_length": "1:01",
        "description": null,
        "is_live_content": null,
        "published_time": "2 days ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/ZBGWSyxGqBw/hqdefault.jpg?sqp=-oaymwE1CKgBEF5IVfKriqkDKAgBFQAAiEIYAXABwAEG8AEB-AHOBYACgAqKAgwIABABGGUgZShlMA8=&rs=AOn4CLCyUB7aKi3aQafb432CWisiUW59Gg",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/ZBGWSyxGqBw/hqdefault.jpg?sqp=-oaymwE1CMQBEG5IVfKriqkDKAgBFQAAiEIYAXABwAEG8AEB-AHOBYACgAqKAgwIABABGGUgZShlMA8=&rs=AOn4CLBTGUxSMWrUgI-pReckfMR6IVsSdg",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/ZBGWSyxGqBw/hqdefault.jpg?sqp=-oaymwE2CPYBEIoBSFXyq4qpAygIARUAAIhCGAFwAcABBvABAfgBzgWAAoAKigIMCAAQARhlIGUoZTAP&rs=AOn4CLDSzsxRtrbgenq4icXK6_olAgsmhg",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/ZBGWSyxGqBw/hqdefault.jpg?sqp=-oaymwE2CNACELwBSFXyq4qpAygIARUAAIhCGAFwAcABBvABAfgBzgWAAoAKigIMCAAQARhlIGUoZTAP&rs=AOn4CLCy_B6ZO6PYSoZzngBsVNBmFTieyA",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "4hxk30BTwgY",
        "title":
            "Inside Lilium, the German company trying to revolutionize air travel",
        "author": "CNBC International",
        "number_of_views": 44432,
        "video_length": "6:12",
        "description": null,
        "is_live_content": null,
        "published_time": "6 days ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/4hxk30BTwgY/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLARcJiLy7kiUCWjhPGtZreGXAi_ZA",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/4hxk30BTwgY/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDjd1twI58CFgHeH5r5s1SvCuKgkA",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/4hxk30BTwgY/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLA_KNlWr-frfN7bpBvrrQ__itaNOw",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/4hxk30BTwgY/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBk2NR8bai2drKo85ExLfl4hV8UFw",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "KKG0keV5Vg4",
        "title":
            "Bitcoin halving - here’s what it is and what it means for the crypto",
        "author": "CNBC International",
        "number_of_views": 4196,
        "video_length": "25:57",
        "description": null,
        "is_live_content": null,
        "published_time": "5 days ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/KKG0keV5Vg4/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCFZUm2zwZRpfA1p4IG7yoKaDlZpA",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/KKG0keV5Vg4/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCgFpE2Qs85NMdiilYyS7rW7lW3-w",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/KKG0keV5Vg4/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBZRFIWo69aQUswyJRcqiBh23bavg",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/KKG0keV5Vg4/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLD-ZkO_EmMfQnmjuCFK8B7fMGMHkg",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "qp7rnrCCQ6w",
        "title": "Can China's Comac break up the Airbus-Boeing duopoly?",
        "author": "CNBC International",
        "number_of_views": 137617,
        "video_length": "11:19",
        "description": null,
        "is_live_content": null,
        "published_time": "7 days ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/qp7rnrCCQ6w/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLA_LonNddtyhOnAPJ3KhSApYrYgUQ",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/qp7rnrCCQ6w/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDNRRH8Xz2lFP3AxxASSupWAMAOZw",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/qp7rnrCCQ6w/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCdwb_vyCWorXVP3LqvX87VY3YqTA",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/qp7rnrCCQ6w/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAWZ2OzADw9MeKUgcbgQoFSqOqqrA",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "qtzuL3WSiGY",
        "title":
            "Inside Alef, the company trying to build a car you can both drive and fly",
        "author": "CNBC International",
        "number_of_views": 57647,
        "video_length": "6:19",
        "description": null,
        "is_live_content": null,
        "published_time": "2 weeks ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/qtzuL3WSiGY/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDaMGsn0af2_zwllGqWkqoVxnThfw",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/qtzuL3WSiGY/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAT36zg_jBCItPxo7f33aSuqlHZKw",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/qtzuL3WSiGY/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBwv4mPNTSpt7N53wDoshQHqXvg5Q",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/qtzuL3WSiGY/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAZkpDECzqMyK_dc2GtFCddcgNfvQ",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "bWG3FCshAFU",
        "title": "How India is challenging China as Asia's tech powerhouse",
        "author": "CNBC International",
        "number_of_views": 7033,
        "video_length": "30:55",
        "description": null,
        "is_live_content": null,
        "published_time": "2 weeks ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/bWG3FCshAFU/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCrZhKZiv8t_30wUYjwQItDh6pgjw",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/bWG3FCshAFU/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBL1UkgCAGJp2lXPaMt8gOenB62Yw",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/bWG3FCshAFU/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLD9_-E0LfTf1IDapNvrBFbDHXSXQg",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/bWG3FCshAFU/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCYVMqBIY8P6uyy0s_LgWRZza73dA",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "7gLBJpnmAo8",
        "title": "eVTOLS: Are flying cars finally becoming a reality?",
        "author": "CNBC International",
        "number_of_views": 21842,
        "video_length": "6:00",
        "description": null,
        "is_live_content": null,
        "published_time": "2 weeks ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/7gLBJpnmAo8/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBkY8KJlQX-tQJucy2dbPjC_FDHmA",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/7gLBJpnmAo8/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCBAFWBw7DDIB5zxDozyjYgSBXb_A",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/7gLBJpnmAo8/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLATwBEUjPPs0NUrOV2MVbLOLEvs5w",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/7gLBJpnmAo8/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCzrPCNSuKHj0ibCwoP3RW6URS04A",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "KHCU-EaIBRs",
        "title":
            "Flying cars — or eVTOLs — are taking off. Would you ride in one?",
        "author": "CNBC International",
        "number_of_views": 4052,
        "video_length": "33:43",
        "description": null,
        "is_live_content": null,
        "published_time": "2 weeks ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/KHCU-EaIBRs/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBAMijyXxehzRz3oKFJhZG6kDW9Fw",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/KHCU-EaIBRs/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLC2y5fQPiDR2tngh_oBJdpHiRENDg",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/KHCU-EaIBRs/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLArFGwcQt0oqEvgiAGvkCXexSwvQw",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/KHCU-EaIBRs/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCaUEkBUVE7K4Rfh3_fnFp-P5kHRw",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "if_Qfm377qA",
        "title": "Splinternet: What happens if the internet we know breaks up?",
        "author": "CNBC International",
        "number_of_views": 1525,
        "video_length": "30:13",
        "description": null,
        "is_live_content": null,
        "published_time": "2 weeks ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/if_Qfm377qA/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDk-BX0s7KWfFHes8Wgs06WmCmdvA",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/if_Qfm377qA/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCgdxoGE707AJjKY6i94_xphjL3lQ",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/if_Qfm377qA/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAedHNBCVmq1DrcrooB1kETHgDY_g",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/if_Qfm377qA/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAYQYh8ivfmC7LJ34Dcgquu3X1c_g",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "VD1j50G_AMg",
        "title": "Taxing the super-rich: Could a 'billionaire tax' work?",
        "author": "CNBC International",
        "number_of_views": 56317,
        "video_length": "8:02",
        "description": null,
        "is_live_content": null,
        "published_time": "1 month ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/VD1j50G_AMg/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBj6n36PxoRtgeS-m0QOO59_RtB5Q",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/VD1j50G_AMg/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLD5letUgcwTJDHYuHiZpYcBci18AQ",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/VD1j50G_AMg/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDqkhhsTkBNy4W9kJhkbTAs5v90gg",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/VD1j50G_AMg/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAvkb20FA21L9bS2ZpYWUrhlKKDoA",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "vnoV-zO6pqY",
        "title": "What lies ahead in TikTok's uncertain future",
        "author": "CNBC International",
        "number_of_views": 2388,
        "video_length": "31:36",
        "description": null,
        "is_live_content": null,
        "published_time": "2 weeks ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/vnoV-zO6pqY/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDrfeKq_dxRPwGqLPI5o1i_1B9epA",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/vnoV-zO6pqY/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLATWUdMXTUgoqL5kXHDLvKTLailDA",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/vnoV-zO6pqY/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBBghmxYGN2dvlT2W9L0JGhdqv54Q",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/vnoV-zO6pqY/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLC4IU93ZDufjOOgTLd0AtNF0nrhLw",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "wLO5tIDTyx8",
        "title": "Can Alibaba make a comeback?",
        "author": "CNBC International",
        "number_of_views": 3667,
        "video_length": "29:04",
        "description": null,
        "is_live_content": null,
        "published_time": "2 weeks ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/wLO5tIDTyx8/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBzWu5GLZ0fsH51buRJxGQk-qhmsQ",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/wLO5tIDTyx8/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAFFRDOZ1h-QoU9zDjVCK-pFnSapQ",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/wLO5tIDTyx8/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCASLjgAHayYObM_xpcjcTKDdaeEA",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/wLO5tIDTyx8/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLA1oPv3nQLQ1tk0Lw0giNMaWNHEkQ",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "hnN0cdYp4A8",
        "title": "Can AI revive the smartphone?",
        "author": "CNBC International",
        "number_of_views": 2163,
        "video_length": "38:08",
        "description": null,
        "is_live_content": null,
        "published_time": "2 weeks ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/hnN0cdYp4A8/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDFPzDjeDlX85rwi1YmTEWiqK6WQQ",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/hnN0cdYp4A8/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAmh1Ejy6oFuna9Qd_yPkDhjX305Q",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/hnN0cdYp4A8/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCwxHqFHFnDFlDAvEU1fgdsGaqkBg",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/hnN0cdYp4A8/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBDNp-yi1nb8awHceijooHyyjlLXA",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "ogaZBVeUG-M",
        "title": "How China's property bubble burst",
        "author": "CNBC International",
        "number_of_views": 540997,
        "video_length": "8:46",
        "description": null,
        "is_live_content": null,
        "published_time": "1 month ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/ogaZBVeUG-M/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAhj_PCLHFSdbML2ViWaF4ToXEwhg",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/ogaZBVeUG-M/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAz6fmLJjYZhyFDu6d6P6No35OHmQ",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/ogaZBVeUG-M/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLD5Ae5ieSGVo9J6Ooj7yjQXm2E3SQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/ogaZBVeUG-M/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAEvHXMpSSCsX-EoLPPruHlgFD8hA",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "1Q5DWqV7Myw",
        "title": "Can South Korea’s untouchable chaebols change?",
        "author": "CNBC International",
        "number_of_views": 369332,
        "video_length": "12:15",
        "description": null,
        "is_live_content": null,
        "published_time": "1 month ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/1Q5DWqV7Myw/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDM4BIqrkfRIqs4YSuMpaGVaUh3nA",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/1Q5DWqV7Myw/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDlWXvBzfPzcDJw89Rp3B7dYtdmtQ",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/1Q5DWqV7Myw/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDAEJUvjqMAm74I--EZQt4n7Tynag",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/1Q5DWqV7Myw/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDfYvbkl7PqQ3bQ2wQlD8ziEXlsFQ",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "PrLZWBF2v9Y",
        "title":
            "China appears to be making strides in cutting-edge chips, despite U.S sanctions",
        "author": "CNBC International",
        "number_of_views": 10903,
        "video_length": "39:11",
        "description": null,
        "is_live_content": null,
        "published_time": "2 weeks ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/PrLZWBF2v9Y/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCvLrCWP8zS0xFIN_gJV5aJg1K6nQ",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/PrLZWBF2v9Y/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBzfmKRSx7ybV4XZTzeiwQ3ZDge5Q",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/PrLZWBF2v9Y/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDBWgE8Pk3ryNmcIjc5xLj-J8LyVw",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/PrLZWBF2v9Y/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLD0F7AGEQH0PiUqfGn7Af05SwH24A",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "xuEpU_IdvNo",
        "title": "Why is Switzerland home to so many billionaires?",
        "author": "CNBC International",
        "number_of_views": 1218933,
        "video_length": "7:24",
        "description": null,
        "is_live_content": null,
        "published_time": "2 months ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/xuEpU_IdvNo/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLD-9bzFJ4eKUXW-L4Zv0IwntW6F1g",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/xuEpU_IdvNo/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBUkXbwfP36THgqqcNEjqteJTP7ag",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/xuEpU_IdvNo/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCvnVJMTXltf6Aq4VZFxPaIsVm_4w",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/xuEpU_IdvNo/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDcnz5Dbc6nQhnc8o6q9I6KnFY0AA",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "sSqfc15c36U",
        "title": "Can cloud seeding make the UAE's desert green?",
        "author": "CNBC International",
        "number_of_views": 239870,
        "video_length": "9:24",
        "description": null,
        "is_live_content": null,
        "published_time": "2 months ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/sSqfc15c36U/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLA2Qt9fUEPUmgIeX3oun9-bU-UZLg",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/sSqfc15c36U/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDHo5uj2x-MAHqU7T_OtCvlFN5qjA",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/sSqfc15c36U/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCCf44Uyor77tOMrLo_NmBiOI2Rjg",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/sSqfc15c36U/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLC0s_O0rMvd9u3PjPwmVyc6GIU9hw",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "h77un7ry5bY",
        "title":
            "We tested five ways to find hidden cameras in hotels and house rentals",
        "author": "CNBC International",
        "number_of_views": 1457928,
        "video_length": "10:18",
        "description": null,
        "is_live_content": null,
        "published_time": "2 months ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/h77un7ry5bY/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAIikFWRW8SfUaFSp310Pr5I6QjVw",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/h77un7ry5bY/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCQjktmKYYVlbqqzR1puJGysxso4w",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/h77un7ry5bY/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCefEGkOZGTjeYHWKkwXV3FMHLVnQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/h77un7ry5bY/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLC3VV0gelCd-Y0OPeBFSrxb1Y2jfA",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "z_eDZXUtu8w",
        "title": "What is the World Economic Forum?",
        "author": "CNBC International",
        "number_of_views": 59852,
        "video_length": "7:02",
        "description": null,
        "is_live_content": null,
        "published_time": "3 months ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/z_eDZXUtu8w/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLD1q5GysRA20g76Ds5bPY3cfNa4Bw",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/z_eDZXUtu8w/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDmD29QI6gV2ZmSo36RHxh2YBF5CQ",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/z_eDZXUtu8w/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDKAHXmMFsZkf00tTnk5FRzDxLrzQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/z_eDZXUtu8w/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAvu_g62o1yLouWhf7PsRpZsKMtqw",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "7Zi8DHcCxV0",
        "title":
            "India is moving beyond call centers and IT support – but can it work?",
        "author": "CNBC International",
        "number_of_views": 514333,
        "video_length": "9:49",
        "description": null,
        "is_live_content": null,
        "published_time": "3 months ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/7Zi8DHcCxV0/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBomw6WDiInfmfFECXLl4XhkGv4QA",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/7Zi8DHcCxV0/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLB3Dx9Q7ve2D2X41xZUdCeXLq_2tw",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/7Zi8DHcCxV0/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLClZfnO14WF82gvz6Z1gvGKxMnSsQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/7Zi8DHcCxV0/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLD6ELTa00eqZaMsNDzT1sJ6RMBHUA",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "5geLTX4gSj0",
        "title": "Could the vaping industry go up in smoke?",
        "author": "CNBC International",
        "number_of_views": 198829,
        "video_length": "8:27",
        "description": null,
        "is_live_content": null,
        "published_time": "3 months ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/5geLTX4gSj0/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLA83KxB2-zKbbcJ3d6f-tQbCISwoA",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/5geLTX4gSj0/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCugueRL3-EKDfN6Cw8WNQdF0OhFg",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/5geLTX4gSj0/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCgU1WNJpJOlig6HS14xxOD9C0NwQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/5geLTX4gSj0/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDmC7NB1WcmcjfBzu2ZfFpHLsNbFQ",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "Zl75i06M4zI",
        "title": "Inside the airport with the world’s best customer service",
        "author": "CNBC International",
        "number_of_views": 196360,
        "video_length": "9:27",
        "description": null,
        "is_live_content": null,
        "published_time": "3 months ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/Zl75i06M4zI/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDJEHot2e8hvhbyf-4R27aMRxwWHw",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/Zl75i06M4zI/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAJVJwQt4AEUd86zuIJdfPcvdwPuw",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/Zl75i06M4zI/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAV2F56CvPe-Lia6j0LiM0ydhjpnQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/Zl75i06M4zI/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCCnRzL76kfcYY3568TujBhBQ4Mkw",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "g7ZvID7KE3s",
        "title": "Can Saudi Arabia keep links with Israel?",
        "author": "CNBC International",
        "number_of_views": 72214,
        "video_length": "7:45",
        "description": null,
        "is_live_content": null,
        "published_time": "4 months ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/g7ZvID7KE3s/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDvgEsJXl5gT6tIR-gXQpgr7wlfEw",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/g7ZvID7KE3s/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLAgyWmgFe6dJYmwpvSgcPGiZlDpiA",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/g7ZvID7KE3s/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAN1GGVqqUiBmYIn5lzdsiEv5Mcng",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/g7ZvID7KE3s/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLBbWhgkc1-_pPlUlnt5AcXUyxIQPg",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "SGHk3zE5xh4",
        "title": "A ‘thirsty’ AI boom could deepen Big Tech’s water crisis",
        "author": "CNBC International",
        "number_of_views": 25210,
        "video_length": "7:52",
        "description": null,
        "is_live_content": null,
        "published_time": "4 months ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/SGHk3zE5xh4/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBVxd_QKKyx5Vb6ETVDpJ9Gai1JDw",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/SGHk3zE5xh4/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCtwMB9vCFxPU2u_SmqYn8Kjty8kg",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/SGHk3zE5xh4/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLB4DyR92cvabrXwKiMTboU7UriJNQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/SGHk3zE5xh4/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCKmycnQUpyrCv3sFdioajuHiU7lQ",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "NSI4JVYwSv4",
        "title":
            "South Korea wants to become one of the world's biggest arms dealers",
        "author": "CNBC International",
        "number_of_views": 1058500,
        "video_length": "9:35",
        "description": null,
        "is_live_content": null,
        "published_time": "4 months ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/NSI4JVYwSv4/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLB74ERLPlQiHttRPKaBDeuQwZEOsg",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/NSI4JVYwSv4/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDAoGogHdB3j9w4clZm0Pwq7nNRyw",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/NSI4JVYwSv4/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAmwpOjZRXWLlyMz3UGguEt6CgOfg",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/NSI4JVYwSv4/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCpmH9GRvrMkOF6yFCIvV-mfo2cuA",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "BtRitulncLc",
        "title": "Is the UK space industry about to take off?",
        "author": "CNBC International",
        "number_of_views": 50249,
        "video_length": "13:12",
        "description": null,
        "is_live_content": null,
        "published_time": "5 months ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/BtRitulncLc/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLCsL-7KzSLAQ1X0HBqM_sYas9YGLQ",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/BtRitulncLc/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDL27YcoE3pS80jLJPIfhqI6KRvVA",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/BtRitulncLc/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAUSKiptebkrUVEyyZXOBgIQY8-3A",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/BtRitulncLc/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLC4EAnAZiDqDhcbK6F7s_dJ2aVEVQ",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "Ssu3MR6ql4k",
        "title": "Why do we have chemicals in our food?",
        "author": "CNBC International",
        "number_of_views": 409882,
        "video_length": "9:25",
        "description": null,
        "is_live_content": null,
        "published_time": "5 months ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/Ssu3MR6ql4k/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLDK9w0X9AlN0dleYVL_Q2tGOYx8LA",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/Ssu3MR6ql4k/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBM1YChzSXnNtC6rHBoFW0VTA4c7Q",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/Ssu3MR6ql4k/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLD2aXzmR4fAle5MDr2WqnmXbLNXBw",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/Ssu3MR6ql4k/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLDP-2B_3b_yKH_oU_9uuKUbsjMQmQ",
            "width": 336,
            "height": 188
          }
        ]
      },
      {
        "video_id": "T7yuR5DM-nE",
        "title":
            "Factories are heading for a ‘dark’ future — and it’s not what you think",
        "author": "CNBC International",
        "number_of_views": 299071,
        "video_length": "10:07",
        "description": null,
        "is_live_content": null,
        "published_time": "5 months ago",
        "channel_id": "UCo7a6riBFJ3tkeHjvkXPn1g",
        "category": null,
        "type": "NORMAL",
        "keywords": [],
        "thumbnails": [
          {
            "url":
                "https://i.ytimg.com/vi/T7yuR5DM-nE/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBePWEuMs3YbQo3SDhkygdeI0aOvA",
            "width": 168,
            "height": 94
          },
          {
            "url":
                "https://i.ytimg.com/vi/T7yuR5DM-nE/hqdefault.jpg?sqp=-oaymwEbCMQBEG5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLA8uZ8MeUNNPgajW_pLO81qItRSpw",
            "width": 196,
            "height": 110
          },
          {
            "url":
                "https://i.ytimg.com/vi/T7yuR5DM-nE/hqdefault.jpg?sqp=-oaymwEcCPYBEIoBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAWkGHixeP8wkT9zJPWdk-E5elpuQ",
            "width": 246,
            "height": 138
          },
          {
            "url":
                "https://i.ytimg.com/vi/T7yuR5DM-nE/hqdefault.jpg?sqp=-oaymwEcCNACELwBSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLCfbagr6MriVclNg4SMARnJMWYvAA",
            "width": 336,
            "height": 188
          }
        ]
      }
    ];
    String idChanel = 'd8b8fb9f-e3b9-482a-9496-ec8eb8f36741';
    for (int i = 0; i < url.length; i++) {
      var videoId = VideoId(
          'https://www.youtube.com/watch?v=${url[i]['video_id']}&ab_channel=TED');
      video = await yt.videos.get(videoId);
      print(
          'log-data: "${video.title}"|${video.thumbnails.maxResUrl}|$idChanel|${video.duration!.inSeconds}|${video.url}');

      String rs = await SupabaseService.instance.addVideo(
        title: video.title,
        thumbnail: video.thumbnails.maxResUrl,
        id_channel: idChanel,
        duration: video.duration!.inSeconds,
        urlVideo: video.url,
      );
      debugPrint('log-data: $rs');
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
        'log-data: "${video.title}"|${video.thumbnails.maxResUrl}|ed97c496-409f-4f8b-b0cf-4cb4e837255b|${video.duration!.inSeconds}|${video.url}');
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
