
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Singlearea extends StatefulWidget {
  const Singlearea({Key? key}) : super(key: key);

  @override
  State<Singlearea> createState() => _SingleareaState();
}

class _SingleareaState extends State<Singlearea> {
  List _loadarea = [];
  bool isLoading = false;
  late SharedPreferences prefs;
  late int login_id;
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
    prefs = await SharedPreferences.getInstance();
    login_id = (prefs.getInt('user_id') ?? 0);
    print("userid${login_id}");

    var res = await Api()
        .getData('/api/meterreader_single_area/'+login_id.toString());
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
      title: Text("VIEW AREA"),
      leading:IconButton(
        icon:Icon(Icons.arrow_back), onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Reader_home()));
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
                  _loadarea[index]["panchayath_type"],
                  style:TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),
                ) ,
                subtitle: Text(
                  _loadarea[index]['panchayath_name'],
                  style:TextStyle(
                      fontSize: 20,
                      color: Colors.black54
                  ),
                ) ,
                trailing:Text(
                  _loadarea[index]['ward_no'].toString(),
                  style:TextStyle(
                      fontSize: 20,
                      color: Colors.black54
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
