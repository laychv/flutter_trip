import 'package:flutter/material.dart';

///  跳转工具类
class NavigatorUtil {

  static push(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }
}
