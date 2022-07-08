import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';
import '../providers/user.dart';
import '../widgets/custom_text.dart';
import '../service/friends_service.dart';
import '../widgets/friend_request_card.dart';

class FriendRequestScreen extends StatefulWidget {
  const FriendRequestScreen({Key? key}) : super(key: key);

  @override
  State<FriendRequestScreen> createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  final emailController = TextEditingController();
  final friendService = FriendService();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50, bottom: 30),
              child: const AppText(
                text: 'Friend Requests',
                size: 24,
                color: Color(0xff0E1467),
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: userProvider.user.friendRequests.length,
                itemBuilder: (context, index) => FriendRequestCard(
                  friend: userProvider.user.friendRequests[index],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Enter User Email'),
                content: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                actions: [
                  TextButton(
                    child: const Text('Add Friend'),
                    onPressed: () async {
                      if (userProvider.isFriend(emailController.text)) {
                        setState(() {
                          Navigator.pop(context);
                        });
                        return showSnackBar(context, "Already Friends");
                      }

                      if (emailController.text.isEmpty) {
                        setState(() {
                          Navigator.pop(context);
                        });
                        return showSnackBar(context, "Put something first");
                      }

                      if (userProvider.user.email == emailController.text) {
                        setState(() {
                          Navigator.pop(context);
                        });
                        return showSnackBar(context, "You cant add yourself");
                      }

                      friendService.addFriend(
                          context: context, email: emailController.text);
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showDialogBox() {}
}
