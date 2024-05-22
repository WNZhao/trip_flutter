import 'package:flutter/material.dart';
import 'package:trip_flutter/util/navigator_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// h5的webview页面
class HiWebView extends StatefulWidget {
  final String? url;
  final String? statusBarColor;
  final String? title;
  final bool? hideAppBar;
  final bool? backForbid;
  //禁止我的页面返回按钮
  const HiWebView(
      {super.key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid});

  @override
  State<HiWebView> createState() => _HiWebViewState();
}

class _HiWebViewState extends State<HiWebView> {
  final _catchUrls = [
    'm.ctrip.com/',
    'm.ctrip.com/html5/',
    'm.ctrip.com/html5'
  ];
  String? url;
  late WebViewController _webviewController;

  _appBar(Color backgroundColor, Color backButtonColor) {
    double top = MediaQuery.of(context).padding.top;
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: top,
      );
    }

    return Container(
        color: backgroundColor,
        padding: EdgeInsets.fromLTRB(0, top, 0, 0),
        child: FractionallySizedBox(
            widthFactor: 1,
            child: Stack(
              children: [_backButton(backButtonColor), _title(backButtonColor)],
            )));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = widget.url;
    if (url != null && url!.contains('ctrip.com')) {
      //防止页面跳转到ctrip.com
      url = url!.replaceAll('https://', 'https://');
      url = url!.replaceAll('http://', 'http://');
    }
    _initWebViewController();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }
    return PopScope(
       canPop: false, // 禁止返回
        onPopInvoked: (bool didPop) async { // 物理返回键的处理
          if (await _webviewController.canGoBack()) {
            _webviewController.goBack();
          } else {
           if(context.mounted) NavigatorUtil.pop(context);
          }
        },
        child: Scaffold(
      body: Column(
        children: [
          _appBar(Color(int.parse('0xff$statusBarColorStr')), backButtonColor),
          Expanded(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            child: WebViewWidget(
              controller: _webviewController,
            ),
          ))
        ],
      ),
    ));
  }

  void _initWebViewController() {
    // 两个点，对象初始化的时候可以直接调用它的方法
    _webviewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          _webviewController
              .runJavaScript('console.log("Page loaded completely");');
          //页面加载完成之后，可以调用js方法
          // 处理返回键
          _handleBackForbid();
          print('Page finished loading: $url');
        },
        onWebResourceError: (WebResourceError error) {
          print('Page error: ${error.description}');
        },
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
          // if(_isToMain(request.url)) {
          //   debugPrint('组织跳转到 ${request.url}');
          //   print('blocking navigation to $url');
          //   NavigatorUtil.pop(context);
          //   return NavigationDecision.prevent;
          // }
          // //允许页面导航
          // print('Page navigation: ${request.url}');
          // return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(url!));
  }
  /// 隐藏H5登录页的返回键
  void _handleBackForbid() {
    const jsStr = 'element = document.querySelector(".animationComponent.rn-view");if(element && element.style)element.style.display = "none";';
    if(widget.backForbid ?? false) {
      _webviewController.runJavaScript(jsStr);
    }
  }

  /// 判断h5是否返回主页
  bool _isToMain(String url) {
    bool contain = false;
    for (final value in _catchUrls) {
      if (url.contains(value)) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  _backButton(Color backButtonColor) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Icon(
          Icons.close,
          color: backButtonColor,
          size: 26,
        ),
      ),
    );
  }

  _title(Color backButtonColor) {
    return Positioned(
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          widget.title ?? '',
          style: TextStyle(color: backButtonColor, fontSize: 20),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_webviewController != null) {
      _webviewController.clearCache();
    }
  }
}
