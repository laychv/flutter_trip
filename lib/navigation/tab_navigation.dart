import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home/home_page.dart';
import 'package:flutter_trip/pages/mine/mine_page.dart';
import 'package:flutter_trip/pages/search/search_page.dart';
import 'package:flutter_trip/pages/travel/travel_tab_page.dart';

/*
 * 首页导航
 */
class TabNavigation extends StatefulWidget {
  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  final PageController _controller = PageController(initialPage: 0);
  final Color _defaultColor = Colors.grey;
  final Color _activeColor = Colors.blue;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(hideLeft: true), // 这里搜索不需要返回
          TravelTabPage(),
          MinePage()
        ],
        physics: NeverScrollableScrollPhysics(), // 禁止滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            _bottomNavigationBarItem(Icons.home, "首页", 0),
            _bottomNavigationBarItem(Icons.search, "搜索", 1),
            _bottomNavigationBarItem(Icons.camera, "旅拍", 2),
            _bottomNavigationBarItem(Icons.account_circle, "我的", 3),
          ]),
    );
  }

  _bottomNavigationBarItem(IconData icon, String title, int index) {
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor),
        activeIcon: Icon(icon, color: _activeColor),
        label: title);
  }
}
