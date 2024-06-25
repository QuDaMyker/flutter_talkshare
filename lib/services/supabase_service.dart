// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_talkshare/core/models/audio_room.dart';
import 'package:flutter_talkshare/core/models/blog.dart';
import 'package:flutter_talkshare/core/models/livestream.dart';
import 'package:flutter_talkshare/modules/auth/models/user_model.dart';
import 'package:flutter_talkshare/modules/video/models/channel_model.dart';
import 'package:flutter_talkshare/modules/video/models/subtitle_model.dart';
import 'package:flutter_talkshare/modules/video/models/video_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_talkshare/core/models/folder.dart';
import 'package:flutter_talkshare/core/models/vocab.dart';
import 'package:flutter_talkshare/core/models/wordset.dart';
import 'package:flutter_talkshare/core/values/supabase_table.dart';
import 'package:flutter_talkshare/utils/data.dart';
import 'package:flutter_talkshare/utils/helper.dart';

part 'user_service.dart';
part 'vocab_service.dart';
part 'wordset_service.dart';
part 'audio_room_service.dart';
part 'livestream_service.dart';
part 'game_service.dart';
part 'blog_service.dart';

class SupabaseService {
  SupabaseService._internal();
  factory SupabaseService() => instance;
  static final SupabaseService instance = SupabaseService._internal();
  late SupabaseClient supabase;

  Future<void> init() async {
    await Supabase.initialize(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    );
    supabase = Supabase.instance.client;
  }

  Future<void> login(String email, String password) async {
    await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<List<WordSet>> getWordSet() async {
    List<WordSet> listWordSet = [];
    try {
      final query = await supabase
          .from('wordset')
          .select('wordset_id, name, avatar_url, folder_id, user_id')
          .eq('user_id', 'f6d32d14-961c-4fba-94ff-7e76f9031a09');

      for (var i in query) {
        WordSet wordSet = WordSet.fromJson(i);
        listWordSet.add(wordSet);
      }

      return listWordSet;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<int> getCounterWordSet(String wordsetId) async {
    final query = await supabase
        .from('wordset_vocab')
        .select('wordset_id')
        .eq('wordset_id', wordsetId)
        .count();
    return query.count;
  }

  Future<List<String>> getWordsetVocab(String wordsetId) async {
    List<String> listVocab = [];
    try {
      final query = await supabase
          .from('wordset_vocab')
          .select('word')
          .eq('wordset_id', wordsetId);

      for (var i in query) {
        listVocab.add(i['word']);
      }

      return listVocab;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<int> insertFolder(Folder folder) async {
    try {
      await supabase.from('folder').insert({
        'name': folder.name,
        'user_id': folder.userId,
      });
      return 200;
    } catch (e) {
      debugPrint(e.toString());
      return 400;
    }
  }

  Future<bool> isBookmarkOn(String word, String userId) async {
    try {
      final query = await supabase
          .from('saved_word')
          .select('word, user_id')
          .eq('word', word)
          .eq('user_id', userId)
          .count();
      if (query.count != 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<int> addRemoveBookmark(String word, String userId) async {
    try {
      bool isExist = await isBookmarkOn(word, userId);
      if (isExist) {
        await supabase.from('saved_word').delete().match({
          'word': word,
          'user_id': userId,
        });
      } else {
        await supabase.from('saved_word').insert({
          'word': word,
          'user_id': userId,
        });
      }

      return 200;
    } catch (e) {
      debugPrint(e.toString());
      return 400;
    }
  }

  Future<List<String>> getListSavedVocab(String userId) async {
    try {
      List<String> listVocab = [];
      final query = await supabase
          .from('saved_word')
          .select('word, user_id')
          .eq('user_id', userId);

      for (var i in query) {
        listVocab.add(i['word']);
      }
      return listVocab;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<ChannelModel>> getListChannel(int limit) async {
    try {
      List<ChannelModel> listChannel = [];

      await supabase
          .from('channel')
          .select('id, imgUrlBrand, nameOfBrand')
          .limit(limit)
          .then((value) {
        value.map((channel) {
          listChannel.add(ChannelModel.fromMap(channel));
        }).toList();
        return listChannel;
      });

      return listChannel;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<VideoModel>> getListVideo(int limit) async {
    try {
      List<VideoModel> listVideo = [];
      await supabase
          .from('videos')
          .select(
              'id, title, thumbnail, duration, urlVideo, channel(id, imgUrlBrand, nameOfBrand)')
          .limit(limit)
          .then((videos) {
        videos.map((video) {
          //print('video: ${video.toString()}');
          listVideo.add(VideoModel.fromMap(video));
        }).toList();
        return listVideo;
      });

      return listVideo;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<List<VideoModel>> getListVideoByIdChannel({
    required String idChannel,
    required int limit,
  }) async {
    try {
      List<VideoModel> listVideo = [];

      await supabase
          .from('channel')
          .select(
              'id, imgUrlBrand, nameOfBrand, videos(id, title, id_channel, thumbnail, duration, urlVideo)')
          .eq('id', idChannel)
          .limit(limit)
          .then((videos) {
        videos.map((video) {
          ChannelModel channelModel = ChannelModel(
            id: video['id'],
            imgUrlBrand: video['imgUrlBrand'],
            nameOfBrand: video['nameOfBrand'],
          );

          (video['videos'] as List<dynamic>).map((item) {
            listVideo.add(
              VideoModel.fromMapChannelModel(
                map: item,
                channelModel: channelModel,
              ),
            );
          }).toList();
        }).toList();
        return listVideo;
      });

      return listVideo;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<String> addVideo({
    required String title,
    required String thumbnail,
    required String id_channel,
    required int duration,
    required String urlVideo,
  }) async {
    try {
      await supabase.from('videos').insert({
        'title': title,
        'thumbnail': thumbnail,
        'id_channel': id_channel,
        'duration': duration,
        'urlVideo': urlVideo,
      });
      return 'done';
    } catch (e) {
      debugPrint(e.toString());
      return 'error';
    }
  }

  Future<String> addSubtitle({
    required SubtitleModel subtitleModel,
  }) async {
    try {
      await supabase.from('subtitle').insert({
        'id_video': subtitleModel.idVideo,
        'index': subtitleModel.index,
        'content': subtitleModel.content,
        'start': subtitleModel.start,
        'duration': subtitleModel.duration,
        'end': subtitleModel.end,
      });
      return 'done';
    } catch (e) {
      debugPrint(e.toString());
      return 'error';
    }
  }

  Future<int> getCountSub({required String id_video}) async {
    final queryCount = await supabase
        .from('subtitle')
        .select('id')
        .eq('id_video', id_video)
        .count();

    return queryCount.count;
  }

  Future<List<SubtitleModel>> getSubtitle({
    required String id_video,
  }) async {
    try {
      List<SubtitleModel> listSub = [];

      // final response = await supabase
      //     .from('subtitle')
      //     .select('id, id_video, index, content, start, duration, end')
      //     .eq('id_video', id_video);

      // if (response.isEmpty) {
      //   return [];
      // }

      // List<dynamic> data = response;
      // listSub.addAll(data.map((sub) => SubtitleModel.fromMap(sub)).toList());

      await supabase
          .from('subtitle')
          .select('id, id_video, index, content, start, duration, end')
          .eq('id_video', id_video)
          .order('index', ascending: true)
          .then((value) {
        for (int i = 0; i < value.length; i++) {
          listSub.add(SubtitleModel.fromMap(value[i]));
        }

        return listSub;
      });

      return listSub;
    } catch (e) {
      debugPrint('Error fetching subtitles: $e');
      throw Exception('Failed to fetch subtitles');
    }
  }
}
