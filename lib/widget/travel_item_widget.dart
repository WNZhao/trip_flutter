import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:trip_flutter/model/travel_tab_model.dart';

class TravelItemWidget extends StatelessWidget {
  final TravelItem item;
  final int? index;

  const TravelItemWidget({super.key, required this.item, this.index});

  get _itemTitle => Container(
    padding: EdgeInsets.all(5),
    child: Text(
      item.article?.articleTitle ?? '',
      style: TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    )
  );

  get _infoText => Container(
    padding:EdgeInsets.fromLTRB(6,0,6,10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 头像昵称
        _avatarNickName,
        // 点赞数
        _likeIcon
      ],
    ),
  );

  get _avatarNickName => Row(
    children: [
      PhysicalModel(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(12),
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: item.article?.author?.coverImage?.dynamicUrl ?? '',
          fit: BoxFit.cover,
          width: 24,
          height: 24,
        ),
      ),
      Container(
        padding: EdgeInsets.all(5),
        width: 90,
        child: Text(
          item.article?.author?.nickName ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );

  get _likeIcon => Row(
    children: [
      Icon(
        Icons.thumb_up,
        color: Colors.grey,
        size: 14,
      ),
      Container(
        padding: EdgeInsets.all(5),
        child: Text(
          item.article?.likeCount.toString() ?? '',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );

   _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children:[
        Container(
          /// 最小高度
          constraints: BoxConstraints(
            minHeight: size.width/2 -10,
          ),
          child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: item.article?.images?[0]?.dynamicUrl ?? '',
              fit: BoxFit.cover
          ),
        ),
        Positioned(child: Container(
          padding:EdgeInsets.fromLTRB(5,1,5,1),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.white,
                size: 12,
              ),
              LimitedBox(
                maxWidth: size.width/2 - 150,
                child: Text(
                  _poiName(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ))
      ]
    );
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        // todo
      },
      child: Card(
        child:PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _itemImage(context),
              _itemTitle,
              _infoText,
            ],
          ),
        )
      )
    );
  }

  String _poiName() {
    return item.article?.pois == null || item.article?.pois?.length == 0 ? '未知' : item.article?.pois?[0]?.poiName ?? '未知';
  }
}
