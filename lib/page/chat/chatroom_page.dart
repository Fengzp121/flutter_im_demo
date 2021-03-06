import 'package:flutter/material.dart';
import 'package:flutter_im_demo/data_mode/message_model.dart';
import 'widget/message_list_widget.dart';
import 'widget/input_bar_widget.dart';

class ChatRoomPage extends StatefulWidget {
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage>
    implements MessageListDelegate, InputBarWidgetDelegate {
  InputBarWidget _inputBarWidget;
  MessageListWidget _messageListWidget;
  @override
  void initState() {
    _inputBarWidget = InputBarWidget(delegate: this);
    _messageListWidget = MessageListWidget(delegate: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('titleContent'),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              });
        }),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            SafeArea(
                child: Column(
              children: <Widget>[
                Flexible(
                    child: Column(
                  children: <Widget>[Flexible(child: _messageListWidget)],
                )),
                Container(
                  child: _inputBarWidget,
                ),
                // _getExtWidgets(),
              ],
            )),
          ],
        ),
      ),
    );
  }

  @override
  void didLongPressMessageItem(MessageModel message, Offset tapPos) {
    // TODO: implement didLongPressMessageItem
  }

  @override
  void didTapMessageItem(MessageModel message) {
    // TODO: implement didTapMessageItem
  }

  @override
  void clickExtButton() {
    // TODO: implement clickExtButton
  }

  @override
  void inputBarStatusChanged(InputBarStatus status) {
    // TODO: implement inputBarStatusChanged
  }

  @override
  void sendMessage(String message) {
    // TODO: implement sendMessage
  }
}
