import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trip_flutter/model/home_model.dart';
import 'package:trip_flutter/util/screen_adapter_helper.dart';

/// 封装的艺术之轮播图组件的实现

class BannerWidget extends StatefulWidget {
  final List<CommonModel> bannerList;
  const BannerWidget({super.key, required this.bannerList});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CarouselSlider(
            items: widget.bannerList.map((e) => _tabImage(e, width)).toList(),
            carouselController: _controller,
            options: CarouselOptions(
                height: 160.px,
                autoPlay: true,
                viewportFraction: 1.0,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  print("index:$index");
                  setState(() {
                    _current = index;
                  });
                })),
        // 需要通过positioned来定位
        Positioned(
          bottom: 10.px,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.bannerList.asMap().entries.map((e) {
              return GestureDetector(
                onTap: () {
                  _controller.animateToPage(e.key);
                },
                child: Container(
                  width: 8.px,
                  height: 8.px,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == e.key ? Colors.blue : Colors.grey,
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _tabImage(CommonModel model, double width) {
    return GestureDetector(
      onTap: () {
        print("点击了图片");
      },
      child: Image.asset( //改成asset
        model.icon ?? '',
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }
}
