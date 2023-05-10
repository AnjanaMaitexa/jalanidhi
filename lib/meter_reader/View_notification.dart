import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jalanidhi/user/Home%20page.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Viewnot extends StatefulWidget {
  const Viewnot({Key? key}) : super(key: key);


  @override
  State<Viewnot> createState() => _ViewnotState();

}

class _ViewnotState extends State<Viewnot> {
  List Lview = ["Notification 1", "Notification 2", "Notification 3", "Notification 4", "Notification 5"];
  List Letter = ["image/sk1.jpg", "image/sk2.jpg", "image/sk3.jpg", "image/s4.jpg", ];
  List _loadnoti = [];
  bool isLoading = false;
  late SharedPreferences localStorage;
  late int user_id;

  late bool isExpanded=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _fetchArea();
  }

  _fetchArea() async {
    var res = await Api()
        .getData('/api/notification');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print("items${items}");
      setState(() {
        _loadnoti = items;
      });
    } else {
      setState(() {
        _loadnoti = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
        title: Text("VIEW NOTIFICATION"),
    leading:IconButton(
    icon:Icon(Icons.arrow_back), onPressed: () {
   Navigator.pop(context);
    },
    ),
    ),
    body: ListView.builder(
          itemCount: _loadnoti.length, itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  // leading: Image(
                  //   image: AssetImage(
                  //       Letter[index]
                  //   ),
                  //
                  // )
                  // ,
                  title: Text(
                    _loadnoti[index]['notification'],
                    style:TextStyle(
                        fontSize: 20,
                        color: Colors.yellowAccent
                    ),
                  ) ,subtitle: Text(
                  _loadnoti[index]['notification_date'],
                  style:TextStyle(
                      fontSize: 20,
                      color: Colors.yellowAccent
                  ),
                ) /*,,
                  trailing:
                  ElevatedButton(

                      style: ElevatedButton.styleFrom(
                          primary:Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(strokeAlign: BorderSide.strokeAlignCenter),
                          ),
                          padding: EdgeInsets.all(0)

                      ),

                      onPressed:(){},
                      child: Text("CANCEL",
                        style: TextStyle(
                            color: Colors.black
                        ),
                      )
                  ),*/
                      ),
                  // IconButton(
                  //   icon: Icon(
                  //       Icons.ca), onPressed: (
                  //     ){},
                  // ),
                ),
              );
    }
                      ),
    );
    }
  }

