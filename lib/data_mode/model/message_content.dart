import 'dart:convert' show json;
import 'dart:developer' as developer;

import 'message_model.dart';

class TextContent implements MessageContent {
  static const String objectName = 'TextMessage';
  //文本内容
  String content;
  //拓展内容
  Map extra;

  //提供默认的构造方法和map构造方法
  TextContent();
  TextContent.from(Map map)
      : content = map['content'],
        extra = map['extra'];

  @override
  void decode(String jsonStr) {
    if (jsonStr == null && jsonStr.isEmpty) {
      developer.log('Flutter TextMessage decode error: no jsonStr',
          name: objectName);
      return;
    }
    Map map = json.decode(jsonStr.toString());

    this.content = map['content'];
    this.extra = map['extra'];
  }

  @override
  String encode() {
    Map map = {'extra': this.extra};
    if (this.content != null) {
      map['content'] = this.content;
    }
    return json.encode(map);
  }

  @override
  String getObjectName() {
    return objectName;
  }

  @override
  Map toDataMap() {
    // TODO: implement toDataMap
    return null;
  }
}
