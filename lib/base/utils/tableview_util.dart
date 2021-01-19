import 'package:flutter/material.dart';
import 'widget_util.dart';

//实现一个类似iOS TableView的控件。
//主要支持了section的操作
typedef int NumberOfRowsCallBack(int section);
typedef int NumberOfSectionCallBack();
typedef Widget SectionWidgetCallBack(int section);
typedef Widget RowsWidgetCallBack(int section, int row);

class FlutterSectionListView extends StatefulWidget {
  FlutterSectionListView(
      {this.numberOfRows,
      @required this.numberOfSection,
      this.sectionWidget,
      @required this.rowsWidget})
      : assert(!(numberOfSection == null || rowsWidget == null),
            'numberOfSection and rowWidget is null');

  final NumberOfRowsCallBack numberOfRows;
  final NumberOfSectionCallBack numberOfSection;
  final SectionWidgetCallBack sectionWidget;
  final RowsWidgetCallBack rowsWidget;

  @override
  _FlutterSectionListViewState createState() => _FlutterSectionListViewState();
}

class _FlutterSectionListViewState extends State<FlutterSectionListView> {
  //用来确定有多少个section
  List itemList = new List<int>();
  int itemCount = 0;
  int sectionCount = 0;

  @override
  void initState() {
    //从初始化数据中获取
    sectionCount = widget.numberOfSection();
    itemCount = listItemCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return buildItemWidget(index);
      },
      key: widget.key,
    );
  }

  int listItemCount() {
    //每次计算需要先清空之前的
    itemList.clear();
    int rowCount = 0;
    //将初始化的结果相对应的插入到数组中。
    //list的索引是section
    //list的value是没个section对应有多少个item
    for (int i = 0; i < sectionCount; i++) {
      int rows = widget.numberOfRows(i);
      rowCount += rows + 1;
      itemList.insert(i, rowCount);
    }
    return rowCount;
  }

  ///创建item
  Widget buildItemWidget(int index) {
    IndexPath indexPath = sectionModel(index);
    if (indexPath.row < 0) {
      return widget.sectionWidget != null
          ? widget.sectionWidget(indexPath.section)
          : WidgetUtil.buildEmptyWidget();
    } else {
      return widget.rowsWidget(indexPath.section, indexPath.row);
    }
  }

  ///创建indexPatch，根据[itemList]计算
  IndexPath sectionModel(int index) {
    int row = 0;
    int section = 0;
    for (int i = 0; i < sectionCount; i++) {
      int itemCount = itemList[i];
      //index是根据总数做划分的。
      //例如：
      //seciton:  0     1     2
      //rows   :  2     3     4
      //itemCount:3     7     12
      //index小于当前itemCount，就说明是位于哪个seciton
      if (index < itemCount) {
        //首先确定 i 不为0,不然数组越界，然后再减1为当前的row
        //减一是因为section也占用了一个item
        row = index - (i > 0 ? itemList[i - 1] : 0) - 1;
        section = i;
        //找到就跳出循环
        break;
      }
    }
    //正常情况下不会返回0，0。因为初始化的时候数据已经是对应了。
    return IndexPath(section: section, row: row);
  }
}

class IndexPath {
  IndexPath({this.section, this.row});
  int section = 0;
  int row = 0;
}
