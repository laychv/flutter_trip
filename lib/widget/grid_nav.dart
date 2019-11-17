import 'package:flutter/material.dart';
import 'package:flutter_trip/model/home/common_model.dart';
import 'package:flutter_trip/model/home/grid_nav_model.dart';
import 'package:flutter_trip/util/NavigatorUtil.dart';
import 'package:flutter_trip/widget/webview.dart';

/// 网络卡片 自定义组件
class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  const GridNav({Key key, this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    if (gridNavModel.hotel != null) {
      items.add(_gridNavItem(context, gridNavModel.hotel, true));
    }
    if (gridNavModel.flight != null) {
      items.add(_gridNavItem(context, gridNavModel.flight, false));
    }
    if (gridNavModel.travel != null) {
      items.add(_gridNavItem(context, gridNavModel.travel, false));
    }
    return items;
  }

  _gridNavItem(BuildContext context, GridNavItem gridNavModel, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavModel.mainItem));
    items.add(_doubleItem(context, gridNavModel.item1, gridNavModel.item2));
    items.add(_doubleItem(context, gridNavModel.item3, gridNavModel.item4));
    List<Widget> expandItem = [];
    items.forEach((item) {
      expandItem.add(Expanded(child: item, flex: 1));
    });
    Color startColor = Color(int.parse("0xff" + gridNavModel.startColor));
    Color endColor = Color(int.parse("0xff" + gridNavModel.endColor));
    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        // 线性渐变色
        gradient: LinearGradient(colors: [startColor, endColor]),
      ),
      child: Row(children: expandItem),
    );
  }

  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter, // 文字居中
          children: <Widget>[
            Image.network(
              model.icon,
              fit: BoxFit.fill,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
              child: Text(
                model.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
        model);
  }

  _doubleItem(
      BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context, topItem, true),
        ),
        Expanded(
          child: _item(context, bottomItem, false),
        ),
      ],
    );
  }

  _item(BuildContext context, CommonModel model, bool first) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              left: borderSide, bottom: first ? borderSide : BorderSide.none),
        ),
        child: Center(
            child: _wrapGesture(
                context,
                Text(
                  model.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                model)),
      ),
    );
  }

  _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        // 跳转到webview
        NavigatorUtil.push(
            context,
            WebView(
              url: model.url,
              statusBarColor: model.statusBarColor,
              hideAppBar: model.hideAppBar,
            ));
      },
      child: widget,
    );
  }
}
