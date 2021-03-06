import 'package:socket_io_client/socket_io_client.dart' as io;

import '../constants/global_variables.dart';

class SocketClient {
  io.Socket? socket;
  late String email;
  static SocketClient? _instance;

  SocketClient._internal(String email) {
    socket = io.io(
      baseServerAdress,
      io.OptionBuilder()
          .setTransports(['websocket']).setQuery({'email': email}).build(),
    );
    //socket!.connect();

    socket!.onConnect((data) => print('Connection established'));
    socket!.onConnectError((data) => print('Connect Error: $data'));
    socket!.onDisconnect((data) => print('Socket.IO server disconnected'));
  }

  factory SocketClient(String email) {
    _instance = SocketClient._internal(email);
    return _instance!;
  }

  static SocketClient get instance {
    return _instance!;
  }
}
