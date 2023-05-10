import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/Home%20page.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Vcnnctn extends StatefulWidget {
  const Vcnnctn({Key? key}) : super(key: key);


  @override
  State<Vcnnctn> createState() => _VcnnctnState();

}

class _VcnnctnState extends State<Vcnnctn> {
  List Letter = ["image/sk1.jpg", "image/sk2.jpg", "image/sk3.jpg", "image/s4.jpg", ];
  List _loadconnection = [];
  bool isLoading = false;
  late SharedPreferences localStorage;
  late int user_id;
  late int consume_id;

  late bool isExpanded=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _fetchConsumer();
  }

  _fetchConsumer() async {
    var res = await Api()
        .getData('/api/all_consumer_connection');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print("items${items}");
      setState(() {
        _loadconnection = items;
      });
    } else {
      setState(() {
        _loadconnection = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }
  Approve(int id) async {

    var res = await Api().postData('/api/consumer_connection_approve/'+id.toString());
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print("suuc${body}");
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

    }
    else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }
  Reject(int id) async {

    var res = await Api().postData('/api/consumer_connection_reject/'+id.toString());
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print("suuc${body}");
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

    }
    else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
      title: Text("VIEW Connection"),
      leading:IconButton(
        icon:Icon(Icons.arrow_back), onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Subadmin_home()));
      },
      ),
    ),
      body: ListView.builder(
          itemCount: _loadconnection.length, itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.blueGrey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              // leading: Image(
              //   image: AssetImage(
              //       Letter[index]
              //   ),
              //
              // )
              // ,
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    _loadconnection[index]['connection_amt'].toString(),
                    style:TextStyle(
                        fontSize: 20,
                        color: Colors.yellowAccent
                    ),
                  ) ,
                  ElevatedButton(

                      style: ElevatedButton.styleFrom(
                          primary:Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(strokeAlign: BorderSide.strokeAlignCenter),
                          ),
                          padding: EdgeInsets.all(0)

                      ),

                      onPressed:(){

                        int _id = _loadconnection[index]['id'];
                       Approve(_id);
                      },
                      child: Text(_loadconnection[index]['connection_status']==0?"Approve":" Approved",
                        style: TextStyle(
                            color: Colors.black
                        ),
                      )
                  ),
                  ElevatedButton(

                      style: ElevatedButton.styleFrom(
                          primary:Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                            side: BorderSide(strokeAlign: BorderSide.strokeAlignCenter),
                          ),
                          padding: EdgeInsets.all(0)

                      ),

                      onPressed:(){

                        int _id = _loadconnection[index]['id'];
                        Reject(_id);
                      },
                      child: Text(_loadconnection[index]['connection_status']==0?"Rejected":"Reject",
                        style: TextStyle(
                            color: Colors.black
                        ),
                      )
                  ),
                ],
              ),
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

