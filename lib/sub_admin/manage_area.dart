
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';
import 'package:jalanidhi/sub_admin/add_area.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/Add_reader.dart';
import 'package:jalanidhi/user/api.dart';

class Managearea extends StatefulWidget {
  const Managearea({Key? key}) : super(key: key);

  @override
  State<Managearea> createState() => _ManageareaState();
}

class _ManageareaState extends State<Managearea> {
  List _loadarea = [];
  bool isLoading = false;
  late int package_id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _fetchData();
  }

  _fetchData() async {
    var res = await Api()
        .getData('/api/all_area');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
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
    return  Scaffold(
      appBar: AppBar(
        title: Text("Manage Area"),
        leading:IconButton(
          icon:Icon(Icons.arrow_back), onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Subadmin_home()));
        },
        ),
      ),
      body: ListView.builder(
        shrinkWrap:true,
        itemCount: _loadarea.length,
        itemBuilder: (context,index){
          return InkWell(
              onTap: ()async {

              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Column(
                    children: [
                  Text("Area: "+_loadarea[index]['panchayath_name'],style:TextStyle(
                    fontSize: 18,fontWeight: FontWeight.bold,
                  )),
                  Text(_loadarea[index]['panchayath_type'],style:TextStyle(
                    fontSize: 18,fontWeight: FontWeight.bold,
                  )),
                  Text("WardNo: "+_loadarea[index]['ward_no'],style:TextStyle(
                    fontSize: 18,fontWeight: FontWeight.bold,
                  ))

                        ]
              )
          )
          ),);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddArea()));
        },
      ),
    );
  }
}
