import 'package:flutter/material.dart';

import '../model/home_model.dart';

/// 底部卡片入口

class SalesBoxWidget extends StatelessWidget {
  final SalesBox salesBox;
  const SalesBoxWidget({super.key, required this.salesBox});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.fromLTRB(7, 0, 7, 4),
      decoration: const BoxDecoration(
        color: Colors.white,
       
      ),
      child:_items(context),
    );
  }

  _items(BuildContext context) {
    List<Widget> items = []; 
    items.add(_doubleItem(context, salesBox.bigCard1, salesBox.bigCard2, true, false));
    items.add(_doubleItem(context, salesBox.smallCard1, salesBox.smallCard2, false, false));
    items.add(_doubleItem(context, salesBox.smallCard3, salesBox.smallCard4, false, true));
    return Column(
      children: [
        _titleItem(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(1, 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(2, 3),
        ),
      ],
    );
  }
  // 底部成对出现的卡片
  Widget _doubleItem(BuildContext context, CommonModel? leftCard, CommonModel? rightCard, bool isBig, bool isLast) {
     return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _item(context, leftCard, isBig, true, isLast),
        _item(context, rightCard, isBig, false, isLast),
      ],
    );
  }

  _item(BuildContext context, CommonModel? model, bool isBig, bool isLeft, bool isLast) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: isLeft ? BorderSide(color: Colors.white, width: 0.8) : BorderSide.none,
            bottom: isLast ? BorderSide.none : BorderSide(color: Colors.white, width: 0.8),
          ),
        ),
        child: Image.asset(
          model!.icon!,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width / 2 - 10,
          height: isBig ? 129 : 80,
        ),
      )
    );
  }

  _titleItem() {
    return Container(
      height: 40,
      margin: const EdgeInsets.fromLTRB(7, 4, 7, 0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xfff2f2f2), width: 1),
        ),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "images/热门活动.png",
            height: 20,
            fit: BoxFit.fill,
          ),
          _moreItem(),
        ],
      ),
    );
  }

  _moreItem() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 1, 8, 1),
      margin: const EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xffff4e63), Color(0xffff6cc9)]
          ,begin: Alignment.centerLeft, end: Alignment.centerRight,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          // 跳转到h5
        },
        child: const Text(
          '获取更多福利 >',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
