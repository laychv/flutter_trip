import 'dart:async';
import 'dart:convert';

import 'package:flutter_trip/model/home/home_model.dart';
import 'package:http/http.dart' as http;

///通过as设置别名

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

/// 首页大接口
class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(HOME_URL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // 解决中文乱码问题
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('failed to load home_page.json');
    }
  }
}
