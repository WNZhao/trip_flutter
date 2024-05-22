import 'dart:convert';

import 'package:trip_flutter/dao/header_util.dart';
import 'package:trip_flutter/model/travel_tab_model.dart';

import '../model/travel_category_model.dart';
import 'package:http/http.dart' as http;

import '../util/navigator_util.dart';

/// 旅拍模块DAO

class TravelDao {
  static Future<TravelCategoryModel?> getCategory() async {
    var url = Uri.parse(
        'http://192.168.2.6:4523/m1/4491700-4138515-default/ft/category');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelCategoryModel.fromJson(result['data']);
    } else {
      if (response.statusCode == 401) {
        // throw Exception('登录过期，请重新登录');
        NavigatorUtil.goLoginPage();
        // return Future.error('登录过期，请重新登录');
        return null;
      }
      throw Exception('Failed to load travel_page.json');
    }
  }

  /// 获取旅拍类别下的数据
  static Future<TravelTabModel?> getTravels(
      String groupChannelCode, int pageIndex, int pageSize) async {
    Map<String, String> params = {};
    params['groupChannelCode'] = groupChannelCode;
    params['pageIndex'] = pageIndex.toString();
    params['pageSize'] = pageSize.toString();
    var uri = Uri.http(
        '192.168.2.6:4523', '/m1/4491700-4138515-default/ft/travels', params);
    var response = await http.get(uri, headers: hiHeaders());
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return TravelTabModel.fromJson(result['data']);
    } else {
      throw Exception('Failed to load travel_page.json');
    }
  }
}
