import 'package:flutter/material.dart';

class LoginInPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginInPage> {
  Map selectAccount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            DropdownButton(
              items: [
                DropdownMenuItem(value: {}, child: Text('切图冯')),
                DropdownMenuItem(value: {}, child: Text('cto刁')),
                DropdownMenuItem(value: {}, child: Text('唐cto')),
              ],
              onChanged: (value) {
                selectAccount = value;
              },
            ),
            SizedBox(height: 200),
            FlatButton(
                onPressed: () {
                  //登录接口
                  //或者是建立连接
                },
                child: Text('登录'))
          ],
        ),
      ),
    );
  }
}
