

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:trip_flutter/model/travel_tab_model.dart';

import '../dao/tralel_dao.dart';

class TravelTabController extends GetxController {
  final String groupChannelCode;
  TravelTabController(this.groupChannelCode);
  // 创建变量，用于存储数据监控变化
  final travelItems = <TravelItem>[].obs;
  final loading = true.obs;
  int pageIndex = 1;
  int pageSize = 10;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    loadData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          pageIndex <= 10) {
        loadData(loadMore: true);
        pageIndex++;
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  Future<void> loadData({loadMore = false}) async {
    try {
      TravelTabModel? model =
          await TravelDao.getTravels(groupChannelCode, pageIndex, pageSize);
      List<TravelItem> items = _filterItems(model?.list);
      if(!loadMore){
        travelItems.clear();
      }
      travelItems.addAll(items);
      loading.value = false;
    } catch (e) {
      debugPrint('${e}'); //打印错误

      loading.value = false;
    }
  }

  List<TravelItem> _filterItems(List<TravelItem>? list) {
    if (list == null) {
      return [];
    }
    List<TravelItem> items = [];
    list.forEach((item) {
      if (item.article != null) {
        items.add(item);
      }
    });
    return items;
  }
}
