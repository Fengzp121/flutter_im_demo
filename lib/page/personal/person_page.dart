import 'package:flutter/material.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Icon(Icons.ac_unit),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: _pushToSettingPage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(Icons.settings),
                Text('设置'),
              ],
            ),
          ),
          FlatButton(
            onPressed: _loginOut,
            child: Text('登出'),
          ),
        ],
      ),
    );
  }

  _pushToSettingPage() {}

  _loginOut() {}
}
