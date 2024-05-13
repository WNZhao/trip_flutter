import 'package:trip_flutter/dao/login_dao.dart';

hiHeaders(){
  Map<String,String> headers = {
    'Content-Type': 'application/json',
    'charset': 'utf-8',
    'Accept': 'application/json'
  };
  var token = LoginDao.getToken();
  if(token != null) {
    headers['Authorization'] = 'Bearer ${token}';
  }

  return headers;
}