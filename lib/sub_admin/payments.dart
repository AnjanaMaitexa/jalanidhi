
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  List _loadpay = [];
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
        _loadpay = items;
      });
    } else {
      setState(() {
        _loadpay = [];
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
      title: Text("Payments"),
      leading:IconButton(
        icon:Icon(Icons.arrow_back), onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Subadmin_home()));
      },
      ),
    ),
      body: ListView.builder(
          itemCount: _loadpay.length, itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.blueGrey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(

                title: Text(
                  _loadpay[index][''],
                  style:TextStyle(
                      fontSize: 20,
                      color: Colors.yellowAccent
                  ),
                ) ,
              subtitle: Text(
                _loadpay[index][''],
                style:TextStyle(
                    fontSize: 20,
                    color: Colors.yellowAccent
                ),
              ) ,

            ),
          ),

        );
      }
      ),
    );
  }
}

