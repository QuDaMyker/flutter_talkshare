// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_talkshare/modules/video/models/subtitle_model.dart';

class ItemCaptionModel {
  final bool isSelected;
  final SubtitleModel subtitleModel;
  ItemCaptionModel({
    this.isSelected = false,
    required this.subtitleModel,
  });

  ItemCaptionModel copyWith({
    bool? isSelected,
    SubtitleModel? subtitleModel,
  }) {
    return ItemCaptionModel(
      isSelected: isSelected ?? this.isSelected,
      subtitleModel: subtitleModel ?? this.subtitleModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isSelected': isSelected,
      'subtitleModel': subtitleModel.toMap(),
    };
  }

  factory ItemCaptionModel.fromMap(Map<String, dynamic> map) {
    return ItemCaptionModel(
      isSelected: map['isSelected'] as bool,
      subtitleModel:
          SubtitleModel.fromMap(map['subtitleModel'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemCaptionModel.fromJson(String source) =>
      ItemCaptionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ItemCaptionModel(isSelected: $isSelected, subtitleModel: $subtitleModel)';

  @override
  bool operator ==(covariant ItemCaptionModel other) {
    if (identical(this, other)) return true;

    return other.isSelected == isSelected &&
        other.subtitleModel == subtitleModel;
  }

  @override
  int get hashCode => isSelected.hashCode ^ subtitleModel.hashCode;
}
