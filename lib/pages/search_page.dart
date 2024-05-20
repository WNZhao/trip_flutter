
import 'package:flutter/material.dart';
import 'package:trip_flutter/util/navigator_util.dart';
import 'package:trip_flutter/util/view_util.dart';
import 'package:trip_flutter/widget/search_bar_widget.dart';
import 'package:trip_flutter/widget/search_item_widget.dart';

import '../dao/search_dao.dart';
import '../model/search_model.dart';

class SearchPage extends StatefulWidget {
  final bool? hideLeft;
  final String? keyword;
  final String? hint;

  const SearchPage({super.key, this.keyword, this.hint, this.hideLeft=false});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel? searchModel = SearchModel();
  String? keyword;

  get _appBar {
    // 获取刘海屏的实际的topPadding
    double top = MediaQuery.of(context).padding.top;
    return shadowWrap(
        child: Container(
          height: 55 + top,
          decoration: BoxDecoration(color: Colors.white),
          padding:  EdgeInsets.only(top: top),
          child: SearchBarWidget(
            hideLeft: widget.hideLeft,
            defaultText: widget.keyword,
            hint: widget.hint,
            leftButtonClick: ()=>NavigatorUtil.pop(context),
            onChanged: _onTextChange,
            rightButtonClick: (){
              FocusScope.of(context).requestFocus(FocusNode()); // 收起键盘
            },
          ),
        ),
        padding: const EdgeInsets.only(bottom: 5));
  }

  get _listView => MediaQuery.removePadding(
    removeTop: true,
      context: context,
      child: Expanded(
          child:ListView.builder(
              itemCount: searchModel?.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return _item(index);
              })
      )
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [_appBar, _listView]));
  }

  void _onTextChange(String value) async {
    try {

      SearchModel? response = await SearchDao.fetch(value);
      print("====================${response}");
      if (response != null) {
        // 只有当，当前输入的内容和服务端返回的内容一致时，才更新页面
        if(response.keyword == value){
          print('输入一致');
          setState(() {
            searchModel = response;
          });
        }

      }
    } catch (e) {
      print(e);
    }
  }

  Widget _item(int index) {
    var item = searchModel?.data?[index];
    if (item == null) return Container();
    print('====================${item.word} ${searchModel?.keyword}');
    return SearchItemWidget(searchItem: item, searchKeyWord: searchModel?.keyword);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.keyword!=null){
      _onTextChange(widget.keyword!);
    }
  }
}
