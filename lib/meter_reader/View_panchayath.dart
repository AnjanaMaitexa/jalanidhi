import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Viewarea extends StatefulWidget {
  const Viewarea({Key? key}) : super(key: key);

  @override
  State<Viewarea> createState() => _ViewareaState();
}

class _ViewareaState extends State<Viewarea> {
  List _loadarea = [];
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
        .getData('/api/all_area');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print("items${items}");
      setState(() {
        _loadarea = items;
      });
    } else {
      setState(() {
        _loadarea = [];
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
      title: Text("VIEW PANCHAYATH"),
      leading:IconButton(
        icon:Icon(Icons.arrow_back), onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Subadmin_home()));
      },
      ),
    ),
      body: ListView.builder(
          itemCount: _loadarea.length, itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
         //   Navigator.push(context,MaterialPageRoute(builder: (context)=>View_read()));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text(
                  _loadarea[index]["meter_reader_name"],
                  style:TextStyle(
                      fontSize: 20,
                      color: Colors.yellowAccent
                  ),
                ) ,
                subtitle: Text(
                  _loadarea[index]['meter_reader_district'],
                  style:TextStyle(
                      fontSize: 20,
                      color: Colors.yellowAccent
                  ),
                ) ,


              ),

            ),
          ),
        );
      }
      ),
    );
  }
}
