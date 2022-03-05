import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/click_item.dart';

/// 我的 h5
class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
//    return Scaffold(
//        body: Center(
//      child: WebView(
//        url: 'https://m.ctrip.com/webapp/myctrip/',
//        hideAppBar: true,
//        backForbid: true,
//        statusBarColor: '4c5bca',
//      ),
//    ));
    /// 单页面 沉浸式
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: _mediaQuery,
    );
  }

  Widget get _safeArea {
    return SafeArea(
        top: true, bottom: true, left: true, right: false, child: _mediaQuery);
  }

  Widget get _mediaQuery {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _column,
    );
  }

  ///
  Widget get _column {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.blue[300],
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 95,
                height: 35,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shadowColor:
                          MaterialStateProperty.all(Colors.transparent),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.amber[200]),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )),
                  onPressed: () {
                    // CommToast.show(context: context, msg: "点击登陆了");
                  },
                  child: Text(
                    "登陆",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
              ),
              FlatButton(
                onPressed: () {
                  // CommToast.show(context: context, msg: "点击注册了");
                },
                child: Text(
                  "注册",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                color: Colors.amber[200],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClickItem(
                    title: "常用信息",
                    content: "旅客/地址/发票抬头",
                    onTap: () {},
                  ),
                  ClickItem(
                    title: "我的收藏",
                    content: "降价产品有提醒",
                    onTap: () {},
                  ),
                  ClickItem(
                    title: "浏览历史",
                    content: "近15天访问记录",
                    onTap: () {},
                  ),
                  ClickItem(
                    title: "我要合作",
                    content: "供应商加盟/代理合作",
                    onTap: () {},
                  ),
                  Container(
                    decoration: new BoxDecoration(
                        border: Border(
                          top: Divider.createBorderSide(context, width: 20),
                        ),
                        color: Color(0xe4e4e4)),
                  ),
                  ClickItem(
                    title: "出行工具",
                    content: "航班动态/翻译助手等",
                    onTap: () {},
                  ),
                  Container(
                    decoration: new BoxDecoration(
                        border: Border(
                          top: Divider.createBorderSide(context, width: 20),
                        ),
                        color: Color(0xe5e5e5)),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
