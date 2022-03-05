/// url : "https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5"
/// params : {"districtId":-1,"groupChannelCode":"tourphoto_global1","type":null,"lat":-180,"lon":-180,"locatedDistrictId":2,"pagePara":{"pageIndex":1,"pageSize":10,"sortType":9,"sortDirection":0},"imageCutType":1,"head":{"cid":"09031014111431397988","ctok":"","cver":"1.0","lang":"01","sid":"8888","syscode":"09","auth":null,"extension":[{"name":"protocal","value":"https"}]},"contentType":"json"}
/// tabs : [{"labelName":"推荐","groupChannelCode":"tourphoto_global1"},{"labelName":"端午去哪玩","groupChannelCode":"tab-dwqnw"},{"labelName":"权力的游戏","groupChannelCode":"quanliyouxi"},{"labelName":"创造营2019","groupChannelCode":"chuangzaoyingchaohua"},{"labelName":"比心地球","groupChannelCode":"ycy422"},{"labelName":"拍照技巧","groupChannelCode":"tab-photo"}]

///旅拍类别模型
class TravelTabModel {
  late Map params;
  late String url;
  late List<TravelTab> tabs;

  TravelTabModel(this.url, this.tabs);

  TravelTabModel.fromMap(Map<String, dynamic> json) {
    url = json['url'];
    params = json['params'];
    if (json['tabs'] != null) {
      tabs = new List<TravelTab>.empty(growable: true);
      json['tabs'].forEach((v) {
        tabs.add(new TravelTab.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    if (this.tabs != null) {
      data['tabs'] = this.tabs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TravelTab {
  late String labelName;
  late String groupChannelCode;

  TravelTab(this.labelName, this.groupChannelCode);

  TravelTab.fromJson(Map<String, dynamic> json) {
    labelName = json['labelName'];
    groupChannelCode = json['groupChannelCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labelName'] = this.labelName;
    data['groupChannelCode'] = this.groupChannelCode;
    return data;
  }
}

///// 旅拍类别
//class TravelTabModel {
//  ParamsBean params;
//  String url;
//  List<TravelTab> tabs;
//
//  static TravelTabModel fromMap(Map<String, dynamic> map) {
//    if (map == null) return null;
//    TravelTabModel travelTabModelBean = TravelTabModel();
//    travelTabModelBean.url = map['url'];
//    travelTabModelBean.params = ParamsBean.fromMap(map['params']);
//    travelTabModelBean.tabs = List()
//      ..addAll((map['tabs'] as List ?? []).map((o) => TravelTab.fromMap(o)));
//    return travelTabModelBean;
//  }
//
//  Map toJson() => {
//        "url": url,
//        "params": params,
//        "tabs": tabs,
//      };
//}

/// labelName : "推荐"
/// groupChannelCode : "tourphoto_global1"

//class TravelTab {
//  String labelName;
//  String groupChannelCode;
//
//  static TravelTab fromMap(Map<String, dynamic> map) {
//    if (map == null) return null;
//    TravelTab tabsBean = TravelTab();
//    tabsBean.labelName = map['labelName'];
//    tabsBean.groupChannelCode = map['groupChannelCode'];
//    return tabsBean;
//  }
//
//  Map toJson() => {
//        "labelName": labelName,
//        "groupChannelCode": groupChannelCode,
//      };
//}
//
///// districtId : -1
///// groupChannelCode : "tourphoto_global1"
///// type : null
///// lat : -180
///// lon : -180
///// locatedDistrictId : 2
///// pagePara : {"pageIndex":1,"pageSize":10,"sortType":9,"sortDirection":0}
///// imageCutType : 1
///// head : {"cid":"09031014111431397988","ctok":"","cver":"1.0","lang":"01","sid":"8888","syscode":"09","auth":null,"extension":[{"name":"protocal","value":"https"}]}
///// contentType : "json"
//
//class ParamsBean {
//  int districtId;
//  String groupChannelCode;
//  dynamic type;
//  int lat;
//  int lon;
//  int locatedDistrictId;
//  PageParaBean pagePara;
//  int imageCutType;
//  HeadBean head;
//  String contentType;
//
//  static ParamsBean fromMap(Map<String, dynamic> map) {
//    if (map == null) return null;
//    ParamsBean paramsBean = ParamsBean();
//    paramsBean.districtId = map['districtId'];
//    paramsBean.groupChannelCode = map['groupChannelCode'];
//    paramsBean.type = map['type'];
//    paramsBean.lat = map['lat'];
//    paramsBean.lon = map['lon'];
//    paramsBean.locatedDistrictId = map['locatedDistrictId'];
//    paramsBean.pagePara = PageParaBean.fromMap(map['pagePara']);
//    paramsBean.imageCutType = map['imageCutType'];
//    paramsBean.head = HeadBean.fromMap(map['head']);
//    paramsBean.contentType = map['contentType'];
//    return paramsBean;
//  }
//
//  Map toJson() => {
//        "districtId": districtId,
//        "groupChannelCode": groupChannelCode,
//        "type": type,
//        "lat": lat,
//        "lon": lon,
//        "locatedDistrictId": locatedDistrictId,
//        "pagePara": pagePara,
//        "imageCutType": imageCutType,
//        "head": head,
//        "contentType": contentType,
//      };
//}
//
///// cid : "09031014111431397988"
///// ctok : ""
///// cver : "1.0"
///// lang : "01"
///// sid : "8888"
///// syscode : "09"
///// auth : null
///// extension : [{"name":"protocal","value":"https"}]
//
//class HeadBean {
//  String cid;
//  String ctok;
//  String cver;
//  String lang;
//  String sid;
//  String syscode;
//  dynamic auth;
//  List<ExtensionBean> extension;
//
//  static HeadBean fromMap(Map<String, dynamic> map) {
//    if (map == null) return null;
//    HeadBean headBean = HeadBean();
//    headBean.cid = map['cid'];
//    headBean.ctok = map['ctok'];
//    headBean.cver = map['cver'];
//    headBean.lang = map['lang'];
//    headBean.sid = map['sid'];
//    headBean.syscode = map['syscode'];
//    headBean.auth = map['auth'];
//    headBean.extension = List()
//      ..addAll((map['extension'] as List ?? [])
//          .map((o) => ExtensionBean.fromMap(o)));
//    return headBean;
//  }
//
//  Map toJson() => {
//        "cid": cid,
//        "ctok": ctok,
//        "cver": cver,
//        "lang": lang,
//        "sid": sid,
//        "syscode": syscode,
//        "auth": auth,
//        "extension": extension,
//      };
//}
//
///// name : "protocal"
///// value : "https"
//
//class ExtensionBean {
//  String name;
//  String value;
//
//  static ExtensionBean fromMap(Map<String, dynamic> map) {
//    if (map == null) return null;
//    ExtensionBean extensionBean = ExtensionBean();
//    extensionBean.name = map['name'];
//    extensionBean.value = map['value'];
//    return extensionBean;
//  }
//
//  Map toJson() => {
//        "name": name,
//        "value": value,
//      };
//}
//
///// pageIndex : 1
///// pageSize : 10
///// sortType : 9
///// sortDirection : 0
//
//class PageParaBean {
//  int pageIndex;
//  int pageSize;
//  int sortType;
//  int sortDirection;
//
//  static PageParaBean fromMap(Map<String, dynamic> map) {
//    if (map == null) return null;
//    PageParaBean pageParaBean = PageParaBean();
//    pageParaBean.pageIndex = map['pageIndex'];
//    pageParaBean.pageSize = map['pageSize'];
//    pageParaBean.sortType = map['sortType'];
//    pageParaBean.sortDirection = map['sortDirection'];
//    return pageParaBean;
//  }
//
//  Map toJson() => {
//        "pageIndex": pageIndex,
//        "pageSize": pageSize,
//        "sortType": sortType,
//        "sortDirection": sortDirection,
//      };
//}
