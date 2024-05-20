import 'package:flutter/material.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/navigator/tab_navigator.dart';
import 'package:trip_flutter/pages/login_page.dart';
import 'package:trip_flutter/util/screen_adapter_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter之旅',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<dynamic>(
        future: HiCache.preInit(),
        builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot) {
          // 初始化屏幕适配工具
          ScreenHelper.init(context);
          if (snapshot.connectionState == ConnectionState.done) {
            print('======================TabNavigator======================');
            if(LoginDao.getToken()==null){
              return const LoginPage();
            }else {
              return const TabNavigator();//HomePage();
            }
          }
          return Scaffold(body: Center(child: CircularProgressIndicator(),));
        },
      )
    );
  }
}

