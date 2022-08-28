import 'package:json_annotation/json_annotation.dart';
part 'multi_language_content.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MultiLanguageContent {
  final String ruRu;
  final String uzUz;
  final String usEn;
  final String uzLat;
  MultiLanguageContent({
    required this.ruRu,
    required this.uzUz,
    required this.usEn,
    required this.uzLat,
  });

  factory MultiLanguageContent.fromJson(Map<String, dynamic> json) =>
      _$MultiLanguageContentFromJson(json);
  Map<String, dynamic> toJson() => _$MultiLanguageContentToJson(this);
}
