import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/friend.dart';
import '../providers/chat.dart';
import '../providers/user.dart';
import '../utils/socket_client.dart';

class ChatScreen extends StatefulWidget {
  final Friend friend;
  final String chatId;
  const ChatScreen({
    Key? key,
    required this.friend,
    required this.chatId,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _socket = SocketClient.instance.socket!;

  final TextEditingController _messageInputController = TextEditingController();

  _sendMessage() {
    var dateString = DateTime.now().toIso8601String();
    _socket.emit('message', {
      'chatId': widget.chatId,
      'message': _messageInputController.text.trim(),
      'author': Provider.of<UserProvider>(context, listen: false).user.id,
      'timeStamp': dateString,
    });

    _messageInputController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  _connectSocket() {
    _socket.emit('join-chat', widget.chatId);
  }

  @override
  void initState() {
    super.initState();
    _connectSocket();
  }

  @override
  void dispose() {
    _messageInputController.dispose();
    _socket.emit('unsubscribe', widget.chatId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friend.name),
      ),
      body: Consumer<ChatProvider>(
        builder: (_, provider, __) => Column(
          children: [
            Expanded(
              child: ListView.separated(
                reverse: true,
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final message = provider.chats[index];
                  return Wrap(
                    alignment: message.author == userData.id
                        ? WrapAlignment.end
                        : WrapAlignment.start,
                    children: [
                      Card(
                        color: message.author == userData.id
                            ? Theme.of(context).primaryColorLight
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: message.author == userData.id
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(message.chat),
                              Text(
                                DateFormat('hh:mm a').format(
                                  DateTime.parse(message.timeStamp).toLocal(),
                                ),
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(
                  height: 5,
                ),
                itemCount: provider.chats.length,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageInputController,
                        decoration: const InputDecoration(
                          hintText: 'Type your message here...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_messageInputController.text.trim().isNotEmpty) {
                          _sendMessage();
                        }
                      },
                      icon: const Icon(Icons.send),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
