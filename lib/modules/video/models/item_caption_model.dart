// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_talkshare/modules/video/models/caption_response.dart';

class ItemCaptionModel {
  bool isSelected;
  CaptionResponse captionResponse;
  ItemCaptionModel({
    this.isSelected = false,
    required this.captionResponse,
  });

  ItemCaptionModel copyWith({
    bool? isSelected,
    CaptionResponse? captionResponse,
  }) {
    return ItemCaptionModel(
      isSelected: isSelected ?? this.isSelected,
      captionResponse: captionResponse ?? this.captionResponse,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isSelected': isSelected,
      'captionResponse': captionResponse.toMap(),
    };
  }

  factory ItemCaptionModel.fromMap(Map<String, dynamic> map) {
    return ItemCaptionModel(
      isSelected: map['isSelected'] as bool,
      captionResponse: CaptionResponse.fromMap(
          map['captionResponse'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemCaptionModel.fromJson(String source) =>
      ItemCaptionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ItemCaptionModel(isSelected: $isSelected, captionResponse: $captionResponse)';

  @override
  bool operator ==(covariant ItemCaptionModel other) {
    if (identical(this, other)) return true;

    return other.isSelected == isSelected &&
        other.captionResponse == captionResponse;
  }

  @override
  int get hashCode => isSelected.hashCode ^ captionResponse.hashCode;
}
