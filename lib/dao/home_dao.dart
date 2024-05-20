import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:trip_flutter/dao/header_util.dart';
import 'package:trip_flutter/model/home_model.dart';
import 'package:trip_flutter/util/navigator_util.dart';

/// 首页接口
class HomeDao {
  static Future<HomeModel?> fetch() async {
    // var url = Uri.parse('https://www.wanandroid.com/article/list/0/json');
    var url = Uri(
      scheme: 'http',
      host: '192.168.2.6',
      path: '/m1/4491700-4138515-default/ft/home',
      port: 4523,
    );

    final response = await http.get(url, headers: hiHeaders());
    Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
    String bodyString = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode == 200) {
      var result = json.decode(bodyString);
      if(result['code'] == 0 && result['data'] != null){
        debugPrint('到这里了${result['data']['config']['searchUrl']}');
        debugPrint('#######${HomeModel.fromJson(result['data'])}') ;
        return HomeModel.fromJson(result['data']);
      }else {
        throw Exception(result['message'] ?? '请求失败');
      }
    } else {
      if (response.statusCode == 401) {
        // throw Exception('登录过期，请重新登录');
        NavigatorUtil.goLoginPage();
        return null;
      }
      throw Exception(bodyString);
    }
  }
}
