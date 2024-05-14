import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/login_dao.dart';

import '../util/navigator_util.dart';
import '../widget/banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//常驻内存
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  final bannerList= [
    "https://img2.baidu.com/it/u=870551452,2266026462&fm=253&fmt=auto&app=138&f=JPEG?w=1133&h=500",
    "https://img1.baidu.com/it/u=914096420,1112170026&fm=253&fmt=auto&app=138&f=JPEG?w=1280&h=467",
    "https://img1.baidu.com/it/u=3692249836,3777214708&fm=253&fmt=auto&app=138&f=JPEG?w=1201&h=500",
    "https://img2.baidu.com/it/u=1966261153,1356293834&fm=253&fmt=auto&app=138&f=JPEG?w=1333&h=500",
  ];
  get _logoutBtn => ElevatedButton(
      onPressed: () {
        LoginDao.logout();
      },
      child: const Text("退出登录"));
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("首页"),
          actions: [_logoutBtn],
        ),
        body: Column(
          children: [
            BannerWidget(
              bannerList: bannerList,
            )
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
