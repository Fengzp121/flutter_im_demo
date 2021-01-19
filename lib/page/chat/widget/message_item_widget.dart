import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../data_mode/model/message_model.dart';
import '../../../style/common_marcos.dart';
import '../../../base/utils/widget_util.dart';
import 'message_item_factory.dart';

class MessageItem extends StatelessWidget {
  final MessageModel message;
  MessageItem({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 5, 10, 5),
      child: _subMessage(),
    );
  }

  Widget _subMessage() {
    if (message.direction == MessageDirection.SEND) {
      //我发送的
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMessageItem(),
        ],
      );
    } else if (message.direction == MessageDirection.RECEIVE) {
      //我接收的
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              debugPrint('点击了头像');
            },
            child: WidgetUtil.buildUserPortrait(''),
          ),
          _buildMessageItem(),
        ],
      );
    } else {
      return WidgetUtil.buildEmptyWidget();
    }
  }

  Widget _buildMessageItem() {
    return Container(
      padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
      alignment: message.direction == MessageDirection.SEND
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: message.direction == MessageDirection.SEND
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[_buildNoramlItem()],
      ),
    );
  }

  _buildNoramlItem() {
    return Container(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (TapDownDetails details) {},
        onTap: () {
          print('点击了messageItem');
        },
        onLongPress: () {
          print('长按了messageItem');
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: MessageItemFactory(message: message),
        ),
      ),
    );
  }

//TODO要用别的方法来赋值这个东西
  // _buildCustomItem() {
  //   return ClipRRect(
  //     borderRadius: BorderRadius.circular(8),
  //     child: CustomItemFactory(model: message),
  //   );
  // }
}
