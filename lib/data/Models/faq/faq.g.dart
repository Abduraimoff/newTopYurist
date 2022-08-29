// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Faq _$FaqFromJson(Map<String, dynamic> json) => Faq(
      id: json['id'] as String,
      sort: json['sort'] as int,
      title:
          MultiLanguageContent.fromJson(json['title'] as Map<String, dynamic>),
      content: MultiLanguageContent.fromJson(
          json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FaqToJson(Faq instance) => <String, dynamic>{
      'id': instance.id,
      'sort': instance.sort,
      'title': instance.title.toJson(),
      'content': instance.content.toJson(),
    };
