import 'package:get/get.dart';
import 'package:trip_flutter/mvvm/login/views/login_page.dart';
import 'package:trip_flutter/mvvm/main/binding/main_binding.dart';
import 'package:trip_flutter/mvvm/main/views/main_page.dart';

import '../login/bindings/login_binding.dart';



part 'app_routes.dart';
/// 引用数据不用import
///
class AppPages {
  AppPages._();
  static const init = Routes.MAIN;
  static final routes =[
    GetPage(
      name: Routes.MAIN,
      page: () => MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
  ];

}