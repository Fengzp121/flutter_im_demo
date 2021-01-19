//消息方向
class MessageDirection {
  ///接收
  static const int RECEIVE = 1;

  ///发送
  static const int SEND = 2;
}

//消息状态
class MessageStatus {
  //未读，已发送之类的
  ///接收
  static const int RECEIVE = 1;

  ///发送
  static const int SEND = 2;

  ///发送失败
  static const int SENDFAIL = 3;

  ///接收失败
  static const int RECEIVEFAIL = 4;
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
