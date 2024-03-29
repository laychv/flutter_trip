import 'dart:async';
import 'dart:convert';

import 'package:flutter_trip/model/search/search_model.dart';
import 'package:http/http.dart' as http;

/// 搜索接口
class SearchDao {
  static Future<SearchModel> fetch(String url,String text) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // 解决中文乱码问题
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model;
    } else {
      throw Exception('failed to load search_page.json');
    }
  }
}
