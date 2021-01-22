import 'package:flutter/material.dart';
import 'package:flutter_im_demo/page/chat/chatroom_page.dart';
import 'package:flutter_im_demo/page/tab/main_tab_page.dart';

final routes = {
  '/': (ctx) => MainTabPage(),
  '/chatroom': (ctx, {arguments}) => ChatRoomPage(),
};

// ignore: top_level_function_literal_block
var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
