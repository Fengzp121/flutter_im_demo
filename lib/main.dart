import 'package:flutter/material.dart';
// import 'package:flutter_im_demo/page/login/login_page.dart';
import 'package:flutter_im_demo/page/tab/main_tab_page.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:aspectd/aspectd.dart';
import 'base/router/router.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  runApp(MyApp());
}

//TODO：埋点记录所有操作记录
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
      onGenerateRoute: onGenerateRoute,
      //home: MainTabPage(),
      home: MyHomePage(
        title: '尼玛没了',
      ),
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
  // IO.Socket socket = IO.io('ws://192.168.199.203:8080/Ws', <String, dynamic>{
  //   'transports': ['websocket'],
  // });
  IOWebSocketChannel channel;
  String currentMessage = '0';

  void _incrementCounter() {
    //socket.emit('msg', 'test msg');
    channel.sink.add('/fuck,fuck u!');
    setState(() {
      print('send:test');
      currentMessage = 'test';
    });
  }

  @override
  void initState() {
    _initSocket();
    // socket.onConnect((_) {});
    // socket.onConnectError((data) {
    //   print('connect-error:$data');
    // });
    // socket.onConnectTimeout((data) {
    //   print('onConnectTimeout:$data');
    // });
    // socket.onConnecting((data) {
    //   print('onConnecting:$data');
    // });
    // socket.onReconnect((data) {
    //   print('onReconnect:$data');
    // });
    // socket.onPing((data) {
    //   print('onPing:$data');
    // });
    // socket.onError((data) {
    //   print('error:$data');
    // });

    // socket.on('event', (data) {
    //   print('receive:$data');
    //   setState(() {
    //     currentMessage = data;
    //   });
    // });
    super.initState();
  }

  Future _initSocket() async {
    channel = IOWebSocketChannel.connect('ws://192.168.199.203:8080/Ws/10001');

    channel.stream.listen((message) {
      print(message);
    });
  }

  @override
  void dispose() {
    //socket.onDisconnect((_) => print('disconnect'));
    channel.sink.close(status.goingAway);
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
