import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebSocketClient {
  factory WebSocketClient() => _getInstance();
  static WebSocketClient get instance => _getInstance();
  static WebSocketClient _instance;
  IO.Socket _socket;

  //FlutterAudioRecorder _recorder;
  WebSocketClient._internal() {
    // 初始化
  }

  static WebSocketClient _getInstance() {
    if (_instance == null) {
      _instance = WebSocketClient._internal();
    }
    return _instance;
  }

  init() {
    try {
      _socket = IO.io('http://localhost:3000');
      _socket.onConnect((data) => null);
      _socket.onConnectError((data) => null);
      _socket.onConnecting((data) => null);
      _socket.onError((data) => null);
      _socket.onConnectTimeout((data) => null);

      // _socket.onpacket(packet);

      _socket.onReconnect((data) => null);
      _socket.onReconnecting((data) => null);
      _socket.onReconnectAttempt((data) => null);
      _socket.onReconnectError((data) => null);
      _socket.onReconnectFailed((data) => null);
    } catch (e) {
      print('init socket error:$e');
    }
  }

  pushMessage() {
    //发送特定指令，让后台接收
    _socket.emit('/login', {'phone': '123457', 'password': '123'});
  }

  listenData() {
    //监听相关指令，
    _socket.on('event', (data) {
      print('receive:$data');
    });
  }
}
