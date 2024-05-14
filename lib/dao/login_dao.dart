import 'dart:convert';

import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import 'package:http/http.dart' as http;
import 'package:trip_flutter/util/navigator_util.dart';

/// 登录接口

class LoginDao {
  static const String boardingPass = "token";
  static login({required String username, required String password}) async {
    Map<String, String> params = {};
    params['username'] = username;
    params['password'] = password;
    var uri = Uri.http('8.130.100.148:8091', '/app/login');
    final response = await http.post(uri,
        body: jsonEncode(params),
        headers: {'Content-Type': 'application/json'});
    print('${response}=======???response');
    // final response = await http.post(uri,body: jsonBody,headers: hiHeaders());
    // 解决请求的乱码
    Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
    String body = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode == 200) {
      var result = json.decode(body);
      if (result['code'] == 200 && result['token'] != null) {
        // 保存登录令牌
        _saveToken(result['token']);
        return result;
      } else {
        throw Exception(result['msg']);
      }
    } else {
      throw Exception('Failed to load login');
    }
  }
  static logout() {
    // 删除登录令牌
    HiCache.getInstance().remove(boardingPass);
    // 路由跳转
    NavigatorUtil.goLoginPage();
  }

  static void _saveToken(result) {
    // flutter_hi_cache
    HiCache.getInstance().setString(boardingPass, result);
  }

  static String getToken() {
    return HiCache.getInstance().get(boardingPass);
  }
}
