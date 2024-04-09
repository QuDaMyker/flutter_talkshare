import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VideoModel {
  final String id;
  final String title;
  final String imgUrlVideo;
  final String imgUrlBrand;
  final String nameOfBrand;

  VideoModel({
    required this.id,
    required this.title,
    required this.imgUrlVideo,
    required this.imgUrlBrand,
    required this.nameOfBrand,
  });

  VideoModel copyWith({
    String? id,
    String? title,
    String? imgUrlVideo,
    String? imgUrlBrand,
    String? nameOfBrand,
  }) {
    return VideoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imgUrlVideo: imgUrlVideo ?? this.imgUrlVideo,
      imgUrlBrand: imgUrlBrand ?? this.imgUrlBrand,
      nameOfBrand: nameOfBrand ?? this.nameOfBrand,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imgUrlVideo': imgUrlVideo,
      'imgUrlBrand': imgUrlBrand,
      'nameOfBrand': nameOfBrand,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] as String,
      title: map['title'] as String,
      imgUrlVideo: map['imgUrlVideo'] as String,
      imgUrlBrand: map['imgUrlBrand'] as String,
      nameOfBrand: map['nameOfBrand'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VideoModel(id: $id, title: $title, imgUrlVideo: $imgUrlVideo, imgUrlBrand: $imgUrlBrand, nameOfBrand: $nameOfBrand)';
  }

  @override
  bool operator ==(covariant VideoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.imgUrlVideo == imgUrlVideo &&
        other.imgUrlBrand == imgUrlBrand &&
        other.nameOfBrand == nameOfBrand;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        imgUrlVideo.hashCode ^
        imgUrlBrand.hashCode ^
        nameOfBrand.hashCode;
  }
}
