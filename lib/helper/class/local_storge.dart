import 'dart:convert';

import 'package:learnt_app/data/model/section.dart';
import 'package:universal_html/html.dart';

class LocalStorge {
  static Storage storage = window.localStorage;

  static void setValue(String key, String value) {
    storage[key] = value;
  }

  static void setSections(String key, List<Section> sections) {
    String sectionsJson = jsonEncode(sections.map((e) => e.toJson()).toList());
    storage[key] = sectionsJson;
  }

  static List<Section> getSections(String key) {
    String? sectionsJson = storage[key];
    if (sectionsJson != null) {
      List<dynamic> decoded = jsonDecode(sectionsJson);
      return decoded.map((e) => Section.fromJson(e)).toList();
    }
    return [];
  }

  static String getValue(String key) {
    return storage[key] ?? '';
  }

  static void removeValue(String key) {
    storage.remove(key);
  }

  static void clear() {
    storage.clear();
  }
}
