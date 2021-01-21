import 'package:flutter/material.dart';
import 'package:flutter_im_demo/page/login/login_page.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginInPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  IO.Socket socket = IO.io('http://localhost:3000');
  String currentMessage = '0';

  void _incrementCounter() {
    socket.emit('msg', 'test');
    setState(() {
      print('send:test');
      currentMessage = 'test';
    });
  }

  @override
  void initState() {
    socket.onConnect((_) {});
    super.initState();
    socket.on('event', (data) {
      print('receive:$data');
      setState(() {
        currentMessage = data;
      });
    });
  }

  @override
  void dispose() {
    socket.onDisconnect((_) => print('disconnect'));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'This is the current message:',
            ),
            Text(
              currentMessage,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'sendMsg',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
