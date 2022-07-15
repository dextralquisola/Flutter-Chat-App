import 'package:flutter/material.dart';

import '../model/friend.dart';
import '../model/user.dart';
import '../screens/chat screens/chat_screen.dart';
import '../service/chat_service.dart';

class UserChatCard extends StatelessWidget {
  final String chatId;
  final Friend friend;
  final User user;
  const UserChatCard({
    Key? key,
    required this.friend,
    required this.chatId,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ChatService().fetchChats(context, user.token, chatId);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatScreen(friend: friend, chatId: chatId),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            color: Colors.white,
          ),
        ),
        elevation: 5,
        shadowColor: Colors.black54,
        child: ListTile(
          leading: const Icon(
            Icons.person,
            size: 50,
          ),
          title: Text(friend.name),
          subtitle: Row(
            children: const [
              Icon(
                Icons.check,
                size: 10,
              ),
              SizedBox(width: 3),
              Text('update soon'),
            ],
          ),
          trailing: const Text('12:59 pm'),
        ),
      ),
    );
  }
}
