import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/util/view_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../util/string_util.dart';
import '../widget/input_widget.dart';
import '../widget/loginbutton_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 是否启用登录按钮
  bool loginEnabled = false;
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [..._background(),_content()],
      ),
    );
  }

  _background() {
    return [
      // position 是配合stack使用的
      Positioned.fill(child: Image.asset("images/login-bg.jpg",fit: BoxFit.cover,)),
      // 设置背景色
      Positioned.fill(child: Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
      )),
    ];
  }
  _content(){
    return Positioned.fill(
      left: 25,
      right: 25,
      child: ListView(
        children:  [
          hiSpace(height: 100),
          Text("帐号密码登录",style: TextStyle(fontSize: 26,color: Colors.white),),
          hiSpace(height: 40),
          InputWidget(hint: "请输入用户名", onChanged: (value){
            username = value;
            _checkInput();
          }),
          hiSpace(height: 10),
          InputWidget(hint: "请输入密码", obscureText: true, onChanged: (value){
            password = value;
            _checkInput();
          }),
          hiSpace(height: 45),
          LoginButton("登录", enable: loginEnabled, onPressed: _login),
          hiSpace(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: ()=>_jumpRegistration()
              ,child: Text("还没有帐号？快去注册",style: TextStyle(fontSize: 14,color: Colors.white)
              ,)
            ,)
          )
        ],
    ),);
  }
  _checkInput(){
    bool enabled = false;
    if(isNotEmpty(username) && isNotEmpty(password)){
      enabled = true;
    }
    setState(() {
      loginEnabled = enabled;
      print('=======================loginEnabled: $loginEnabled');
    });
  }

 // 执行登录操作
  void _login() async {
   try {
     var result = await LoginDao.login(username: username!, password: password!);
     print('=======================result: $result');

   } catch (e) {
     print('=======================e: $e');
   }
  }

  _jumpRegistration() async {
  //   url_launcher.launch("https://www.baidu.com");
    Uri uri = Uri.parse('https://www.baidu.com');
    if(!await launchUrl(uri,mode:LaunchMode.externalApplication)){
      print('=======================url_launcher.launch error');
      throw 'Could not launch $uri';
    }

  }
}
