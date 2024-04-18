import 'dart:convert';

import 'package:flutter_talkshare/modules/video/models/channel_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VideoModel {
  final String id;
  final String title;
  final String thumbnail;
  final int duration;
  final String urlVideo;
  final ChannelModel channel;
  VideoModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.duration,
    required this.urlVideo,
    required this.channel,
  });

  VideoModel copyWith({
    String? id,
    String? title,
    String? thumbnail,
    int? duration,
    String? urlVideo,
    ChannelModel? channel,
  }) {
    return VideoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      duration: duration ?? this.duration,
      urlVideo: urlVideo ?? this.urlVideo,
      channel: channel ?? this.channel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'duration': duration,
      'urlVideo': urlVideo,
      'channel': channel.toMap(),
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      thumbnail: map['thumbnail'] as String,
      duration: map['duration'] as int,
      urlVideo: map['urlVideo'] as String,
      channel: ChannelModel.fromMap(map['channel'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VideoModel(id: $id, title: $title, thumbnail: $thumbnail, duration: $duration, urlVideo: $urlVideo, channel: $channel)';
  }

  @override
  bool operator ==(covariant VideoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.thumbnail == thumbnail &&
        other.duration == duration &&
        other.urlVideo == urlVideo &&
        other.channel == channel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        thumbnail.hashCode ^
        duration.hashCode ^
        urlVideo.hashCode ^
        channel.hashCode;
  }
}
