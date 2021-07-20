import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'navigation/tab_navigation.dart';

void main() {
  runApp(MyApp());

  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false, // 不显示debug标签
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TabNavigation());
  }
}
