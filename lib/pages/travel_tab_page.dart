import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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

class _TravelTabPageState extends State<TravelTabPage> with AutomaticKeepAliveClientMixin {
  List<TravelItem> travelItems = [];
  int pageIndex = 1;
  int pageSize = 10;
  bool _loading = true;
  final ScrollController _scrollController = ScrollController();

  get _gridView => MasonryGridView.count(
        controller: _scrollController,
        crossAxisCount: 2,
        itemBuilder: (BuildContext context, int index) => TravelItemWidget(
          item: travelItems[index],
          index: index,
        ),
        itemCount: travelItems?.length ?? 0,
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && pageIndex<=10) {
        _loadData(loadMore: true);
        pageIndex++;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //AutomaticKeepAliveClientMixin需要调用super.build
    return Scaffold(
      body: LoadingContainer(
        isLoading: _loading,
        child: RefreshIndicator(
          color: Colors.blue,
          onRefresh: _loadData,
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: _gridView,
          )
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_scrollController != null) {
      _scrollController.dispose();
    }
  }

  Future<void> _loadData({loadMore = false}) async {
    try{
      TravelTabModel? model =  await TravelDao.getTravels(widget.groupChannelCode, pageIndex, pageSize);
      List<TravelItem> items = _filterItems(model?.list);
      setState(() {
        if (loadMore) {
          travelItems?.addAll(items);
        } else {
          travelItems = items;
        }
        _loading = false;
      });
    }catch(e){
      debugPrint('${e}'); //打印错误
      setState(() {
        _loading = false;
      });
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


}
