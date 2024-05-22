import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/tralel_dao.dart';
import 'package:trip_flutter/pages/travel_tab_page.dart';
import 'package:underline_indicator/underline_indicator.dart';

import '../model/travel_category_model.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  List<TravelTab>? tabs = [];
  late TabController _controller;

  TravelCategoryModel? travelTabModel;

  get _tabBar => TabBar(
      controller: _controller,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.black,
      indicator: UnderlineIndicator(
          strokeCap: StrokeCap.round,
          borderSide: BorderSide(color: Color(0xff2fcfbb), width: 3),
          insets: EdgeInsets.only(bottom: 0)),
      tabs: (tabs ?? []).map<Tab>((TravelTab tab) {
        return Tab(text: tab.labelName);
      }).toList());

  get _tabBarView {
    return TabBarView(
        controller: _controller,
        children: (tabs ?? []).map<TravelTabPage>((TravelTab tab) {
          return TravelTabPage(groupChannelCode: tab.groupChannelCode);
        }).toList());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: tabs?.length ?? 0, vsync: this);
    TravelDao.getCategory().then((TravelCategoryModel? model) {
      // 重新给controller赋值
      _controller =
          TabController(length: model?.tabs?.length ?? 0, vsync: this);
      setState(() {
        tabs = model?.tabs ?? [];
        travelTabModel = model;
      });
    }).catchError((e) {
      debugPrint(e); //打印错误
    });
  }

  // 用到了controller在dispose的时候要释放
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 做一下刘海屏的适配
    double top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: top),
            child: _tabBar,
          ),
          Flexible(child: _tabBarView)
        ],
      ),
    );
  }
}
