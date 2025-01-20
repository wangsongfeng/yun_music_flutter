// ignore_for_file: unused_element

import 'dart:convert';
import 'package:flutter/services.dart';

class CommonService {
  static Future<Map<String, dynamic>> jsonDecode(String path) async {
    return await rootBundle.loadString(path).then((value) {
      Map<String, dynamic> map = json.decode(value);
      return map;
    });
  }

  static Future<List<dynamic>> jsonArrayDecode(String path) async {
    return await rootBundle.loadString(path).then((value) {
      List<dynamic> map = json.decode(value);
      return map;
    });
  }
}
