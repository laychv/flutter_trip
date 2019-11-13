import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel/travel_tab_dao.dart';
import 'package:flutter_trip/model/travel/travel_tab_model.dart';
import 'package:flutter_trip/pages/travel/travel_item_page.dart';

/// 旅拍
class TravelTabPage extends StatefulWidget {
  @override
  _TravelTabPageState createState() => _TravelTabPageState();
}

// SingleTickerProviderStateMixin
class _TravelTabPageState extends State<TravelTabPage>
    with TickerProviderStateMixin {
  TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel travelTabModel;

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    TravelTabDao.fetch().then((TravelTabModel tabModel) {
      _controller = TabController(length: tabModel.tabs.length, vsync: this);
      setState(() {
        /// 初始化数据
        tabs = tabModel.tabs;
        travelTabModel = tabModel;
        print(tabs);
      });
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }

  @override
  void dispose() {
    /// 防止TabController内存泄漏
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
                controller: _controller,
                isScrollable: true,
                // 选中颜色
                labelColor: Color(0xff2fcfbb),
                // 未选中颜色
                unselectedLabelColor: Colors.black,
                // 指示器宽度
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: Color(0xff2fcfbb), width: 3),
                    insets: EdgeInsets.only(bottom: 10)),
                tabs: tabs.map<Tab>((TravelTab tab) {
                  return Tab(
                    text: tab.labelName,
                  );
                }).toList()),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children: tabs.map((TravelTab tab) {
                return TravelItemPage(
                  travelUrl: travelTabModel.url,
                  groupChannelCode: tab.groupChannelCode,
                  params: travelTabModel.params,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
