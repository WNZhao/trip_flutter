import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/login_dao.dart';

import '../util/navigator_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get _logoutBtn => ElevatedButton(onPressed: (){
    LoginDao.logout();
  }, child: const Text("退出登录"));
  @override
  Widget build(BuildContext context) {
    // 更新导航器context,供退出登录时使用
    NavigatorUtil.updateContext(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("首页"),
        actions: [
          _logoutBtn
        ],
      ),
    );
  }

  
}
