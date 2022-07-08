import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/chat.dart';
import '../model/user.dart';
import '../providers/chat.dart';
import '../providers/user.dart';
import './socket_client.dart';

class SocketFunctions {
  final _socketClient = SocketClient.instance.socket!;

  void friendListener(BuildContext context) {
    _socketClient.on('friend-request', (data) {
      Provider.of<UserProvider>(context, listen: false)
          .setUserFromModel(User.fromMap(data));
    });
  }

  void messageListener(BuildContext context) {
    _socketClient.on('message', (data) {
      Provider.of<ChatProvider>(context, listen: false).newMessage(
        Chat.fromJson(data),
      );
    });
  }

  void sendMessage(String message, String sender, User user) {
    _socketClient.emit(
      'message',
      {
        'message': message,
        'sender': sender,
      },
    );
  }
}
