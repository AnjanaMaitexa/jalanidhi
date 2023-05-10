import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/Add_reader.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Reader_view.dart';
class View_reader extends StatefulWidget {
  const View_reader({Key? key}) : super(key: key);
  @override
  State<View_reader> createState() => _View_readerState();
}

class _View_readerState extends State<View_reader> {
  List _loadreader = [];
  bool isLoading = false;
  late SharedPreferences localStorage;
  late int user_id;

  late bool isExpanded=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _fetchReader();
  }

  _fetchReader() async {
    var res = await Api()
        .getData('/api/all_meter_reader');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print("items${items}");
      setState(() {
        _loadreader = items;
      });
    } else {
      setState(() {
        _loadreader = [];
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
      title: Text("Meter_readers"),
      leading:IconButton(
        icon:Icon(Icons.arrow_back), onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Subadmin_home()));
      },
      ),
    ),
      body: ListView.builder(
          itemCount: _loadreader.length, itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: ListTile(
                title: Text(
                  _loadreader[index]["meter_reader_name"],
                  style:TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),
                ) ,
              subtitle: Text(
                _loadreader[index]['meter_reader_district'],
                style:TextStyle(
                    fontSize: 20,
                    color: Colors.black45
                ),
              ) ,
              trailing: ElevatedButton(
                onPressed: () async {
        int _id = _loadreader[index]['id'];
        Navigator.push(context,MaterialPageRoute(builder: (context)=>View_read(id:_id)));

                }, child: Text("Add Panchayath"),),
            ),

          ),
        );
      }
      ),
   /*   floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_reader()));
        },
      ),*/
    );
  }
}

