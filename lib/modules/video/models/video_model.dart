import 'dart:convert';

import 'package:flutter_talkshare/modules/video/models/channel_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VideoModel {
  final String id;
  final String title;
  final String imgUrlVideo;
  final ChannelModel channelModel;
  VideoModel({
    required this.id,
    required this.title,
    required this.imgUrlVideo,
    required this.channelModel,
  });

  VideoModel copyWith({
    String? id,
    String? title,
    String? imgUrlVideo,
    ChannelModel? channelModel,
  }) {
    return VideoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imgUrlVideo: imgUrlVideo ?? this.imgUrlVideo,
      channelModel: channelModel ?? this.channelModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imgUrlVideo': imgUrlVideo,
      'channelModel': channelModel.toMap(),
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      imgUrlVideo: map['imgUrlVideo'] as String,
      channelModel:
          ChannelModel.fromMap(map['channelModel'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VideoModel(id: $id, title: $title, imgUrlVideo: $imgUrlVideo, channelModel: $channelModel)';
  }

  @override
  bool operator ==(covariant VideoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.imgUrlVideo == imgUrlVideo &&
        other.channelModel == channelModel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        imgUrlVideo.hashCode ^
        channelModel.hashCode;
  }
}
