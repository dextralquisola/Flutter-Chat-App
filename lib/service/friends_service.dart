import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/global_variables.dart';
import '../providers/user.dart';
import '../utils/http_error_handler.dart';
import '../utils/utils.dart';

class FriendService {
  addFriend({required String email, required BuildContext context}) async {
    try {
      var token = Provider.of<UserProvider>(context, listen: false).user.token;
      var res = await http.post(
        Uri.parse('$baseServerAdress/api/addfriend'),
        body: jsonEncode(
          {
            'email': email,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Friend request sent');
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  acceptFriend({required String email, required BuildContext context}) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      var res = await http.post(
        Uri.parse('$baseServerAdress/api/accept-friend'),
        body: jsonEncode(
          {
            'email': email,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Friend accepted');
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
