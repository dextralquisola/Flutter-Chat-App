import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../providers/user.dart';
import '../utils/socket_client.dart';
import '../utils/socket_functions.dart';
import './friend_request_screen.dart';
import './main_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late io.Socket _socket;

  int pagesIndex = 0;
  final pages = [
    const MainChatScreen(),
    const FriendRequestScreen(),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userData = Provider.of<UserProvider>(context, listen: false).user;
      _socket = SocketClient(userData.email).socket!;

      final socketFunctions = SocketFunctions();
      socketFunctions.friendListener(context);
      socketFunctions.messageListener(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pagesIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) {
          setState(() => pagesIndex = newIndex);
        },
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.chat),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.person_add),
          ),
        ],
      ),
    );
  }
}
