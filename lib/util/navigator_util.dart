import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/navigator/tab_navigator.dart';
import 'package:trip_flutter/pages/login_page.dart';

import '../pages/home_page.dart';
import '../widget/hi_webview.dart';

class NavigatorUtil {
  /// 用于在获取不到context的地方，如dao中跳转页面时使用，需要在HomePage中初始化
  static BuildContext? _context;
  static void updateContext(BuildContext context) {
    NavigatorUtil._context = context;
    print('NavigatorUtil._context: ${NavigatorUtil._context}');
  }

  static void push(BuildContext context, Widget page) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    Get.to(page);
  }

  static void pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static void pushAndRemoveUntil(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => page),
        (route) => route == null);
  }

  static void pop(BuildContext context) {
    // if (Navigator.canPop(context)) {
    //   Navigator.pop(context);
    // } else {
    //   SystemNavigator.pop(); // 退出app
    // }
    Get.back();
  }

  // 跳转到首页 不需要返回上一页
  static void goHomePage(BuildContext context) {
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => const TabNavigator()));
    // 跳转到一下个页面，并不能返回
    Get.offAll(const TabNavigator());
  }

  // 跳转到登录页 不需要返回上一页
  static void goLoginPage() {
    // print('NavigatorUtil._context: ${NavigatorUtil._context} ');
    // Navigator.pushReplacement(
    //     _context!, MaterialPageRoute(builder: (context) => const LoginPage()));
    Get.off(const LoginPage());
  }

  static jumpH5({
    BuildContext? context,
    String? url,
    String? title,
    bool? hideAppBar,
    String statusBarColor = 'ffffff',
  }) {
    // BuildContext? safeContext;
    // if (url == null) {
    //   debugPrint('url 不能为空');
    //   return;
    // }
    // if (url != null) {
    //   safeContext = context;
    // } else if (_context?.mounted ?? false) {
    //   safeContext = _context;
    // } else {
    //   debugPrint('context 不能为空, jumph5 failed');
    //   return;
    // }
    // Navigator.push(safeContext!, MaterialPageRoute(builder: (context) {
    //   return HiWebView(
    //     url: url,
    //     statusBarColor: statusBarColor,
    //     title: title ?? '',
    //     hideAppBar: hideAppBar ?? false,
    //   );
    // }));

    Get.to(HiWebView(
      url: url,
      statusBarColor: statusBarColor,
      title: title ?? '',
      hideAppBar: hideAppBar ?? false,
    ));
  }
}
