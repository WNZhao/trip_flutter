import 'dart:convert';

import 'package:trip_flutter/dao/header_util.dart';
import 'package:trip_flutter/util/navigator_util.dart';

import '../model/search_model.dart';
import 'package:http/http.dart' as http;

/// 搜索接口
class SearchDao{
  static Future<SearchModel?> fetch(String keyword) async {
    var uri = Uri.parse("https://apifoxmock.com/m1/4491700-4138515-default/ft/search?q=" + keyword);
    final response = await http.get(uri,headers: hiHeaders());
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = const Utf8Decoder(); // fix 中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      SearchModel model =SearchModel.fromJson(result);
      model.keyword = keyword;
      return  model;
    } else {
      if(response.statusCode == 401){
        // throw Exception('登录过期，请重新登录');
         NavigatorUtil.goLoginPage();
         return null;
      }
      throw Exception('Failed to load search_page.json');
    }
  }
}