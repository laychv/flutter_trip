import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home/home_dao.dart';
import 'package:flutter_trip/model/home/common_model.dart';
import 'package:flutter_trip/model/home/grid_nav_model.dart';
import 'package:flutter_trip/model/home/home_model.dart';
import 'package:flutter_trip/model/home/sales_box_model.dart';
import 'package:flutter_trip/pages/search/search_page.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/loal_nav.dart';
import 'package:flutter_trip/widget/sales_nav.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:flutter_trip/widget/webview.dart';

/*
 * 首页
 */
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

class _HomePageState extends State<HomePage> {
  double appbarAlpha = 0;
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavModel = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;
  List<CommonModel> bannerList = [];
  bool _loading = true;

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appbarAlpha = alpha;
    });
    print(appbarAlpha);
  }

  /// way 1
  loadData() {
    HomeDao.fetch().then((result) {
      setState(() {
        localNavList = result.localNavList;
        gridNavModel = result.gridNav;
        subNavModel = result.subNavList;
        salesBoxModel = result.salesBox;
        bannerList = result.bannerList;
        _loading = false;
      });
    }).catchError((e) {
      print(e);
      setState(() {
        _loading = false;
      });
    });
  }

  /// way 2
  Future<void> handleRefresh() async {
    try {
      HomeModel result = await HomeDao.fetch();
      setState(() {
        localNavList = result.localNavList;
        gridNavModel = result.gridNav;
        subNavModel = result.subNavList;
        salesBoxModel = result.salesBox;
        bannerList = result.bannerList;
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
//    loadData();
    handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      // 适配刘海屏
      body: MediaQuery.removePadding(
          removeTop: true, // 适配刘海屏
          context: context,
          // 监听列表滚动
          child: LoadingContainer(
            isLoading: _loading,
            child: Stack(
              children: <Widget>[
                RefreshIndicator(
                    onRefresh: handleRefresh,
                    child: NotificationListener(
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollUpdateNotification &&
                              scrollNotification.depth == 0) {
                            // 滚动且是列表滚动的时候
                            _onScroll(scrollNotification.metrics.pixels);
                          }
                          return false;
                        },
                        child: buildListView)),
                // appbar
                appBar
              ],
            ),
          )),
    );
  }

  /// 抽取 列表
  Widget get buildListView {
    return ListView(
      children: <Widget>[
        Container(
          height: 160,
          child: Swiper(
            itemCount: bannerList.length,
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    CommonModel banner = bannerList[index];
                    return WebView(
                      url: banner.url,
                      title: banner.title,
                      hideAppBar: banner.hideAppBar,
                    );
                  }));
                },
                child: Image.network(
                  bannerList[index].icon,
                  fit: BoxFit.fill,
                ),
              );
            },
            pagination: SwiperPagination(),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(localNavList: localNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: GridNav(gridNavModel: gridNavModel),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: SubNav(subNavList: subNavModel),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: SalesBox(salesBox: salesBoxModel),
        ),
      ],
    );
  }

  /// 抽取 appBar
  Widget get appBar {
//    return Opacity(
//      opacity: appbarAlpha,
//      child: Container(
//        height: 80,
//        decoration: BoxDecoration(color: Colors.white),
//        child: Center(
//          child: Padding(
//            padding: EdgeInsets.only(top: 20),
//            child: Text('首页'),
//          ),
//        ),
//      ),
//    );
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x66000000), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
                color:
                    Color.fromARGB((appbarAlpha * 255).toInt(), 255, 255, 255)),
            child: SearchBar(
              searchBarType: appbarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: SEARCH_DEFAULT_TEXT,
              leftButtonClick: () {},
            ),
          ),
        ),
        // 阴影
        Container(
          height: appbarAlpha > 02 ? 0.5 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        ),
      ],
    );
  }

  /// 跳转到搜索栏
  _jumpToSearch() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SearchPage(
        hint: SEARCH_DEFAULT_TEXT,
      );
    }));
  }

  _jumpToSpeak() {}
}
