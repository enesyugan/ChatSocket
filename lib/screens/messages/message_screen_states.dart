//import 'dart:html';

import 'dart:core';
//import 'dart:ffi';

import 'package:asr_chat/screens/messages/OwnMessage.dart';
import 'package:flutter/material.dart';
import 'package:asr_chat/models/Message.dart';
import 'package:asr_chat/models/User.dart';
//import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:date_time/date_time.dart';
//import 'package:redis/redis.dart';

import '../../models/User.dart';
import 'dart:convert';
import 'dart:io';
//import 'dart:async';
//import 'dart:convert';


class MessagesScreenState extends StatefulWidget {
  User user;
  List<User> userList;
  String selectedUser = "AlexWaibel";
  List<Message> messageListAlex = [];
  List<Message> messageListStockton = [];
  List<Message> messageList = [];
  bool sendButton = false;
  IO.Socket socket = IO.io("http://141.3.25.129:8080", <String, dynamic>{
  "transports": ["websocket"],
  "autoConnect": false,
  });
  //final conn = RedisConnection();

  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();


  MessagesScreenState({
    required this.user,
    required this.userList,
  });


  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}
class _MessagesScreenState extends State<MessagesScreenState> {

//  bool sendButton = false;
// String selectedUser = "Alex";
 // IO.Socket socket = IO.io("http://192.21.23.3:5000", <String, dynamic>{
 // "transports": ["websocket"],
 // "autoConnect": false,
 // });

  int toggleIndex = 0;
  var DESTINATION_ADDRESS_ALL=InternetAddress("172.23.205.246");
 // var DESTINATION_ADDRESS=InternetAddress("141.3.25.174");

  // late Socket so;
  @override
  void initState(){
    print("initState");
    super.initState();
    print("=================================================");
    print("=================================================");
    print("=================================================");

    //connect_socket();
   // connect_socket_asnyc();
    widget.messageList = widget.messageListAlex;
    print("SDSDASDDAS?????????????????????????????????????????");
    print(widget.socket.connected);
  }

  void connect_socket() {
   // this.socket = IO.io("http://192.21.23.3:5000", <String, dynamic>{
   //   "transports": ["websocket"],
   //   "autoConnect": false,
   // });
    print("ENES");
    widget.socket.connect;
    widget.socket.onConnect((data) => print("==========Connected========"));
  }
  void connect_socket_asnyc() async{
    Socket soc = await Socket.connect('172.17.64.130', 59869);
    soc.add(utf8.encode("message"));
  //  print(this.so);
    soc.close();
    var DESTINATION_ADDRESS=InternetAddress("172.17.64.130");

    RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889).then((RawDatagramSocket udpSocket) {
      udpSocket.broadcastEnabled = true;
    // udpSocket.listen((e) {
    //   var dg = udpSocket.receive();
    //   if (dg != null) {
    //     print("received ${dg.data}");
    //   }
    // });
      List<int> data =utf8.encode('TEST');
      udpSocket.send(data, DESTINATION_ADDRESS, 59869);
    });
    print("ENES CONNECTED");
}

  void set_message(String message){
    DateTime now = DateTime.now();
    print(now.date);
    print(now.time);
    List<String> parts = now.time.toStringWithSeparator(':').split(':');
    String hour_min = parts.sublist(0,parts.length-1).join(':').trim();
    print(hour_min);
    Message m = new Message(
      sender: widget.user,
      time: hour_min,
      text: message ,
    );

    setState(() {
      if (widget.selectedUser == "AlexWaibel") {
        widget.messageListAlex.add(m);
      }
      else{
        widget.messageListStockton.add(m);
      }
    });
  }

  void send_to_socket(String message){
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889).then((RawDatagramSocket udpSocket) {
      udpSocket.send(utf8.encode("${widget.selectedUser}:${message}"), this.DESTINATION_ADDRESS_ALL, 59869);
    });
    print("Send to socket ${message}");
  }

  void write_message(String message){
    if (message.length > 0) {
      set_message(message);
      widget._scrollController.animateTo(widget._scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      send_to_socket(message);
    }
  }

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
              child: ListView.builder(
                shrinkWrap: true,
                controller: widget._scrollController,
                itemCount: widget.messageList.length,
                itemBuilder: (context, index){
                  return OwnMessageCart(
                    message: widget.messageList[index].text,
                    time: widget.messageList[index].time,
                  );
                },

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
                          controller: widget._controller,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 1,
                          onChanged: (value){
                            if (value.length > 0){
                              setState((){
                                widget.sendButton = true;
                                widget.selectedUser = widget.selectedUser;
                              });
                            }
                            else {
                              widget.sendButton = false;
                              widget.selectedUser = widget.selectedUser;
                            }
                            if (widget.selectedUser=="AlexWaibel"){
                              widget.messageList = widget.messageListAlex;
                            }
                            else{
                              widget.messageList = widget.messageListStockton;
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "message to topside",
                            contentPadding: EdgeInsets.all(5),
                          ),
                        )
                    ),
                  ),

                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: (){
                      write_message(widget._controller.text);
                      widget._controller.clear();
                    },
                  ),
                ),
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
                initialLabelIndex: toggleIndex,
                totalSwitches: 2,
                activeBgColor: [Colors.green],
                minWidth: 160,
                labels: ['Alex', 'Stockton'],
                onToggle: (index) {
                  print('===============switched to: $index ================');
                  if(index==0){
                    widget.selectedUser="AlexWaibel";
                    widget.user = widget.userList[0];
                    print(widget.selectedUser);
                    print(widget.user);
                    setState((){
                    toggleIndex = 0;
                    widget.messageList = widget.messageListAlex;
                    });
                  }
                  else {
                    widget.selectedUser = "Stockton";
                    widget.user = widget.userList[1];
                    print(widget.selectedUser);
                    setState((){
                      toggleIndex = 1;
                      widget.messageList = widget.messageListStockton;
                    });
                  }
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