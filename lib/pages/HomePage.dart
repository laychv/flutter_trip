import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

/*
 * 首页
 */
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

const APPBAR_SCROLL_OFFSET = 100;

class _HomePageState extends State<HomePage> {
  double appbarAlpha = 0;
  List _imageUrls = [
    'https://cdn.pixabay.com/photo/2016/12/26/17/28/food-1932466_1280.jpg',
    'https://cdn.pixabay.com/photo/2018/07/12/02/32/basil-3532424_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/09/09/17/38/basil-932079_1280.jpg'
  ];

  _onScroll(offset) {
//    print(offset);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 适配刘海屏
      body: MediaQuery.removePadding(
        removeTop: true, // 适配刘海屏
        context: context,
        // 监听列表滚动
        child: Stack(
          children: <Widget>[
            NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    // 滚动且是列表滚动的时候
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                },
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 160,
                      child: Swiper(
                        itemCount: _imageUrls.length,
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            _imageUrls[index],
                            fit: BoxFit.fill,
                          );
                        },
                        pagination: SwiperPagination(),
                      ),
                    ),
                    Container(
                      height: 800,
                      child: ListTile(
                        title: Text("nei rong"),
                      ),
                    )
                  ],
                )),
            // appbar
            Opacity(
              opacity: appbarAlpha,
              child: Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text('首页'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
