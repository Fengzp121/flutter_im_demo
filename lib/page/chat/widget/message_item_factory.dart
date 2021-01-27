import 'package:flutter/material.dart';
import 'package:flutter_im_demo/data_mode/message_content.dart';
import 'package:flutter_im_demo/data_mode/message_model.dart';
import 'package:flutter_im_demo/style/common_marcos.dart';

//消息生成工厂类，感觉可以用来只生成一些比较简单的message。
//例如，文字 、语音、图片、视频
class MessageItemFactory extends StatelessWidget {
  final String pageName = 'MessageItemFactory';
  final MessageModel message;
  const MessageItemFactory({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _getMessageBGColor(message.direction),
      child: messageItem(context),
    );
  }

  // ignore: missing_return
  Color _getMessageBGColor(int messageDirection) {
    switch (messageDirection) {
      case MessageDirection.RECEIVE:
        return Colors.white;
      case MessageDirection.SEND:
        return Colors.green[300];
      default:
    }
  }

  //根据messageTpye来区分类型
  // ignore: missing_return
  Widget messageItem(BuildContext context) {
    switch (message.messageType) {
      case MessageType.TEXT:
        return textMessageItem(context);
      // case MYMessageType.IMAGE:
      //   return imageMessageItem(context);
      // case MYMessageType.VIDEO:
      //   return videoMessageItem(context);
      // case MYMessageType.VOICE:
      //   return voiceMessageItem(context);
      default:
    }
  }

  Widget textMessageItem(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //如果是自己发送的，就item的宽度会更大一点。
    TextContent textContent = this.message.content;
    return Container(
      constraints: BoxConstraints(
        maxWidth: screenWidth - 150,
      ),
      padding: EdgeInsets.all(8),
      child: Text(
        textContent.content,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

// ----------以下暂时保留------------//
  // Widget imageMessageItem(BuildContext context) {
  //   ImageMessage imageMessage = message.messageBody;
  //   Widget widget;
  //   if (imageMessage.content != null && imageMessage.content.length > 0) {
  //     //content大概就是base64编码后的图片
  //     Uint8List bytes = base64.decode(imageMessage.content);
  //     widget = Image.memory(bytes);
  //     //下载这张图片到本地
  //   } else {
  //     //这个路径在messageBody中获取
  //     if (imageMessage.localUrl != null) {
  //       //使用后台返回的路径在本地检索是否存在
  //       String path =
  //           MediaUtil.instance.getCorrectedLocalPath(imageMessage.localUrl);
  //       File file = File(path);
  //       if (file != null && file.existsSync()) {
  //         widget = Image.file(file);
  //       } else {
  //         //不存在就加载网络图片
  //         widget = CachedNetworkImage(
  //           imageUrl: imageMessage.mThumbUrl,
  //           //加载转圈
  //           progressIndicatorBuilder: (context, url, progress) =>
  //               CircularProgressIndicator(value: progress.progress),
  //         );
  //       }
  //     } else {
  //       //如果localpath为空
  //       widget = CachedNetworkImage(
  //         imageUrl: imageMessage.mThumbUrl,
  //         //加载转圈
  //         progressIndicatorBuilder: (context, url, progress) =>
  //             CircularProgressIndicator(value: progress.progress),
  //       );
  //     }
  //   }
  //   return Container(
  //       constraints:
  //           BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 150),
  //       child: widget);
  // }

  // Widget videoMessageItem(BuildContext context) {
  //   return Container();
  // }

  // Widget voiceMessageItem(BuildContext context) {
  //   VoiceMessage voiceMessage = message.messageBody;
  //   List<Widget> list = new List();
  //   list.add(SizedBox(width: 6));
  //   if (message.direction == MessageDirection.SEND) {
  //     list.add(Text(
  //       voiceMessage.duration.toString() + "''",
  //       style: TextStyle(fontSize: MYFont.MessageTextFont),
  //     ));
  //     list.add(SizedBox(
  //       width: 20,
  //     ));
  //     list.add(Container(
  //       width: 20,
  //       height: 20,
  //       child: Image.asset(''),
  //     ));
  //   } else {
  //     list.add(Container(
  //       width: 20,
  //       height: 20,
  //       child: Image.asset(''),
  //     ));
  //     list.add(SizedBox(
  //       width: 20,
  //     ));
  //     list.add(Text(
  //       voiceMessage.duration.toString() + "''",
  //       style: TextStyle(fontSize: MYFont.MessageTextFont),
  //     ));
  //   }
  //   //根据长度变化一下控件长度
  //   double maxWidth = 15;
  //   double msgDuration = voiceMessage.duration.toDouble();
  //   if (msgDuration > 10) {
  //     maxWidth = 150;
  //   } else if (msgDuration < 3) {
  //     maxWidth = 45;
  //   } else {
  //     maxWidth *= msgDuration;
  //   }
  //   return Container(
  //     width: maxWidth,
  //     height: 44,
  //     child: Row(children: list),
  //   );
  // }
  // ----------暂时保留------------//
}
