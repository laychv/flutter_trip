import 'dart:convert';

import 'package:flutter_trip/model/travel/travel_tab_model.dart';
import 'package:http/http.dart' as http;

const Travel_Tab_URL =
    'http://www.devio.org/io/flutter_app/json/travel_page.json';

/// 旅拍类别接口
class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    final response = await http.get(Travel_Tab_URL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // 解决中文乱码问题
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromMap(result);
    } else {
      throw Exception('failed to load home_page.json');
    }
  }
}
