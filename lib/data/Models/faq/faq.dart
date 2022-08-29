import 'package:json_annotation/json_annotation.dart';
import 'package:top_yurist/data/Models/multi_language_content/multi_language_content.dart';
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
