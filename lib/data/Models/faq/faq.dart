import 'package:json_annotation/json_annotation.dart';
part 'faq.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Faq {
  final String id;
  final int sort;
  final MultiLanguageContent title;
  final MultiLanguageContent content;
  Faq({
    required this.id,
    required this.sort,
    required this.title,
    required this.content,
  });

  factory Faq.fromJson(Map<String, dynamic> json) => _$FaqFromJson(json);
  Map<String, dynamic> toJson() => _$FaqToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MultiLanguageContent {
  final String ruRu;
  final String uzUz;
  final String usEn;
  final String uzlat;
  MultiLanguageContent({
    required this.ruRu,
    required this.uzUz,
    required this.usEn,
    required this.uzlat,
  });
  factory MultiLanguageContent.fromJson(Map<String, dynamic> json) =>
      _$MultiLanguageContentFromJson(json);
  Map<String, dynamic> toJson() => _$MultiLanguageContentToJson(this);
}
