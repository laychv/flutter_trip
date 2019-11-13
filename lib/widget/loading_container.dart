import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 自定义 加载进度条
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool cover; // 是否覆盖在其他控件之上

  const LoadingContainer(
      {Key key,
      @required this.isLoading,
      this.cover = false,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !cover
        ? !isLoading ? child : _loadingView
        : Stack(
            children: <Widget>[child, isLoading ? _loadingView : null],
          );
  }

  Widget get _loadingView {
    return Container(
        padding: EdgeInsets.only(top: 200),
        alignment: Alignment.center,
        child: Center(
            child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("加载中...", style: TextStyle(fontSize: 12, color: Colors.black))
          ],
        )));
  }
}
