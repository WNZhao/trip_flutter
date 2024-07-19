import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/mvvm/login/controllers/controller.dart';
import 'package:trip_flutter/util/view_util.dart';
import 'package:trip_flutter/widget/input_widget.dart';
import 'package:trip_flutter/widget/login_widget.dart';

///登录页
class LoginPage extends GetView<LoginViewModel> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, //防止键盘弹起影响布局
      body: Stack(
        children: [..._background(), Obx(() => _content())],
      ),
    );
  }

  _background() {
    return [
      Positioned.fill(
          child: Image.asset(
        "images/login-bg.jpg",
        fit: BoxFit.cover,
      )),
      Positioned.fill(
          child: Container(
        decoration: const BoxDecoration(color: Colors.black54),
      ))
    ];
  }

  _content() {
    return Positioned.fill(
        left: 25,
        right: 25,
        child: ListView(
          children: [
            hiSpace(height: 100),
            const Text(
              "账号密码登录",
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
            hiSpace(height: 40),
            InputWidget(
              hint: "请输入用户名",
                onChanged: (text) =>
                    controller.onValueChanged(text, LoginInputType.username)),
            hiSpace(height: 10),
            InputWidget(
              hint: "请输入密码",
              obscureText: true,
              onChanged: (text) =>
                  controller.onValueChanged(text, LoginInputType.password),
            ),
            hiSpace(height: 45),
            LoginButton(
              "登录",
              enable: controller.loginEnable.value,
              onPressed: () => controller.login(),
            ),
            hiSpace(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () => controller.jumpRegistration(),
                child: const Text(
                  "注册账号",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }
}
