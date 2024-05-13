import 'package:flutter/material.dart';

// 带禁用功能的按钮
class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback onPressed;

  const LoginButton(this.title,
      {super.key, this.enable = true, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: enable?onPressed:null,
      disabledColor: Colors.white60,
      color: Colors.orange,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      height: 46,
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      )
    );
  }
}
