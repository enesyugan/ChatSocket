//import 'dart:html';

import 'dart:ffi';

import 'package:asr_chat/screens/messages/OwnMessage.dart';
import 'package:flutter/material.dart';
import 'package:asr_chat/models/Message.dart';
import 'package:asr_chat/models/User.dart';
//import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:toggle_switch/toggle_switch.dart';
//import 'package:socket_io_client/socket_io_client.dart' as IO;


class MessagesScreen extends StatelessWidget {
  User user;
  String selectedUser;
  //IO.Socket socket = null;
  bool sendButton = false;

  MessagesScreen({
    required this.user,
    this.selectedUser = "Alex",
  });

  @override
  void initstate(){
   // connect_socket();
  }

//  void connect_socket(){
//    this.socket = IO.io("http://192.21.23.3:5000", <String,dynamic>{
//      "transports": ["websocket"],
//      "autoConnect": false,
//    });
//    socket.connect;
//    socket.onConnect((data) => print("Connected"));
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(), //AppBar(title: Text(this.user.name,)),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height-140,
              child: ListView(
                shrinkWrap: true,
                children: [
                  OwnMessageCart(message: "1", time: "23:23",),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 55,
                    child: Card(
                      margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      color: Colors.grey,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          onChanged: (value){
                            if (value.length > 0){

                            }
                          },
                          decoration: InputDecoration(
                              hintText: "message to topside",
                            contentPadding: EdgeInsets.all(5),
                          ),
                        )
                    ),
                  ),

                CircleAvatar(),
              ],
            ),
            ),
          ],
        ),

    //  body: Column(
    //    children: <Widget>[
    //      Container(
    //        color: Colors.amber,
    //        height: 700,
    //      ),
    //      Text("adsasd"),
    //      Container(
    //        color: Colors.red,
    //        child:
    //        Text("222222"),
    //      )
//         Center(
//           text: Text("Welcome to GeeksforGeeks!!!",
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 40.0,
//             ),
//           ),
//         ),
//        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
            crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
            mainAxisSize: MainAxisSize.min,

            children: <Widget>[
              ToggleSwitch(
                initialLabelIndex: 0,
                totalSwitches: 2,
                activeBgColor: [Colors.green],
                minWidth: 160,
                labels: ['Alex', 'Stockton'],
                onToggle: (index) {
                  print('switched to: $index');
                  if(index==0){this.selectedUser="Alex";print(this.selectedUser);}
                  else{this.selectedUser="Stockton";print(this.selectedUser);}
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}


//class MessagesScreen extends StatelessWidget {
//  Duration duration = new Duration();
//  Duration position = new Duration();
//  bool isPlaying = false;
//  bool isLoading = false;
//  bool isPause = false;
//  @override
//  Widget build(BuildContext context) {
//    final now = new DateTime.now();
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("TEST"),
//      ),
//      body: Center(
//        child: SingleChildScrollView(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//
//              BubbleNormal(
//                text: 'bubble normal with tail',
//                isSender: false,
//                color: Color(0xFF1B97F3),
//                tail: true,
//                textStyle: TextStyle(
//                  fontSize: 20,
//                  color: Colors.white,
//                ),
//              ),
//              BubbleNormal(
//                text: 'bubble normal with tail',
//                isSender: true,
//                color: Color(0xFFE8E8EE),
//                tail: true,
//                sent: true,
//              ),
//              DateChip(
//                date: new DateTime(now.year, now.month, now.day - 2),
//              ),
//              BubbleNormal(
//                text: 'bubble normal without tail',
//                isSender: false,
//                color: Color(0xFF1B97F3),
//                tail: false,
//                textStyle: TextStyle(
//                  fontSize: 20,
//                  color: Colors.white,
//                ),
//              ),
//              BubbleNormal(
//                text: 'bubble normal without tail',
//                color: Color(0xFFE8E8EE),
//                tail: false,
//                sent: true,
//                seen: true,
//                delivered: true,
//              ),
//              BubbleSpecialOne(
//                text: 'bubble special one with tail',
//                isSender: false,
//                color: Color(0xFF1B97F3),
//                textStyle: TextStyle(
//                  fontSize: 20,
//                  color: Colors.white,
//                ),
//              ),
//              DateChip(
//                date: new DateTime(now.year, now.month, now.day - 1),
//              ),
//              BubbleSpecialOne(
//                text: 'bubble special one with tail',
//                color: Color(0xFFE8E8EE),
//                seen: true,
//              ),
//              BubbleSpecialOne(
//                text: 'bubble special one without tail',
//                isSender: false,
//                tail: false,
//                color: Color(0xFF1B97F3),
//                textStyle: TextStyle(
//                  fontSize: 20,
//                  color: Colors.black,
//                ),
//              ),
//              BubbleSpecialOne(
//                text: 'bubble special one without tail',
//                tail: false,
//                color: Color(0xFFE8E8EE),
//                sent: true,
//              ),
//              BubbleSpecialTwo(
//                text: 'bubble special tow with tail',
//                isSender: false,
//                color: Color(0xFF1B97F3),
//                textStyle: TextStyle(
//                  fontSize: 20,
//                  color: Colors.black,
//                ),
//              ),
//              DateChip(
//                date: now,
//              ),
//              BubbleSpecialTwo(
//                text: 'bubble special tow with tail',
//                isSender: true,
//                color: Color(0xFFE8E8EE),
//                sent: true,
//              ),
//              BubbleSpecialTwo(
//                text: 'bubble special tow without tail',
//                isSender: false,
//                tail: false,
//                color: Color(0xFF1B97F3),
//                textStyle: TextStyle(
//                  fontSize: 20,
//                  color: Colors.black,
//                ),
//              ),
//              BubbleSpecialTwo(
//                text: 'bubble special tow without tail',
//                tail: false,
//                color: Color(0xFFE8E8EE),
//                delivered: true,
//              ),
//              BubbleSpecialThree(
//                text: 'bubble special three without tail',
//                color: Color(0xFF1B97F3),
//                tail: false,
//                textStyle: TextStyle(color: Colors.white, fontSize: 16),
//              ),
//              BubbleSpecialThree(
//                text: 'bubble special three with tail',
//                color: Color(0xFF1B97F3),
//                tail: true,
//                textStyle: TextStyle(color: Colors.white, fontSize: 16),
//              ),
//              BubbleSpecialThree(
//                text: "bubble special three without tail",
//                color: Color(0xFFE8E8EE),
//                tail: false,
//                isSender: false,
//              ),
//              BubbleSpecialThree(
//                text: "bubble special three with tail",
//                color: Color(0xFFE8E8EE),
//                tail: true,
//                isSender: false,
//              ),
//            ],
//          ),
//        ),
//      ),
//      // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//  }