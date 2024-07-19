import 'package:flutter/material.dart';
import 'package:get/get.dart';
/// tabNavigator 的控制器
class MainViewModel extends GetxController {
  final currentIndex = 0.obs;
  final PageController controller = PageController(initialPage: 0);
  /// 页面切换监听
  void onBottomNavTap(int index) {
    // currentIndex.value = index;
    // 更新数据也可以这样
    currentIndex(index);
    controller.jumpToPage(index);

  }
}