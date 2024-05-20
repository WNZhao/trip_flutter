import 'package:flutter/material.dart';

/// 定义searchBar的三种状态
/// home 首页默认状态下使用
/// homeLight 首页搜索框输入文字后的状态
/// normal 其他页面的搜索框状态
enum SearchBarType { home, homeLight, normal }

class SearchBarWidget extends StatefulWidget {
  // 是否隐藏左侧按钮
  final bool? hideLeft;
  // 搜索框类型
  final SearchBarType searchBarType;
  // 搜索框的提示文字
  final String? hint;
  // 默认内容
  final String? defaultText;
  // 左侧点击的回调
  final void Function()? leftButtonClick;
  // 右侧点击的回调
  final void Function()? rightButtonClick;
  // 搜索框点击的回调
  final void Function()? inputBoxClick;
  // 搜索框内容改变的回调
  final ValueChanged<String>? onChanged;

  const SearchBarWidget(
      {super.key,
      this.hideLeft,
      this.searchBarType = SearchBarType.normal,
      this.hint,
      this.defaultText,
      this.leftButtonClick,
      this.rightButtonClick,
      this.inputBoxClick,
      this.onChanged});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  Widget get _normalSearchBar => Row(
        children: [
          _wrapTap(
              Padding(
                padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
                child: _backBtn,
              ),
              widget.leftButtonClick ?? () {}),
          // 搜索输入框
          Expanded(
            flex: 1,
            child: _inputBox,
          ),
          _wrapTap(
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  '搜索',
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                ),
              ),
              widget.rightButtonClick ?? () {})
        ],
      );

  get _backBtn => widget.hideLeft ?? false
      ? null
      : Icon(
          Icons.arrow_back_ios,
          color: Colors.grey,
          size: 26,
        );

  get _inputBox {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }
    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(
            widget.searchBarType == SearchBarType.normal ? 5 : 15),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal
                ? Color(0xffA9A9A9)
                : Colors.blue,
          ),
          Expanded(child: _textField),
          // todo 清除按钮
          if (showClear) _wrapTap(Icon(Icons.clear,size: 22,color: Colors.grey,), () {
            setState(() {
              _controller.clear();
            });
            _onChanged('');
          })
        ],
      ),
    );
  }

  // 主页搜索框样式
  get _homeSearchBar => Row(children: [
        // 左边显示城市
        _wrapTap(
            Container(
              padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
              child: Row(
                children: [
                  Text(
                    '北京',
                    style: TextStyle(color: _homeFontColor, fontSize: 14),
                  ),
                  Icon(
                    Icons.expand_more,
                    color: _homeFontColor,
                    size: 22,
                  )
                ],
              ),
            ),
            widget.leftButtonClick ?? () {}),
        // 输入框
        Expanded(child: _inputBox),
        // 右侧按钮
        _wrapTap(
            Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  '登出',
                  style: TextStyle(color: _homeFontColor, fontSize: 16),
                )),
            widget.rightButtonClick ?? () {})
      ]);

  get _homeFontColor => widget.searchBarType == SearchBarType.homeLight
      ? Colors.black54
      : Colors.white;
  // 输入框
  get _textField => widget.searchBarType == SearchBarType.normal
      ? TextField(
          controller: _controller,
          onChanged: _onChanged,
          autofocus: true,
          cursorColor: Colors.blue,
          cursorHeight: 20,

          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w300),
          // 输入框文本样式
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 5, bottom: 12, right: 5),
              border: InputBorder.none,
              hintText: widget.hint ?? '',
              hintStyle: TextStyle(fontSize: 16)),
        )
      : _wrapTap(
          Container(
            child: Text(
              widget.defaultText ?? '',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
          widget.inputBoxClick ?? () {});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _normalSearchBar
        : _homeSearchBar;
  }

  _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: callback,
      child: child,
    );
  }

  void _onChanged(String value) {
    if (value.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }
}
