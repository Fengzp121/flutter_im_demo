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
  static const int SENDING = 11;

  ///发送
  static const int SEND = 12;

  ///发送失败
  static const int SENDFAIL = 13;

  ///未读
  static const int UNREAD = 21;

  ///已读
  static const int READED = 22;
}

///消息类型
class MessageType {
  ///文本
  static const int TEXT = 1019001;

  ///长对话
  static const int LONGTEXT = 1019002;

  ///知识库推荐
  static const int KNOWRECOMMEND = 1019003;

  ///知识库关联
  static const int KNOWUNION = 1019004;

  ///未知
  static const int UNKNOW = 1019099;
}
