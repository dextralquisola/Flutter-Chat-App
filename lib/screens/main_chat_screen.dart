import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/friend.dart';
import '../providers/user.dart';
import '../widgets/custom_texfield.dart';
import '../widgets/custom_text.dart';
import '../widgets/user_chat_card.dart';

class MainChatScreen extends StatefulWidget {
  const MainChatScreen({Key? key}) : super(key: key);

  @override
  State<MainChatScreen> createState() => _MainChatScreenState();
}

class _MainChatScreenState extends State<MainChatScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserProvider>(context).user;
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50, bottom: 30),
                child: AppText(
                  text: 'Chats ${userData.name}',
                  size: 24,
                  color: const Color(0xff0E1467),
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomTextField(
                hintText: 'Search',
                controller: searchController,
                prefixIcon: Icons.search,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: userData.friends.length,
                  itemBuilder: (context, index) {
                    return UserChatCard(
                      chatId: userData.friends[index]['chatId'],
                      friend: userData.friends[index]['friend'] as Friend,
                      user: userData,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
