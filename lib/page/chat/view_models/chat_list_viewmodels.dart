import 'package:flutter/material.dart';
import 'package:flutter_im_demo/base/utils/time_util.dart';
import 'package:flutter_im_demo/data_mode/message_chat_list.dart';

class ChatListViewModel extends ChangeNotifier {
  List<ConversationModel> dataSource;

  Future makeData() async {
    dataSource = List();
    print('makeData');

    //   int conversationType;
    // String targetId;
    // int unreadCount;
    // // int sendStatus;//待定
    // int sendTime;
    // bool isTop;
    // // String objectName;//待定
    // // String senderUserId;//从message中获取
    // // int latestMessageId;//从message中获取
    // MessageModel latestMessage;
    // // int mentionedCount; // 会话中@消息的个数//TODO：后期做
    // String draft = ''; //会话草稿内容
    await Future.delayed(Duration(seconds: 1));
    for (var i = 0; i < 10; i++) {
      Map params = {
        'conversationType': 1,
        'targetId': i.toString(),
        'unreadCount': 0,
        'sendTime': DateTime.now().millisecondsSinceEpoch,
        'isTop': false,
      };
      var model = ConversationModel.fromJson(params);
      dataSource.add(model);
    }
    notifyListeners();
  }
}
