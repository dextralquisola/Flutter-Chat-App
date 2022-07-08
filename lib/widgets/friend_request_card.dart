import 'package:flutter/material.dart';

import '../model/friend.dart';
import '../service/friends_service.dart';

class FriendRequestCard extends StatelessWidget {
  final friendService = FriendService();
  final Friend friend;

  FriendRequestCard({
    Key? key,
    required this.friend,
  }) : super(key: key);

  void acceptFriend(String email, BuildContext context) {
    friendService.acceptFriend(email: email, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () => acceptFriend(friend.email, context),
              icon: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }
}
