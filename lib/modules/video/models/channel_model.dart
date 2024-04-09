// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChannelModel {
  final String id;
  final String imgUrlBrand;
  final String nameOfBrand;

  ChannelModel({
    required this.id,
    required this.imgUrlBrand,
    required this.nameOfBrand,
  });

  ChannelModel copyWith({
    String? id,
    String? imgUrlBrand,
    String? nameOfBrand,
  }) {
    return ChannelModel(
      id: id ?? this.id,
      imgUrlBrand: imgUrlBrand ?? this.imgUrlBrand,
      nameOfBrand: nameOfBrand ?? this.nameOfBrand,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imgUrlBrand': imgUrlBrand,
      'nameOfBrand': nameOfBrand,
    };
  }

  factory ChannelModel.fromMap(Map<String, dynamic> map) {
    return ChannelModel(
      id: map['id'] as String,
      imgUrlBrand: map['imgUrlBrand'] as String,
      nameOfBrand: map['nameOfBrand'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChannelModel.fromJson(String source) =>
      ChannelModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChannelModel(id: $id, imgUrlBrand: $imgUrlBrand, nameOfBrand: $nameOfBrand)';

  @override
  bool operator ==(covariant ChannelModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.imgUrlBrand == imgUrlBrand &&
        other.nameOfBrand == nameOfBrand;
  }

  @override
  int get hashCode => id.hashCode ^ imgUrlBrand.hashCode ^ nameOfBrand.hashCode;
}
