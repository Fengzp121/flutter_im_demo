import 'message_model.dart';

class ConversationModel {
  int conversationType;
  String targetId;
  int unreadCount;
  // int sendStatus;//待定
  int sendTime;
  bool isTop;
  // String objectName;//待定
  // String senderUserId;//从message中获取
  // int latestMessageId;//从message中获取
  MessageModel latestMessage;
  // int mentionedCount; // 会话中@消息的个数//TODO：后期做
  String draft = ''; //会话草稿内容

  ConversationModel.fromJson(Map map) {
    conversationType = map['conversationType'];
    targetId = map['targetId'];
    if (map['unreadCount'] != null) {
      unreadCount = map['unreadCount'];
    }
    sendTime = map['sendTime'];
    isTop = map['isTop'];
    latestMessage = MessageModel.fromJson(map['latestMessage']);
  }
}
