import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../providers/chat.dart';
import '../utils/http_error_handler.dart';
import '../constants/global_variables.dart';

class ChatService {
  fetchChats(BuildContext context, String token, String chatId) async {
    try {
      var res = await http.post(
        Uri.parse('$baseServerAdress/api/fetch-chats'),
        body: jsonEncode({
          'chatId': chatId,
        }),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
          "x-auth-token": token,
        },
      );

      final chatProvider = Provider.of<ChatProvider>(context, listen: false);
      chatProvider.setChatFromJson(json.decode(res.body));

      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          //showSnackBar(context, 'Connected');
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
