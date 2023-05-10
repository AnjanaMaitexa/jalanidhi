// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../login.dart';
import '../user/api.dart';
class Not extends StatefulWidget {
  const Not({Key? key}) : super(key: key);

  @override
  State<Not> createState() =>_NotState();
}
class _NotState extends State<Not>{
  String? valuechoose;
  List Statelist=[
    'Consumer',
    'Meter reader'
  ];
  @override
  Widget build(BuildContext context) {
    TextEditingController notification_datecontroller=TextEditingController();
    TextEditingController notification_timecontroller=TextEditingController();
    TextEditingController notificationcontroller=TextEditingController();
    TextEditingController users_typecontroller=TextEditingController();
    bool _isLoading=false;
    void registerUser()async {
      setState(() {
        _isLoading = true;
      });

      var data = {
        "notification_date": notification_datecontroller.text,
        "notification_time": notification_timecontroller.text,
        "notification": notificationcontroller.text,
        "users_type":  users_typecontroller.text,

      };
      print(data);
      var res = await Api().authData(data,'/api/panchayath_details');
      var body = json.decode(res.body);

      if(body['success']==true)
      {
        print(body);
        Fluttertoast.showToast(
          msg: body['message'].toString(),
          backgroundColor: Colors.grey,
        );

        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

      }
      else
      {
        Fluttertoast.showToast(
          msg: body['message'].toString(),
          backgroundColor: Colors.grey,
        );

      }
    }
    return MaterialApp(
      home: Scaffold( appBar: AppBar(
        title: Text("NOTIFICATION"),
        leading:IconButton(
          icon:Icon(Icons.menu), onPressed: () {  },
        ),
      ),
        body: Container(
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Notification",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              TextField(decoration: InputDecoration(
                labelText:"Notification" ,
                hintText: "notification",
                hintStyle: TextStyle(
                    color: Colors.green
                ),
                border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              ),
              SizedBox(
                height: 30,
              ),

              Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: notification_datecontroller,
                        onTap: () async{
                          DateTime? pickedDate= await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100)
                          );
                          if(pickedDate!=null){
                            notification_datecontroller.text=
                                DateFormat('yyyy-mm-dd').format(pickedDate);
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.date_range),
                          hintText: "Date",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
              TextField(
                controller: notification_timecontroller,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (pickedTime != null) {
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime.format(context).toString());

                    String formattedTime =
                    DateFormat('HH:mm:ss').format(parsedTime);
                    notification_timecontroller.text =
                        formattedTime;

                  } else {
                    print("Time is not selected");
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.date_range),
                  hintText: 'Time',
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  padding: EdgeInsets.only(left: 5,right: 5,top: 10),
                  decoration:
                  BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 1),
                      borderRadius: BorderRadius.circular(30)),
                  child: DropdownButton(
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    underline: SizedBox(),
                    hint: Text("Choose person"),
                    value: valuechoose,
                    onChanged: (newvalue) {
                      setState(() {
                        valuechoose = newvalue.toString();
                      });
                    },
                    items:Statelist.map((valuestate) {
                      return DropdownMenuItem(
                          value: valuestate, child: Text(valuestate));
                    }).toList(),
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
                    onPressed: (){} ,
                    child: Text("SUBMIT")),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
