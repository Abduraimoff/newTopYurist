import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_yurist/data/Models/faq/faq.dart';

class FAQDataProvider {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<void> saveFAQ(List<Faq> faq) async {
    final storage = await _sharedPreferences;
    final value = jsonEncode(faq);
    await storage.setString('faq', value);
  }

  Future<List<Faq>?> getFAQ() async {
    final storage = await _sharedPreferences;
    final value = storage.getString('faq');
    if (value == null) {
      return null;
    }
    final list = jsonDecode(value) as List;
    final faqs = list.map((e) => Faq.fromJson(e)).toList();
    return faqs;
  }
}
