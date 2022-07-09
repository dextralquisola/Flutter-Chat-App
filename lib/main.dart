import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/chat.dart';
import './providers/user.dart';
import './screens/home_screen.dart';
import './screens/login_screen.dart';
import './service/auth_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder(
        future: AuthService().fetchUserData(context: context),
        builder: (BuildContext context, AsyncSnapshot<String> snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snap.connectionState == ConnectionState.done) {
            if (snap.hasData && snap.data! == 'Valid Token') {
              return const HomeScreen();
            }
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
