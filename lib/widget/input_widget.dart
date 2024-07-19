import 'package:flutter/material.dart';
// 登录输入框 自定义widget
class InputWidget extends StatelessWidget {
  final String? hint;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  final TextInputType? keyboardType; // 键盘类型

  const InputWidget({super.key,  this.hint,  this.obscureText=false, this.onChanged, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _input(),
        Divider(color: Colors.white, height: 1,thickness: 0.5,)
      ],
    );
  }

  _input() {
    return TextField(
      onChanged: onChanged, // 监听输入
      obscureText: obscureText,
      keyboardType: keyboardType,
      autofocus: !obscureText, // 自动获取焦点
      cursorColor: Colors.white, // 光标颜色
      style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.w400),
      // 输入框的样式
      decoration:InputDecoration(
          border: InputBorder.none,
          hintText: hint??'',
          hintStyle: TextStyle(fontSize: 17,color: Colors.grey)),
    );
  }
}
