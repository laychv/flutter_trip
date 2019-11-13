import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home/common_model.dart';
import 'package:flutter_trip/widget/webview.dart';

/// 列表
class SubNav extends StatelessWidget {
  final List<CommonModel> subNavList;

  const SubNav({Key key, this.subNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(6)),
        child: Padding(padding: EdgeInsets.all(7), child: _items(context)));
  }

  _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    subNavList.forEach((model) {
      items.add(_item(context, model));
    });
    // 计算出每一行显示的数量
    int separate = (subNavList.length / 2 + 0.5).toInt();
    return Column(
      children: <Widget>[
        // 第一行
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        // 第二行
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, subNavList.length),
          ),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    // 确保第二行居中显示
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          // 跳转到webview
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebView(
                        url: model.url,
                        statusBarColor: model.statusBarColor,
                        hideAppBar: model.hideAppBar,
                      )));
        },
        child: Column(
          children: <Widget>[
            Image.network(model.icon, width: 18, height: 18),
            Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(model.title, style: TextStyle(fontSize: 12)))
          ],
        ),
      ),
    );
  }
}
