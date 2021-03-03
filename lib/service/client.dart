import 'package:flutter_im_demo/service/http_util.dart';
import 'package:flutter_im_demo/service/sqflite_util.dart';
import 'package:flutter_im_demo/service/socket_io_util.dart';
import 'package:sqflite/sqflite.dart';

import 'api_config.dart';

//插入数据库的东西需要有一个记录，如果发生了插入失败之类的操作，需要记录下来id，下次拉取的时候再拉一次。
//但是这次获取的数据是不需要再插入到现有的聊天界面上的。
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

mixin _Sql {
  ///test code

  createChatRoom() async {
    await SqlfiteUtil.instance.openDatabase('ffzp');
    Batch batch = SqlfiteUtil.instance.db.batch();
    for (var i = 0; i < 20; i++) {
      batch.execute('CREATE TABLE Chat_$i (' +
          'tableVer INTEGER' +
          'msgLocalID INTEGER PRIMARY KEY AUTOINCREMENT,' +
          'msgSvrID TEXT, ' +
          'createTime INTEGER, ' +
          'message TEXT, ' +
          'status INTEGER, ' +
          'imgStatus INTEGER, ' +
          'type INTEGER, ' +
          'des INTEGER)');
    }
    batch.commit();
  }
}

mixin _SocketIO {}
