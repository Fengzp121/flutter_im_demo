import 'package:flutter/material.dart';
import 'package:flutter_im_demo/base/utils/widget_util.dart';
import 'package:flutter_im_demo/data_mode/message_chat_list.dart';
import 'package:flutter_im_demo/page/chat/view_models/chat_list_viewmodels.dart';
import 'package:flutter_im_demo/service/client.dart';
import 'package:flutter_im_demo/service/sqflite_util.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widget/chat_list_item.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage>
    implements ConversationListItemDelegate {
  ChatListViewModel chatListViewModel;
  ScrollController _scrollController;

  @override
  void initState() {
    chatListViewModel = ChatListViewModel();
    //获取对话列表，并更新界面
    chatListViewModel.makeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ChatListPageTitle(),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Client.instance.createChatRoom();
              }),
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () async {
                List datas = await SqlfiteUtil.instance.selectAllChat();
                for (var item in datas) {
                  chatListViewModel.dataSource
                      .add(ConversationModel.fromJson(item));
                }
              })
        ],
      ),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => chatListViewModel,
          child: _buildListView(),
        ),
      ),
    );
  }

  _buildListView() {
    return Consumer<ChatListViewModel>(builder: (context, value, child) {
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: chatListViewModel.dataSource.length,
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (chatListViewModel.dataSource.length <= 0) {
            return WidgetUtil.buildEmptyWidget();
          }
          //return Container();
          return ConversationListItem(
              delegate: this,
              conversation: chatListViewModel.dataSource[index]);
        },
      );
    });
  }

  @override
  void didLongPressConversation(ConversationModel conversation, Offset tapPos) {
    // TODO: implement didLongPressConversation
  }

  @override
  void didTapConversation(ConversationModel conversation) {
    // TODO: implement didTapConversation
  }
}

class ChatListPageTitle extends StatefulWidget {
  @override
  _ChatListPageTitleState createState() => _ChatListPageTitleState();
}

class _ChatListPageTitleState extends State<ChatListPageTitle> {
  String titleStr = '我是标题';

  @override
  Widget build(BuildContext context) {
    //根据连接状态来改变
    return Container(
      child: Text(titleStr),
    );
  }
}
