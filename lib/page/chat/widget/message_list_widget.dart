import 'package:flutter/material.dart';
import 'package:flutter_im_demo/page/chat/view_models/chatroom_viewmodels.dart';
import 'package:provider/provider.dart';
import '../../../data_mode/message_model.dart';
import '../../../base/utils/widget_util.dart';

import 'message_item_widget.dart';

class MessageListWidget extends StatefulWidget {
  final MessageListDelegate delegate;

  MessageListWidget({this.delegate});

  @override
  State<StatefulWidget> createState() {
    return _MessageListState(delegate);
  }
}

class _MessageListState extends State<MessageListWidget> {
  //ChatViewModels _chatViewModels;

  MessageListDelegate delegate;
  //List _messageDataSource = List();
  Map messageItems = Map();
  ScrollController _scrollController;
  double mPosition = 0;
  _MessageListState(MessageListDelegate delegate) {
    this.delegate = delegate;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // streamController.sink.close();
    super.dispose();
  }

  Widget build(BuildContext context) {
    this._scrollController = ScrollController(initialScrollOffset: mPosition);
    _addScroolListener();
    return Consumer<ChatRoomViewModel>(builder: (ctx, vm, child) {
      List<MessageModel> messageDataSource = vm.messageDataSource;
      if (messageDataSource == null) {
        messageDataSource = List();
      }
      return ListView.separated(
          key: UniqueKey(),
          shrinkWrap: true,
          //因为消息超过一屏，ListView 很难滚动到最底部，所以要翻转显示，同时数据源也要逆序
          reverse: true,
          controller: _scrollController,
          itemCount: messageDataSource.length,
          itemBuilder: (BuildContext context, int index) {
            if (messageDataSource.length != null &&
                messageDataSource.length > 0) {
              MessageModel tempMessage = messageDataSource[index];
              MessageItem item = MessageItem(message: tempMessage);
              //messageItems[tempMessage.msgId] = item;
              return item;
            } else {
              return WidgetUtil.buildEmptyWidget();
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 10,
              width: 1,
            );
          });
    });
  }

  void _addScroolListener() {
    _scrollController.addListener(() {
      //此处要用 == 而不是 >= 否则会触发多次
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {}
      mPosition = _scrollController.position.pixels;
    });
  }
}

abstract class MessageListDelegate {
  ///长按消息内容
  void didLongPressMessageItem(MessageModel message, Offset tapPos);

  ///单击消息内容
  void didTapMessageItem(MessageModel message);
}
