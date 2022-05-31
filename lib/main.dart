import 'package:asr_chat/screens/messages/message_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:asr_chat/screens/messages/message_screen.dart';
import 'package:asr_chat/models/User.dart';

import 'models/Message.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final User Alex = User(
    id: 0,
    name: 'Alex',
    imageUrl: 'assets/images/greg.jpg',
  );
  final User Stockton = User(
    id: 0,
    name: 'Stockton',
    imageUrl: 'assets/images/james.jpg',
  );

  List<User> users = [
    User(
    id: 0,
    name: 'Alex',
    imageUrl: 'assets/images/greg.jpg',
  ),
    User(
    id: 0,
    name: 'Stockton',
    imageUrl: 'assets/images/james.jpg',
  )
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.cyan,
        accentColor: Color(0xFFFEF9EB),
      ),
      //home: MessagesScreen(user: Alex),
      home: MessagesScreenState(user: users[0], userList: users,),
    );
  }
}