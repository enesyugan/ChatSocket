import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  late String ip_adress;
  late int port;
  late var prefs;
  final IP_ADDRESS_CTRL = TextEditingController();
  final PWD_CTRL = TextEditingController();
  final PORT_CTRL = TextEditingController();

  SettingsScreen();

  @override
  void initState() {
    get_prefs();
  }

  void get_prefs() async {
    // Obtain shared preferences.
    this.prefs = await SharedPreferences.getInstance();
  }

  void on_save(String pw, String ip_adress, String port) {
    print("on saved ${pw}, ${ip_adress}, ${port}");
    set_prefs(pw, ip_adress, port);
  }

  void set_prefs(String pw, String ip_adress, String port) async {
    this.prefs.setString('IP_ADRESS', ip_adress);
    this.prefs.setString('PORT', port);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => {
                  Navigator.of(context).pop(),
                }),
        title: Text("Settings"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.red,
                  child: Column(
                    children: [
                      //Container(
                      //    width: MediaQuery.of(context).size.width - 55,
                      //    alignment: Alignment.center,
                      //    child: Text("Enter ip adress of board media server")
                      //),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: 0, right: 0, bottom: 8, top: 0),
                        color: Colors.blueAccent,
                        child: const Text(
                          "Enter IP Adress of submarine media server",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 60,
                        alignment: Alignment.center,
                        // color: Colors.red,
                        margin: const EdgeInsets.only(
                            left: 40, right: 2, bottom: 8),
                        child: TextFormField(
                          controller: IP_ADDRESS_CTRL,
                          decoration: const InputDecoration(
                            hintText: "For example: 172.23.205.246",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onSaved: (value) {
                            print(value);
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: 0, right: 0, bottom: 8, top: 8),
                        color: Colors.blueAccent,
                        child: const Text(
                          "Enter Port of submarine media server",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 60,
                        alignment: Alignment.center,
                        // color: Colors.red,
                        margin: const EdgeInsets.only(
                            left: 40, right: 2, bottom: 8),
                        child: TextFormField(
                          controller: PORT_CTRL,
                          decoration: const InputDecoration(
                            hintText: "For example: 2022",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onSaved: (value) {
                            print(value);
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                            left: 0, right: 0, bottom: 8, top: 8),
                        color: Colors.blueAccent,
                        child: const Text(
                          "Enter Security Check",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 60,
                        alignment: Alignment.center,
                        // color: Colors.red,
                        margin: const EdgeInsets.only(
                            left: 40, right: 2, bottom: 8),
                        child: TextFormField(
                          controller: PWD_CTRL,
                          decoration: const InputDecoration(
                            hintText: "For example: 4000",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          onSaved: (value) {
                            print(value);
                          },
                        ),
                      ),
                      RaisedButton(
                        child: Text('Save'),
                        onPressed: () {
                          print("SAVE");
                          on_save(PWD_CTRL.text, IP_ADDRESS_CTRL.text,
                              PORT_CTRL.text);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

// AppBar buildSettingsAppBar() {
//   return AppBar(
//       automaticallyImplyLeading: false,
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
//         crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
//         mainAxisSize: MainAxisSize.min,

//           children: <Widget>[
//             IconButton(
//               onPressed: (){
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SettingsScreen()),
//                 );
//               },
//               icon: Icon(
//                 Icons.settings,
//                 color: Colors.white,
//               ),
//             ),
//   ],
//       )
//   );
// }
}
