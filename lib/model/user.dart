import 'dart:convert';

import './friend.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String token;
  final List<Map<String, dynamic>> friends;
  final List<Friend> friendRequests;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.token,
    required this.friends,
    required this.friendRequests,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'token': token});
    result.addAll({'friends': friends});
    result.addAll(
        {'friendRequests': friendRequests.map((x) => x.toMap()).toList()});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
      friends: List<Map<String, dynamic>>.from(
        map['friends']?.map(
          (x) => Map<String, dynamic>.from(
            {
              'chatId': x['chatId'],
              'friend': Friend.fromMap(
                x['friend'],
              ),
            },
          ),
        ),
      ),
      friendRequests: List<Friend>.from(
          map['friendRequests']?.map((x) => Friend.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
