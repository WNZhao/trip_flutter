import 'package:flutter/material.dart';

import '../model/home_model.dart';

class SubNavWidget extends StatelessWidget {
  final List<CommonModel>? subNavList;

  const SubNavWidget({super.key,  this.subNavList});

  @override
  Widget build(BuildContext context) {
    print('${subNavList!.length}');
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 0, 7, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding:  EdgeInsets.all(7),
        child: _items(context),
      ),
      );
  }

  _items(BuildContext context) {
    if(subNavList==null) return null;
    List<Widget> items = [];
    subNavList!.forEach((model) {
      items.add(_item(context, model));
    });
    // 计算出第一行显示的数量
    int separate = (subNavList!.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, subNavList!.length),
          ),
        )
      ]
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          print("点击了");
        },
        child: Column(
          children: [
            Image.asset(
              model.icon ?? '',
              width: 32,
              height: 32,
            ),
            Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                model.title ?? '',
                style: const TextStyle(fontSize: 12)
                ,)
              ,)
          ],
        ),
      ),
    );
  }
}
