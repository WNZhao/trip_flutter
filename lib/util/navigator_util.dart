import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip_flutter/pages/login_page.dart';

import '../pages/home_page.dart';

class NavigatorUtil {

  /// 用于在获取不到context的地方，如dao中跳转页面时使用，需要在HomePage中初始化
  static BuildContext? _context;
  static void updateContext(BuildContext context) {
    NavigatorUtil._context = context;
    print('NavigatorUtil._context: ${NavigatorUtil._context}');
  }

  static void push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static void pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }

  static void pushAndRemoveUntil(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => page), (route) => route == null);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  // 跳转到首页 不需要返回上一页
  static void goHomePage(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
  // 跳转到登录页 不需要返回上一页
  static void goLoginPage() {
    Navigator.pushReplacement(_context!, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}