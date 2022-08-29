import 'package:flutter/material.dart';
import 'package:top_yurist/data/Models/multi_language_content/multi_language_content.dart';

String getCurrentLanguageContent({
  required BuildContext context,
  required MultiLanguageContent content,
}) {
  final currentLanguage = Localizations.localeOf(context).languageCode;
  switch (currentLanguage) {
    case 'uz':
      return content.uzUz;
    case 'uz_lat':
      return content.uzLat;
    case 'ru':
      return content.ruRu;
    case 'en':
      return content.usEn;
    default:
      return content.uzLat;
  }
}
