import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_im_demo/data_mode/message_model.dart';
import 'package:flutter_im_demo/style/common_marcos.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//先用整表的思路做一遍，再用分表的做一遍
class SqlfiteUtil {
  //shareInstance
  factory SqlfiteUtil() => _getInstance();
  static SqlfiteUtil get instance => _getInstance();
  static SqlfiteUtil _instance;
  Database db;
  String _dbPath;

  static const String messageTableName = 'messageTable';
  static const String conversationTableName = 'conversationTable';
  static const String userInfoTableName = 'userInfoTable';

  SqlfiteUtil._internal() {
    // 初始化
  }
  static SqlfiteUtil _getInstance() {
    if (_instance == null) {
      _instance = SqlfiteUtil._internal();
    }
    return _instance;
  }

  ///这db是根据用户标示创建的[dbName]就是userId
  openDatabase(String dbName) async {
    //初始话数据库
    _dbPath = await _initDeleteDb(dbName);
    //打开数据库
    db = await openDatabase(_dbPath);
    //先检查表是否存在，再创建表
    if (!await _tableExists(messageTableName)) {
      await _createMessageTable(messageTableName);
      await _createMessageIndex();
    }
    if (!await _tableExists(conversationTableName)) {
      await _createConversationTable(conversationTableName);
    }
    if (!await _tableExists(userInfoTableName)) {
      await _createUserInfoTable(userInfoTableName);
    }
  }

  Future dropTable(String tableName) async {
    await db.execute('drop table $tableName');
  }

  Future insertQueryRow(List<MessageModel> msgs) async {
    //这里要用事务、或者批量
    var batch = db.batch();
    for (var msg in msgs) {
      //对content进行打包操作。
      batch.rawInsert(
          'insert into  Chat_${msg.conversationId} ' +
              '(tableVer,msgSvrID,createTiem,message,status,imageStatus,type,des)' +
              'VALUES (?,?,?,?,?,?,?,?,?)',
          [
            1,
            msg.msgId,
            msg.time,
            msg.content,
            msg.status,
            msg.messageType == MessageType.IMAGE ? 1 : 0,
            msg.messageType,
            msg.direction
          ]);
    }

    try {
      batch.commit(noResult: true);
    } catch (e) {
      debugPrint('sqflite_util \n insertQueryRow-throw error:\n $e \n');
    }
  }

  Future<List<Map<String, dynamic>>> selectAllChat() async {
    return await db.rawQuery(
        'select name from sqlite_master where type = \'table\' name like \'Chat_\'');
    // _db.rawQuery('select * from Chat order by createTime ASC');
  }

  Future updateRow() async {}

  Future deleteRow() async {}

//----------------------------------private function----------------------------------

  //一个用户创建一个本地数据库路径
  Future<String> _initDeleteDb(String dbName) async {
    final databasePath = await getDatabasesPath();
    print(databasePath);
    final path = join(databasePath, dbName);

    // make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      //如果出现重复的database，就gg
      return path;
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }
    return path;
  }

  Future<bool> _tableExists(String tableName) async {
    List tableMap = await db.rawQuery(
        'select [sql] from sqlite_master where [type] = \'table\' and lower(name) = ?',
        [tableName]);
    return tableMap.length > 0;
  }

  ///创建存储信息的表，需要设置索引
  Future _createMessageTable(String name) async {
    await db.execute('CREATE TABLE $name (' +
        'msgSvrID INTEGER, ' + //服务器的messageId
        'convasertionId INTEGER' + //聊天会话id
        'createTime INTEGER, ' + //创建时间
        'message TEXT, ' + //这里使用text主要是我也不知道。。。。
        'status INTEGER, ' + //消息的状态
        'imgStatus INTEGER, ' + //如果是图片的话，还有有一个这个状态
        'type INTEGER, ' + //消息的类型
        'des INTEGER)'); //消息的方向
  }

  Future _createMessageIndex() async {
    await db.execute('create index ');
  }

  ///创建聊天列表的表
  Future _createConversationTable(String name) async {
    await db.execute('CREATE TABLE $name (' +
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

  ///创建通讯录的表
  Future _createUserInfoTable(String name) async {
    await db.execute('CREATE TABLE $name (' +
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
}

// 分表的写法
// Future _createMessageTable(String name) async {
//     await db.execute('CREATE TABLE Chat_$name (' +
//         'tableVer INTEGER' +
//         'msgLocalID INTEGER PRIMARY KEY AUTOINCREMENT,' +
//         'msgSvrID TEXT, ' +
//         'createTime INTEGER, ' +
//         'message TEXT, ' +
//         'status INTEGER, ' +
//         'imgStatus INTEGER, ' +
//         'type INTEGER, ' +
//         'des INTEGER)');
//   }
