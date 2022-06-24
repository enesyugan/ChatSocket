import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enum_to_string/enum_to_string.dart';

enum ConnectionParameter { UDP, API }

class SettingsScreen extends StatefulWidget {
  late String ip_adress;
  late int port;
  //late var prefs;
  //var prefs = SharedPreferences.getInstance();
  final IP_ADDRESS_CTRL = TextEditingController();
  final PWD_CTRL = TextEditingController();
  final PORT_CTRL = TextEditingController();

  ConnectionParameter? _connection = ConnectionParameter.UDP;

  SettingsScreen() {
    //get_prefs();
    //_connection = ConnectionParameter.UDP;
  }

  @override
  _SettingsScreen createState() => _SettingsScreen();

  void get_prefs() async {
    // Obtain shared preferences.
    // this.prefs = await SharedPreferences.getInstance();
    // String? ip_string = this.prefs.getString('IP_ADRESS');
    // String? port = prefs.getString('PORT');
    // String? con = prefs.getString('Connection_TYPE');
    // if (ip_string != null) {
    //   IP_ADDRESS_CTRL.text = ip_string;
    // }
    // if (port != null) {
    //   PORT_CTRL.text = port;
    // }
    // if (con != null) {
    //   print("NOT NUKLLLLLLL=====");
    //   _connection = EnumToString.fromString(ConnectionParameter.values, con);
    // }
  }
}

class _SettingsScreen extends State<SettingsScreen> {
  late var prefs;
  @override
  void initState() {
    super.initState();
    get_prefs();
  }

  bool ip_address_check(String ip_address) {
    print(ip_address);
    if (ip_address == "") {
      print("empty");
      return false;
    }
    try {
      print("trying ...");
      var x = InternetAddress(ip_address);
    } on Exception catch (_) {
      print("EXCEPTION");
      return false;
    } catch (error) {
      print("ERRRROR");
      return false;
    }
    return true;
  }

  void get_prefs() async {
    // Obtain shared preferences.
    this.prefs = await SharedPreferences.getInstance();
    String? ip_string = this.prefs.getString('IP_ADRESS');
    String? port = prefs.getString('PORT');
    String? con = prefs.getString('Connection_TYPE');
    if (ip_string != null) {
      widget.IP_ADDRESS_CTRL.text = ip_string;
    }
    if (port != null) {
      widget.PORT_CTRL.text = port;
    }
    if (con != null) {
      print("NOT NUKLLLLLLL=====");
      setState(() {
        widget._connection =
            EnumToString.fromString(ConnectionParameter.values, con);
      });
    }
  }

  void on_save(
      String pw, String ip_adress, String port, BuildContext context) async {
    //this.prefs = await SharedPreferences.getInstance();
    print("on saved ${pw}, ${ip_adress}, ${port}");
    set_prefs(pw, ip_adress, port);
    print(widget._connection);
    Navigator.of(context).pop(
        [ip_adress, port, EnumToString.convertToString(widget._connection)]);
  }

  void set_prefs(String pw, String ip_adress, String port) async {
    this.prefs.setString('IP_ADRESS', ip_adress);
    this.prefs.setString('PORT', port);
    this.prefs.setString(
        'Connection_TYPE', EnumToString.convertToString(widget._connection));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => {
                  if (widget.IP_ADDRESS_CTRL.text == "")
                    {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => const AlertDialog(
                                title: Text(
                                    "Pleases insert ip adress and port number"),
                              ))
                    }
                  else
                    {
                      Navigator.of(context).pop([
                        widget.IP_ADDRESS_CTRL.text,
                        widget.PORT_CTRL.text,
                        EnumToString.convertToString(widget._connection)
                      ]),
                    },
                }),
        title: Text("Settings"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: GestureDetector(
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
                      margin:
                          EdgeInsets.only(left: 0, right: 0, bottom: 8, top: 0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 60,
                            //color: Colors.red,
                            child: ListTile(
                              title: const Text("UDP"),
                              leading: Radio<ConnectionParameter>(
                                activeColor: Colors.blueAccent,
                                value: ConnectionParameter.UDP,
                                groupValue: widget._connection,
                                onChanged: (ConnectionParameter? value) {
                                  setState(() {
                                    widget._connection = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 60,
                            //color: Colors.black87,
                            child: ListTile(
                              title: const Text("API"),
                              leading: Radio<ConnectionParameter>(
                                activeColor: Colors.blueAccent,
                                value: ConnectionParameter.API,
                                groupValue: widget._connection,
                                onChanged: (ConnectionParameter? value) {
                                  print("CHANFG API");
                                  print(value);
                                  print(value.runtimeType);
                                  setState(() {
                                    widget._connection = value;
                                  });
                                },
                              ),
                            ),
                          )
                          //    Radio<ConnectionParameter>(
                          //      value: ConnectionParameter.UDP,
                          //      groupValue: _connection,
                          //      onChanged: (ConnectionParameter? value) {
                          //        _connection = value;
                          //      },
                          //    ),
                          //    Text("UDP"),
                          //    Radio<ConnectionParameter>(
                          //      value: ConnectionParameter.API,
                          //      groupValue: _connection,
                          //      onChanged: (ConnectionParameter? value) {
                          //        _connection = value;
                          //      },
                          //    ),
                          //    Text("APi")
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.only(left: 0, right: 0, bottom: 8, top: 0),
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
                      margin:
                          const EdgeInsets.only(left: 40, right: 2, bottom: 8),
                      child: TextFormField(
                        controller: widget.IP_ADDRESS_CTRL,
                        decoration: const InputDecoration(
                          hintText: "For example: 172.23.205.246",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        style: TextStyle(fontWeight: FontWeight.bold),
                        onSaved: (value) {
                          print(value);
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.only(left: 0, right: 0, bottom: 8, top: 8),
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
                      margin:
                          const EdgeInsets.only(left: 40, right: 2, bottom: 8),
                      child: TextFormField(
                        controller: widget.PORT_CTRL,
                        decoration: const InputDecoration(
                          hintText: "For example: 2022",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        style: TextStyle(fontWeight: FontWeight.bold),
                        onSaved: (value) {
                          print(value);
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.only(left: 0, right: 0, bottom: 8, top: 8),
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
                      margin:
                          const EdgeInsets.only(left: 40, right: 2, bottom: 8),
                      child: TextFormField(
                        controller: widget.PWD_CTRL,
                        decoration: const InputDecoration(
                          hintText: "For example: 4000",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        onSaved: (value) {
                          print(value);
                        },
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Save'),
                      onPressed: () {
                        print(widget.PWD_CTRL.text);
                        print(widget.IP_ADDRESS_CTRL.text);
                        print(widget.PORT_CTRL.text);
                        if (widget.PWD_CTRL.text != "4000") {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  const AlertDialog(
                                    title: Text("Wrong Passwort"),
                                  ));
                        } else if (!ip_address_check(
                            widget.IP_ADDRESS_CTRL.text)) {
                          {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const AlertDialog(
                                      title: Text(
                                          "IP has incorrect format or is empty"),
                                    ));
                          }
                        } else if (widget.PORT_CTRL.text == "") {
                          {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    const AlertDialog(
                                      title: Text("Port cant be empty"),
                                    ));
                          }
                        } else {
                          on_save(
                              widget.PWD_CTRL.text,
                              widget.IP_ADDRESS_CTRL.text,
                              widget.PORT_CTRL.text,
                              context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
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
