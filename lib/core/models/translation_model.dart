// ignore_for_file: public_member_api_docs, sort_constructors_first
class TranslationModel {
  String? word;
  String? primaryMeaning;
  String? phonetic;
  String? audioUrl;
  List<Definition>? definition;

  TranslationModel(
      {this.word,
      this.primaryMeaning,
      this.phonetic,
      this.audioUrl,
      this.definition});

  TranslationModel.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    primaryMeaning = json['primary_meaning'];
    phonetic = json['phonetic'];
    audioUrl = json['audio_url'];
    if (json['definition'] != null) {
      definition = <Definition>[];
      json['definition'].forEach((v) {
        definition!.add(new Definition.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['word'] = this.word;
    data['primary_meaning'] = this.primaryMeaning;
    data['phonetic'] = this.phonetic;
    data['audio_url'] = this.audioUrl;
    if (this.definition != null) {
      data['definition'] = this.definition!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'TranslationModel(word: $word, primaryMeaning: $primaryMeaning, phonetic: $phonetic, audioUrl: $audioUrl, definition: $definition)';
  }
}

class Definition {
  String? word;
  String? example;
  String? meaningEn;
  String? meaningVi;
  String? definitionId;
  String? partOfSpeech;

  Definition(
      {this.word,
      this.example,
      this.meaningEn,
      this.meaningVi,
      this.definitionId,
      this.partOfSpeech});

  Definition.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    example = json['example'];
    meaningEn = json['meaning_en'];
    meaningVi = json['meaning_vi'];
    definitionId = json['definition_id'];
    partOfSpeech = json['part_of_speech'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['word'] = this.word;
    data['example'] = this.example;
    data['meaning_en'] = this.meaningEn;
    data['meaning_vi'] = this.meaningVi;
    data['definition_id'] = this.definitionId;
    data['part_of_speech'] = this.partOfSpeech;
    return data;
  }
}
