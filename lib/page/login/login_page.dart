import 'package:flutter/material.dart';
import 'package:flutter_im_demo/page/tab/main_tab_page.dart';

class LoginInPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginInPage> {
  String selectAccount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DropdownButton(
              items: [
                DropdownMenuItem(value: '冯小鹏', child: Text('切图冯')),
                DropdownMenuItem(value: '马飞飞', child: Text('cto刁')),
                DropdownMenuItem(value: '唐老总', child: Text('唐cto')),
              ],
              value: selectAccount,
              onChanged: (String value) {
                setState(() {
                  selectAccount = value;
                });

                print(value);
              },
            ),
            //SizedBox(height: 200),
            FlatButton(
                onPressed: () {
                  //登录接口
                  //或者是建立连接
                  //Navigator.popAndPushNamed(context, routeName)
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return MainTabPage();
                    },
                  ));
                },
                child: Text('登录'))
          ],
        ),
      ),
    );
  }
}
