import 'package:flutter/material.dart';
import 'package:flutter_im_demo/base/utils/widget_util.dart';
import 'package:flutter_im_demo/page/chat/view_models/chat_list_viewmodels.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  ChatListViewModel chatListViewModel;
  ScrollController _scrollController;

  @override
  void initState() {
    chatListViewModel = ChatListViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('消息'),
      ),
      body: Container(
        child: SmartRefresher(
          controller: null,
          enablePullUp: true,
          header: MaterialClassicHeader(),
          onRefresh: () {},
          onLoading: () {},
          child: ChangeNotifierProvider(
            create: (_) => chatListViewModel,
            child: _buildListView(),
          ),
        ),
      ),
    );
  }

  _buildListView() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: chatListViewModel.dataSource.length,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index) {
        if (chatListViewModel.dataSource.length <= 0) {
          return WidgetUtil.buildEmptyWidget();
        }
        return Container();
        // return ConversationListItem(
        //     delegate: this, conversation: chatListViewModel.dataSource[index]);
      },
    );
  }
}
