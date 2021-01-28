import 'package:flutter_im_demo/service/http_util.dart';
import 'package:flutter_im_demo/service/sqflite_util.dart';
import 'package:flutter_im_demo/service/websocket_util.dart';

import 'api_config.dart';

class Client with _Http, _Sql, _SocketIO {
  factory Client() => _getInstance();
  static Client get instance => _getInstance();
  static Client _instance;

  Client._internal() {
    // 初始化
  }

  static Client _getInstance() {
    if (_instance == null) {
      _instance = Client._internal();
    }
    return _instance;
  }
}

mixin _Http {
  loginIn({dynamic data, Function succ, Function fail}) {
    HttpUtil.post(API.LoginIn, succ, errorCallback: fail, params: data);
  }

  loginOut({dynamic data, Function succ, Function fail}) {
    HttpUtil.post(API.LoginOut, succ, errorCallback: fail, params: data);
  }
}

mixin _Sql {}

mixin _SocketIO {}