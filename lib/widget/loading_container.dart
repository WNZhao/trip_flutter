import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child; // 加载完成后显示的内容
  final bool isLoading; // 是否正在加载
  final bool cover; // 是否覆盖
  const LoadingContainer({super.key, required this.child, required this.isLoading,  this.cover=false});

  get _loadingView => Center(
        child: CircularProgressIndicator(color: Colors.blue,),
      );

  get coverView => Stack(
        children: [
          child,
          isLoading ? _loadingView : Container(),
        ],
      );

  get normalView => isLoading ? _loadingView : child;

  @override
  Widget build(BuildContext context) {
    return cover? coverView:normalView;
  }
}
