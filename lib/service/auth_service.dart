import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/global_variables.dart';
import '../model/user.dart';
import '../providers/user.dart';
import '../screens/home_screen.dart';
import '../utils/http_error_handler.dart';
import '../utils/utils.dart';

class AuthService {
  //sign up user

  void signUpUser({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        token: '',
        friends: [],
        friendRequests: [],
      );

      var res = await http.post(
        Uri.parse('$baseServerAdress/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account created! Please login to continue.');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      var res = await http.post(
        Uri.parse('$baseServerAdress/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          var prefs = await SharedPreferences.getInstance();
          var userProvider = Provider.of<UserProvider>(context, listen: false);

          userProvider.setUser(res.body);

          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => const HomeScreen(),
            ),
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<String> fetchUserData({
    required BuildContext context,
  }) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null || token == '') {
        prefs.setString('x-auth-token', '');
        return 'No Token Provided';
      }

      var tokenRes = await http.post(
        Uri.parse('$baseServerAdress/tokenIsValid'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
          "x-auth-token": token,
        },
      );

      var isTokenValid = jsonDecode(tokenRes.body);

      if (isTokenValid) {
        var userResponse = await http.get(
          Uri.parse('$baseServerAdress/api/user'),
          headers: <String, String>{
            "Content-Type": 'application/json; charset=UTF-8',
            "x-auth-token": token,
          },
        );

        Provider.of<UserProvider>(context, listen: false)
            .setUser(userResponse.body);

        return 'Valid Token';
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      return 'Error';
    }
    return 'Error';
  }
}
