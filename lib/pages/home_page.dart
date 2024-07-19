import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/home_dao.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/model/home_model.dart';
import 'package:trip_flutter/navigator/tab_navigator.dart';
import 'package:trip_flutter/pages/search_page.dart';
import 'package:trip_flutter/util/view_util.dart';
import 'package:trip_flutter/widget/grid_nav_widget.dart';
import 'package:trip_flutter/widget/loading_container.dart';
import 'package:trip_flutter/widget/local_nav_widget.dart';

import '../util/navigator_util.dart';
import '../widget/banner_widget.dart';
import '../widget/sales_box_widget.dart';
import '../widget/search_bar_widget.dart';
import '../widget/sub_nav_widget.dart';

const searchBarDefaultText = '网红打卡地 景点 酒店 美食';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//常驻内存
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  static Config? configModel;
  // final bannerList= [
  //   "https://img2.baidu.com/it/u=870551452,2266026462&fm=253&fmt=auto&app=138&f=JPEG?w=1133&h=500",
  //   "https://img1.baidu.com/it/u=914096420,1112170026&fm=253&fmt=auto&app=138&f=JPEG?w=1280&h=467",
  //   "https://img1.baidu.com/it/u=3692249836,3777214708&fm=253&fmt=auto&app=138&f=JPEG?w=1201&h=500",
  //   "https://img2.baidu.com/it/u=1966261153,1356293834&fm=253&fmt=auto&app=138&f=JPEG?w=1333&h=500",
  // ];
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  GridNav? gridNavModel;
  SalesBox? salesBoxModel;
  bool isLoading = true;

  static const appbarScrollOffset = 100;
  get _logoutBtn => ElevatedButton(
      onPressed: () {
        LoginDao.logout();
      },
      child: const Text("退出登录"));
  double appBarAlpha = 0;
  get _appBar {
    //获取刘海屏的实际的topPadding
    double top = MediaQuery.of(context).padding.top;
    return Column(
      children: [
        shadowWrap(
            child: Container(
              padding: EdgeInsets.only(top: 60+top),
              decoration: BoxDecoration(
                color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
              ),
              child: SearchBarWidget(
                searchBarType: appBarAlpha > 0.2
                    ? SearchBarType.homeLight
                    : SearchBarType.home,
                defaultText: searchBarDefaultText,
                inputBoxClick: () {
                  NavigatorUtil.push(context, const SearchPage());
                },
                rightButtonClick: () {
                  LoginDao.logout();
                },
              ),
          ),
        ),
        // buttom line
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 0.5)
              ]
          ),
        )
      ],
    );
  }

  get _listView => ListView(
        children: [
          BannerWidget(bannerList: bannerList),
          LocalNavWidget(localNavList: localNavList),
          if (gridNavModel != null) GridNavWidget(gridNavModel: gridNavModel!),
          if (subNavList != null) SubNavWidget(subNavList: subNavList),
          if(salesBoxModel!=null) SalesBoxWidget(salesBox: salesBoxModel!),
          // _logoutBtn,
          // const SizedBox(
          //   height: 800,
          //   child: const Text("首页内容"),
          // )
        ],
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    NavigatorUtil.updateContext(context);
    return Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: RefreshIndicator(
          color: Colors.blue,
          onRefresh: _handleRefresh,
          child: LoadingContainer(
            isLoading: isLoading,
            child: Stack(
              children: [
                _getListView(),
                _appBar,
              ],
            ),
          ),
    ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void _onScroll(double pixels) {
    print('pixels:$pixels');
    double alpha = pixels / appbarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    print('alpha:$alpha');
    setState(() {
      appBarAlpha = alpha;
    });
  }

  Future<void> _handleRefresh() async {
    try {
      HomeModel? result = await HomeDao.fetch();
      debugPrint(result.toString() + 'EEEEEEEEE');
      setState(() {
        configModel = result?.config ?? Config();
        bannerList = result?.bannerList ?? [];
        localNavList = result?.localNavList ?? [];
        subNavList = result?.subNavList ?? [];
        gridNavModel = result?.gridNav;
        salesBoxModel = result?.salesBox;
      });
    } catch (e) {
      debugPrint(e.toString() + 'sssssss===========???');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getListView() {
    return MediaQuery.removePadding(
        // 去除顶部padding(留白）
        context: context,
        removeTop: true,
        child: NotificationListener(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification &&
                scrollNotification.depth == 0) {
              _onScroll(scrollNotification.metrics.pixels);
            }
            return false; // 只是监听不消费它
          },
          child: _listView,
        )
    );
  }
}
