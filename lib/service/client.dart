import 'package:flutter_im_demo/service/http_util.dart';
import 'package:flutter_im_demo/service/websocket_util.dart';

import 'api_config.dart';

class Client {
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

  login({dynamic data}) {
    HttpUtil.dio.post(
      API.Login,
      data: {},
    );
  }
}
