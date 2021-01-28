import 'dart:io';
import 'package:flutter_im_demo/data_mode/message_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlfiteUtil {
  factory SqlfiteUtil() => _getInstance();
  static SqlfiteUtil get instance => _getInstance();
  static SqlfiteUtil _instance;
  Database _db;
  String _dbPath;

  SqlfiteUtil._internal() {
    // 初始化
  }

  static SqlfiteUtil _getInstance() {
    if (_instance == null) {
      _instance = SqlfiteUtil._internal();
    }
    return _instance;
  }

  //这db是根据用户标示创建的
  openDatabase(String dbName) async {
    _dbPath = await _initDeleteDb(dbName);
    _db = await openDatabase(_dbPath);
  }

  Future createTable(String chatRoomId) async {
    await _db.execute('CREATE TABLE Chat_$chatRoomId (' +
        'tableVer INTEGER' +
        'msgLocalID INTEGER PRIMARY KEY,' +
        'msgSvrID INTEGER, ' +
        'createTime INTEGER, ' +
        'message TEXT, ' +
        'status INTEGER, ' +
        'imgStatus INTEGER, ' +
        'type INTEGER, ' +
        'des INTEGER)');
  }

  Future insertRow(MessageModel messageModel) async {
    _db.rawInsert(
        'insert into  Chat_${messageModel.conversationId} ' +
            '(tableVer,msgLocalID,msgSvrID,createTiem,message,status,imageStatus,type,des)' +
            'VALUES (?,?,?,?,?,?,?,?,?)',
        messageModel.toString());
  }

  Future updateRow() async {}

  Future deleteRow() async {}

  //一个用户创建一个本地数据库路径
  /// dont delete the db, create the folder and returnes its path
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
}