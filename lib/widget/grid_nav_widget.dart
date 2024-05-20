import 'package:flutter/material.dart';
import 'package:trip_flutter/model/home_model.dart';

class GridNavWidget extends StatelessWidget {
  final GridNav gridNavModel;

  const GridNavWidget({super.key, required this.gridNavModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
        child: PhysicalModel(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          clipBehavior: Clip.antiAlias, // 抗锯齿
          child: Column(
            children: _gridNavItems(context),
          ),
        ));
  }

  ///从上往下添加3个导航条
  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    items.add(_gridNavItem(context, gridNavModel.hotel, true));
    items.add(_gridNavItem(context, gridNavModel.flight, false));
    items.add(_gridNavItem(context, gridNavModel.travel, false));
    return items;
  }

  // first是否是第一个
  Widget _gridNavItem(BuildContext context, Hotel? gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem?.mainItem));
    // 添加右侧的item
    items.add(_doubleItem(context, gridNavItem?.item1!, gridNavItem?.item2!));
    items.add(_doubleItem(context, gridNavItem?.item3!, gridNavItem?.item4!));
    // 左右排列的item
    List<Widget> expandItems = [];
    for (var item in items) {
      expandItems.add(Expanded(
        flex: 1,
        child: item,
      ));
    }
    Color startColor = Color(int.parse('0xff${gridNavItem?.startColor}'));
    Color endColor = Color(int.parse('0xff${gridNavItem?.endColor}'));
    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor, endColor]),
      ),
      child: Row(
        children: expandItems,
      ),
    );
  }

  // 左侧大卡片
  Widget _mainItem(BuildContext context, CommonModel? model) {
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(top: 8),

                alignment: AlignmentDirectional.center,
                child: Text(
                  model?.title ?? '',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),

                child: Image.asset(model?.url ?? '',
                    width: 88,
                    height: 54,
                    fit: BoxFit.contain
                ),
              ),
            )
          ],
        ),
        model);
  }

  /// 手势包裹器
  Widget _wrapGesture(BuildContext  context, Widget widget, CommonModel? model) {
    return GestureDetector(
      onTap: () {
        // NavigatorUtil.push(context, WebView(url: model.url, statusBarColor: model.statusBarColor, hideAppBar: model.hideAppBar));
      },
      child: widget,
    );
  }

  Widget _doubleItem(BuildContext context, CommonModel? topItem, CommonModel? bottomItem) {
    return Column(
      children: [
        Expanded(
          child: _item(context, topItem, true),
        ),
        Expanded(
          child: _item(context, bottomItem, false),
        )
      ],
    );
  }

  _item(BuildContext context, CommonModel? item1, bool bool) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                left: borderSide,
                bottom: bool ? borderSide : BorderSide.none)),
        child: _wrapGesture(
            context,
            Center(
              child: Text(
                item1?.title ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            item1),
      ),
    );
  }
}
