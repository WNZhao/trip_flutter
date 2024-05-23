import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/controller/travel_tab_controller.dart';
import 'package:trip_flutter/dao/tralel_dao.dart';
import 'package:trip_flutter/model/travel_tab_model.dart';
import 'package:trip_flutter/widget/loading_container.dart';
import 'package:trip_flutter/widget/travel_item_widget.dart';

/// 旅拍tab切换页面

class TravelTabPage extends StatefulWidget {
  final String groupChannelCode;

  const TravelTabPage({super.key, required this.groupChannelCode});

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage>
    with AutomaticKeepAliveClientMixin {
  late TravelTabController _travelTabController;

  get _gridView => MasonryGridView.count(
        controller: _travelTabController.scrollController,
        crossAxisCount: 2,
        itemBuilder: (BuildContext context, int index) => TravelItemWidget(
          item: _travelTabController.travelItems[index],
          index: index,
        ),
        itemCount: _travelTabController.travelItems.length,
      );
  /// obx不能嵌套
  /// 在使用obx,getx时，至少要在obx和getx节点下插入一个响应式的变量，否则会报错
  get _obx => Obx(()=>LoadingContainer(
        isLoading: _travelTabController.loading.value,
        child: RefreshIndicator(
            color: Colors.blue,
            onRefresh: _handleRefresh,
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: _gridView,
            )),
      ),);
  // 使用GetX 与 getObx等价 和obx不同的是，getx通常监听1个GetxController，而obx可以监听多个
  get _getx => GetX<TravelTabController>(builder: (controller) {
        return LoadingContainer(
          isLoading: controller.loading.value,
          child: RefreshIndicator(
              color: Colors.blue,
              onRefresh: _handleRefresh,
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: _gridView,
              )),
        );
      },init: _travelTabController,);

  @override
  void initState() {
    // 为每一个travelTap创建单独的controller,所以要给它添加一个tag,
    _travelTabController = Get.put(TravelTabController(widget.groupChannelCode),
        tag: widget.groupChannelCode);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //AutomaticKeepAliveClientMixin需要调用super.build
    return Scaffold(
      body: _obx,//_getx,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future<void> _handleRefresh() async {
    /// 更新状态
    await _travelTabController.loadData();
    return;
  }
}
