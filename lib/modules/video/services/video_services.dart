import 'package:flutter/foundation.dart';
import 'package:flutter_talkshare/modules/video/models/subtitle_model.dart';
import 'package:flutter_talkshare/services/supabase_service.dart';

class VideoServices {
  VideoServices._internal();
  static final VideoServices instance = VideoServices._internal();
  factory VideoServices() => instance;

  Future<List<SubtitleModel>> getCaptions(String videoId) async {
    try {
      List<SubtitleModel> listSub =
          await SupabaseService.instance.getSubtitle(id_video: videoId);

      return listSub;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  // Future<List<CaptionResponse>> getCaptions(String videoId) async {
  //   try {
  //     List<CaptionResponse> rs = [];
  //     var headers = {
  //       'X-RapidAPI-Key': dotenv.get('X-RapidAPI-Key'),
  //       'X-RapidAPI-Host': dotenv.get('X-RapidAPI-Host')
  //     };
  //     var data = '''''';
  //     var dio = Dio();
  //     var response = await dio.request(
  //       '${dotenv.get('RAPI_SUBTITLE_FOR_YOUTUBE_URL')}/$videoId?type=None&translated=None&lang=en',
  //       options: Options(
  //         method: 'GET',
  //         headers: headers,
  //       ),
  //       data: data,
  //     );

  //     if (response.statusCode == 200) {
  //       rs = (response.data as List<dynamic>)
  //           .map((item) => CaptionResponse.fromMap(item))
  //           .toList();
  //       return rs;
  //     } else {
  //       debugPrint('response.statusMessage: ${response.statusMessage}');
  //       return [];
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return [];
  //   }
  // }
}
