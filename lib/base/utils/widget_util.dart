import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../../style/style.dart';
import 'time_util.dart';

class WidgetUtil {
  /// 会话页面加号扩展栏里面的 widget，上面图片，下面文本
  static Widget buildExtentionWidget(
      String image, String text, Function() clicked) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            if (clicked != null) {
              clicked();
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
                width: MYLayout.ExtIconLayoutSize,
                height: MYLayout.ExtIconLayoutSize,
                color: Colors.white,
                child: Image.asset(
                  image,
                  width: MYFont.ExtIconSize,
                  height: MYFont.ExtIconSize,
                )),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(text, style: TextStyle(fontSize: MYFont.ExtTextFont))
      ],
    );
  }

  /// 用户头像
  static Widget buildUserPortrait({String path}) {
    Widget protraitWidget;
    if (path == null || path.isEmpty) {
      protraitWidget = Icon(Icons.error);
      //protraitWidget =
      //    Image.asset("images_chat/service_avatar.png", fit: BoxFit.fill);
    } else {
      if (path.startsWith("http")) {
        protraitWidget = CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: path,
        );
      } else {
        File file = File(path);
        if (file.existsSync()) {
          protraitWidget = Image.file(
            file,
            fit: BoxFit.fill,
          );
        }
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: MYLayout.ConListPortraitSize,
        width: MYLayout.ConListPortraitSize,
        child: protraitWidget,
      ),
    );
  }

  /// 消息 item 上的时间
  static Widget buildMessageTimeWidget(int sentTime) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
        width: MYLayout.MessageTimeItemWidth,
        height: MYLayout.MessageTimeItemHeight,
        color: Color(MYColor.MessageTimeBgColor),
        child: Text(
          TimeUtil.convertTime(sentTime),
          style:
              TextStyle(color: Colors.white, fontSize: MYFont.MessageTimeFont),
        ),
      ),
    );
  }

  static Widget buildReturnView(Widget title, Widget leading,
      {Widget trading}) {
    return Container(
        height: 44,
        width: window.physicalSize.width / window.devicePixelRatio,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: leading,
            ),
            Align(
              alignment: Alignment.center,
              child: title,
            )
          ],
        ));
  }

  /// 空白 widget ，用于处理非法参数时的占位
  static Widget buildEmptyWidget() {
    return Container(
      height: 1,
      width: 1,
    );
  }

  static Widget buildEmptyBoxed(double heigt) {
    return SizedBox(
      height: heigt,
    );
  }

  /// 一条线的widget
  static Widget buildLineWidget() {
    return Container(
      height: 1,
      color: Color(MYColor.LineWidgetlightGreyColor),
    );
  }

  /// 一条线的widget
  static Widget buildLineWithColorWidget(Color color) {
    return Container(
      height: 1,
      color: color,
    );
  }

  static Widget buildActionSheet(String title,
      {String confirmTitle, Function confirmAction, Function cancelAction}) {
    return CupertinoActionSheet(
      title: Text(title),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(
            confirmTitle,
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'PingFangRegular',
            ),
          ),
          onPressed: confirmAction,
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          '取消',
          style: TextStyle(
            fontSize: 13.0,
            fontFamily: 'PingFangRegular',
            color: const Color(0xFF666666),
          ),
        ),
        onPressed: cancelAction,
      ),
    );
  }
}
