import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip_flutter/pages/home_page.dart';
import 'package:trip_flutter/pages/my_page.dart';
import 'package:trip_flutter/pages/search_page.dart';
import 'package:trip_flutter/pages/travel_page.dart';

import '../util/navigator_util.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  // 从0开始
  final PageController _controller = PageController(initialPage: 0);
  int currentIndex = 0;
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    // 更新导航器context,供退出登录时使用
    NavigatorUtil.updateContext(context);
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [ HomePage(),SearchPage(hideLeft: true,),TravelPage(),MyPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
           BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home,color: _activeColor),
            label: "首页",
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.search,color: _activeColor),
            label: "搜索",
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            activeIcon: Icon(Icons.camera_alt,color: _activeColor),
            label: "旅拍",
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            activeIcon: Icon(Icons.account_circle,color: _activeColor),
            label: "我的",
          ),
        ],

      ),
    );
  }
}
