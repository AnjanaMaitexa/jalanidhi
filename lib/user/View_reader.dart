import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';
import 'package:jalanidhi/user/api.dart';

import '../sub_admin/Add panchayath.dart';
import '../sub_admin/View_meter_reader.dart';

class View_reader extends StatefulWidget {
  const View_reader({Key? key}) : super(key: key);

  @override
  State<View_reader> createState() => _View_readerState();
}

class _View_readerState extends State<View_reader> {
  String? valuechoose;
  List StateList = [
    'Munsipality',
    'Corporation',
    'Panjayath',
  ];
  TextEditingController Reader_namecontroller=TextEditingController();
  TextEditingController Reader_placecontroller=TextEditingController();
  TextEditingController dropdownvaluecontroller=TextEditingController();
  TextEditingController Destinationcontroller=TextEditingController();
  TextEditingController Phone_nocontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  bool _isLoading=false;

  var dropdownvalue;
  void registerUser()async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "Reader_name": Reader_namecontroller.text,
      "Reader_place": Reader_placecontroller.text,
      "Panchayath_type": dropdownvalue.toString(),
      "Destination": Destinationcontroller.text,
      "Phone_no": Phone_nocontroller.text,
      "email": emailcontroller.text,
      "username": usernamecontroller.text,
      "password": passwordcontroller.text,
    };
    print(data);
    var res = await Api().authData(data, '/api/consumer_register');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }
      @override
      Widget build(BuildContext context) {
        return Scaffold( appBar: AppBar(
          title: Text("Add_meter reader"),
          leading:IconButton(
            icon:Icon(Icons.arrow_back), onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>View_reader()));
          },
          ),
        ),

          body: ListView(children: [
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                enabled: false,
                labelText: "Reader_name",
                hintText: "name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                enabled: false,
                labelText: "Place",
                hintText: "place",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                enabled: false,
                labelText: "Destination",
                hintText: "destination",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                enabled: false,
                labelText: "phone no",
                hintText: "phone",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                enabled: false,
                labelText: "Email",
                hintText: "mail",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ],
          ),
        );
      }
}
