import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../dao/login_dao.dart';
import '../../../util/navigator_util.dart';

/// 登录输入框类型
enum LoginInputType { username, password }

class LoginViewModel extends GetxController {
  final loginEnable = false.obs;
  String? userName;
  String? password;

  /// 输入框内容变化
  void onValueChanged(String value, LoginInputType type) {
    // 判断输入框类型
    if (type == LoginInputType.username) {
      userName = value;
    } else {
      password = value;
    }
    // 判断登录按钮是否可用
    loginEnable(userName != null &&
        userName!.isNotEmpty &&
        password != null &&
        password!.isNotEmpty);
  }

  login() async {
    try {
      //需要添加await等登录完成没有问题后在跳转到首页
      var result =
          await LoginDao.login(username: userName!, password: password!);
      debugPrint('登录成功');
      NavigatorUtil.goHomePage();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //跳转到注册页面
  jumpRegistration() async {
    //跳转到接口后台注册账号
    Uri uri = Uri.parse(
        "https://api.geekailab.com/uapi/swagger-ui.html#/Account/registrationUsingPOST");
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $uri";
    }
  }
}
