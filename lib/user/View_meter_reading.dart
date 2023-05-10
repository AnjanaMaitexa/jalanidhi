import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jalanidhi/user/Home%20page.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';
import 'package:jalanidhi/user/Service_charge.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Viewreading extends StatefulWidget {
  const Viewreading({Key? key}) : super(key: key);

  @override
  State<Viewreading> createState() => _ViewreadingState();
}

class _ViewreadingState extends State<Viewreading> {
  TextEditingController readController = TextEditingController();
  TextEditingController  payController = TextEditingController();
  TextEditingController  dueController = TextEditingController();

  late SharedPreferences prefs;
  late int user_id;
    String reading='';
   String payment='';
  String date='';
  @override
  initState() {
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0 );
    print('login_idupdate ${user_id}');
    var res = await Api()
        .getData('/api/consumer_reading/' + user_id.toString());
    var body = json.decode(res.body);
    print("body${body}");
    setState(() {
      reading = body['data']['current_meter_reading'];
      print(reading);
      payment = body['data']['meter_reading_price'];
      date = body['data']['meter_reading_duedate'];
      readController.text = reading;
      payController.text = payment;
      dueController.text = date;

    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController datecontroller=TextEditingController();
    return MaterialApp(
        home: Scaffold( appBar: AppBar(
    title: Text("VIEW_METERREADING"),
    leading:IconButton(
    icon:Icon(Icons.arrow_back), onPressed: () {
      Navigator.push(context,MaterialPageRoute(builder: (context)=>userhome()));
    },
    ),
    ),
    body: Container(
    // ignore: prefer_const_literals_to_create_immutables
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    // Text("View Reading",
    // style: TextStyle(
    // fontSize: 20,
    // color: Colors.green,
    // fontWeight: FontWeight.bold,
    // ),
    // ),
    // SizedBox(height: 30),
    // TextField(decoration: InputDecoration(
    // labelText: "Previous readings",
    // hintText: "Reading",
    // border: OutlineInputBorder(
    // borderRadius: BorderRadius.circular(30),
    // ),
    // ),
    // ),
      TextField(
        controller: payController,
        readOnly: true,
        decoration: InputDecoration(
        labelText:payment,
        hintText: payment,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      ),
      SizedBox(height: 30),
      TextField(
        controller: readController,
        readOnly: true,
        decoration: InputDecoration(
        labelText:reading.toString(),
        hintText: reading.toString(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      ),
      SizedBox(height: 30),
      TextField(
        controller: datecontroller,
        readOnly: true,
        decoration: InputDecoration(
        labelText: date,
        hintText: date,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      ),
    SizedBox(height: 30),
    SizedBox(height: 30),
    SizedBox(height: 50,
    width: 100,
    child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    primary: Colors.green,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
    ),
    // padding: EdgeInsets.all(20)
    ),
    onPressed: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>Charge()));
    } ,
    child: Text("PAYMENT")),
    )
        ]
    )
    )
    )
    );
  }
}
