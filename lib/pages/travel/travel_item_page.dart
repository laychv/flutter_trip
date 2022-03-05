import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip/dao/travel/travel_item_dao.dart';
import 'package:flutter_trip/model/travel/travel_item_model.dart';
import 'package:flutter_trip/util/NavigatorUtil.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/webview.dart';
import 'package:transparent_image/transparent_image.dart';

/// 旅拍
const ITEM_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';
const PAGE_SIZE = 10;

class TravelItemPage extends StatefulWidget {
  final String? travelUrl;
  final String groupChannelCode;
  final Map params;

  const TravelItemPage(
      {Key? key,
      this.travelUrl,
      required this.groupChannelCode,
      required this.params})
      : super(key: key);

  @override
  _TravelItemPageState createState() => _TravelItemPageState();
}

class _TravelItemPageState extends State<TravelItemPage>
    with AutomaticKeepAliveClientMixin {
  List<TravelItem> travelItems = [];
  int pageIndex = 1;
  bool _isLoading = true;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    _loadData();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: _handleRefresh,
      child: LoadingContainer(
        isLoading: _isLoading,
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: StaggeredGridView.countBuilder(
              controller: controller,
              crossAxisCount: 4,
              itemCount: travelItems?.length ?? 0,
              itemBuilder: (BuildContext context, int index) =>
                  _TravelItems(index: index, item: travelItems[index]),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
            )),
      ),
    ));
  }

  // 可选参数
  void _loadData({loadMore = false}) {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }

    TravelItemDao.fetch(widget.travelUrl ?? ITEM_URL, widget.params!,
            widget.groupChannelCode!, pageIndex, PAGE_SIZE)
        .then((TravelItemModel model) {
      _isLoading = false;
      setState(() {
        List<TravelItem> items = _filterItems(model.resultList!);
        if (travelItems != null) {
          travelItems.addAll(items);
        } else {
          travelItems = items;
        }
      });
    }).catchError((e) {
      _isLoading = false;
      print(e);
    });
  }

  List<TravelItem> _filterItems(List<TravelItem> resultList) {
    if (resultList == null) return [];
    List<TravelItem> filterItems = [];
    resultList.forEach((items) {
      if (items.article != null) {
        filterItems.add(items);
      }
    });
    return filterItems;
  }

  @override
  bool get wantKeepAlive => true;

  Future<Null> _handleRefresh() async {
    _loadData();
    return null;
  }
}

class _TravelItems extends StatelessWidget {
  final int? index;
  final TravelItem item;

  const _TravelItems({Key? key, this.index, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.article.urls.length > 0) {
          NavigatorUtil.push(
              context,
              HiWebView(
                url: item.article.urls[0].h5Url,
                // title: item.article.author!.nickName, // todo text 溢出问题
                title: '详情',
              ));
        }
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            children: <Widget>[
              _itemImage(context),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  item.article.articleTitle,
                  maxLines: 2, // 最大2行
                  overflow: TextOverflow.ellipsis, // 末尾省略号
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ),
              _infoText(),
            ],
          ),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        // Image.network(item.article.images[0].dynamicUrl),
        Container(
          constraints: BoxConstraints(
            minHeight: size.width / 2 - 10,
          ),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: item.article.images[0].dynamicUrl,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
                LimitedBox(
                  maxWidth: 120,
                  child: Text(
                    _poiName(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _poiName() {
    return item.article.pois == null || item.article.pois?.length == 0
        ? '未知'
        : item.article.pois?[0].poiName ?? '未知';
  }

  _infoText() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              PhysicalModel(
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                      item.article.author?.coverImage?.dynamicUrl ?? "",
                      width: 24,
                      height: 24)),
              Container(
                  padding: EdgeInsets.all(5),
                  width: 90,
                  child: Text(
                    item.article.author?.nickName ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  )),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                color: Colors.grey,
                size: 14,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  item.article.likeCount.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
