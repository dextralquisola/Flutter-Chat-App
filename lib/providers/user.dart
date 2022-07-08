import 'package:flutter/material.dart';

import '../model/friend.dart';
import '../model/user.dart';

class UserProvider extends ChangeNotifier {
  var _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    token: '',
    friends: [],
    friendRequests: [],
  );

  User get user => _user;

  bool isFriend(String email) {
    for (var friend in _user.friends) {
      if ((friend['friend'] as Friend).email == email) {
        return true;
      }
    }
    return false;
  }

  void setUser(String user) {
    _user = User.fromJson(user);
    print(_user.token);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
