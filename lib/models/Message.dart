import 'package:asr_chat/models/User.dart';

class Message {
  final User sender;
  final String
  time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  //final bool isLiked;
  //final bool unread;

  Message({
    required this.sender,
    required this.time,
    required this.text,
   // this.isLiked,
    //this.unread,
  });
}

// USERS
final User Alex = User(
  id: 0,
  name: 'Greg',
  imageUrl: 'assets/images/greg.jpg',
);
final User Stockton = User(
  id: 1,
  name: 'James',
  imageUrl: 'assets/images/james.jpg',
);