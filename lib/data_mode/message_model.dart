import 'package:flutter_im_demo/data_mode/message_content.dart';
import 'package:flutter_im_demo/style/common_marcos.dart';

class MessageModel {
  MessageModel(
      {this.msgId,
      this.content,
      this.messageType,
      this.direction,
      this.time,
      this.status,
      this.conversationId});

  MessageModel.fromJson(Map map) {
    conversationId = map['conversationId'] ?? '';
    msgId = map['msgId'];
    switch (messageType) {
      case MessageType.TEXT:
        content = TextContent.from(map['content']);
        break;
      default:
        content = MessageContent();
    }
    status = map['status'];
    messageType = map['messageType'];
    direction = map['direction'];
    time = map['time'];
  }

  //会话Id，也是接收者的id
  String conversationId;

  //消息对应的ID
  String msgId;

  //用户信息
  // UserInfo userInfo;

  //消息体，包含消息的主要内容
  MessageContent content;

  //消息类型
  int messageType;

  // 1:发的 2:接收的
  int direction;

  //发送时间,最好是时间戳
  int time;

  ///消息状态
  int status;

  ///发送者的Id
  String senderId;

  String toString() {
    return null;
  }
}

class MessageContent implements MessageCoding {
  //如果是IM的话比较需要这个类，可用来添加一些特殊属性或者附加属性。
  @override
  void decode(String jsonStr) {}

  @override
  String encode() {
    return null;
  }

  @override
  String getObjectName() {
    return null;
  }

  @override
  Map toDataMap() {
    return null;
  }
}

//解析方法，提供给message类去重写
abstract class MessageCoding {
  String encode() {
    return null;
  }

  String toString() {
    return null;
  }

  void decode(String jsonStr) {}

  String getObjectName() {
    return null;
  }
}
