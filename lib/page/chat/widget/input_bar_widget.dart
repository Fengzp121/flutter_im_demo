import 'package:flutter/material.dart';

class InputBarWidget extends StatefulWidget {
  InputBarWidget({this.delegate});

  final InputBarWidgetDelegate delegate;

  @override
  _InputBarWidgetState createState() => _InputBarWidgetState();
}

class _InputBarWidgetState extends State<InputBarWidget> {
  TextField textField;
  FocusNode focusNode = FocusNode(); //焦点
  InputBarStatus inputBarStatus; //输入框状态

  String message; //输入的消息
  bool isShowVoiceAction = false; //是否显示语音输入
  final controller = new TextEditingController();

  @override
  void initState() {
    this.inputBarStatus = InputBarStatus.Normal;
    this.textField = TextField(
      onSubmitted: _submitMessage,
      controller: controller,
      maxLines: 3,
      keyboardType: TextInputType.text,
      focusNode: focusNode,
      decoration: InputDecoration(
          border: InputBorder.none,
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          hintStyle: TextStyle(fontSize: 15)),
      onChanged: (text) {
        message = text;
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.mic), iconSize: 32, onPressed: _clickVoiceBtn),
          Expanded(child: _inputTextfield()),
          IconButton(
              icon: Icon(Icons.add),
              iconSize: 32,
              onPressed: _clickExpressionPckBtn),
          IconButton(
              icon: Icon(Icons.add), iconSize: 32, onPressed: _clickExtention)
        ],
      ),
    );
  }

  Widget _inputTextfield() {
    Widget widget;
    if (this.inputBarStatus == InputBarStatus.Voice) {
      widget = Container(
          alignment: Alignment.center,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Text('按住录音', textAlign: TextAlign.center),
            onLongPress: () {
              //_onVoiceLongPress();
            },
            onLongPressEnd: (LongPressEndDetails details) {
              //_onVoiceLongPressEnd();
            },
          ));
    } else {
      //这是正常布局
      widget = Container(
          margin: EdgeInsets.only(top: 8, bottom: 8),
          decoration: BoxDecoration(
              color: Colors.grey[100], borderRadius: BorderRadius.circular(5)),
          child: this.textField);
    }
    return widget;
  }

  _submitMessage(String msg) {
    if (msg.isEmpty && msg.length <= 0) {
      debugPrint('消息不能为空');
      return;
    }
    widget.delegate.sendMessage(msg);
    this.message = '';
    this.textField.controller.text = '';
  }

  _clickVoiceBtn() {
    debugPrint('点击了语音');
    InputBarStatus status = InputBarStatus.Normal;
    if (this.inputBarStatus != InputBarStatus.Voice) {
      status = InputBarStatus.Voice;
    }
    _notifyInputStatusChanged(status);
  }

  _clickExpressionPckBtn() {}

  _clickExtention() {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
    InputBarStatus status = InputBarStatus.Normal;
    if (this.inputBarStatus != InputBarStatus.Ext) {
      status = InputBarStatus.Ext;
    }
    if (widget.delegate != null) {
      widget.delegate.clickExtButton();
    } else {
      debugPrint('没有实现 InputBarDelegate没实现');
    }
    _notifyInputStatusChanged(status);
  }

  void _notifyInputStatusChanged(InputBarStatus status) {
    this.inputBarStatus = status;
    if (widget.delegate != null) {
      widget.delegate.inputBarStatusChanged(status);
    } else {
      debugPrint("没有实现 BottomInputBarDelegate");
    }
  }
}

enum InputBarStatus {
  Normal, //正常文字输入
  Voice, //输入声音
  Ext //更多拓展
}

abstract class InputBarWidgetDelegate {
  void sendMessage(String message);
  void clickExtButton();
  void inputBarStatusChanged(InputBarStatus status);
}
