//消息方向
class MessageDirection {
  ///接收
  static const int RECEIVE = 1;

  ///发送
  static const int SEND = 2;
}

//消息状态
class MessageStatus {
  ///发送中
  static const int SENDING = 1;

  ///发送
  static const int SEND = 2;

  ///发送失败
  static const int SENDFAIL = 3;

  ///未读
  static const int UNREAD = 4;

  ///已读
  static const int READED = 5;
}

///消息类型
class MessageType {
  ///文本
  static const int TEXT = 1;

  ///图片
  static const int IMAGE = 3;

  ///语音
  static const int VOICE = 34;

  ///明信片
  static const int CARD = 42;

  ///大表情
  static const int BIGEMOTION = 47;

  ///定位
  static const int LOCAL = 48;

  ///拓展，各种乱七八糟的
  static const int EXT = 49;

  ///系统消息
  static const int SYS = 1000;
}
