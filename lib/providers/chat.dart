import 'package:flutter/cupertino.dart';
import '../model/chat.dart';

class ChatProvider with ChangeNotifier {
  List<Chat> _chatData = [];

  List<Chat> get chats {
    return _chatData.reversed.toList();
  }

  void setChatFromJson(Map<String, dynamic> map) {
    _chatData = List<Chat>.from(
      map['chats']?.map(
        (e) => Chat.fromMap(e),
      ),
    );
    notifyListeners();
  }

  void newMessage(Chat chat) {
    _chatData.add(chat);
    notifyListeners();
  }
}
