import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/Home%20page.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';
import 'package:jalanidhi/user/Service_charge.dart';

import 'Reply.dart';
class View_complaint extends StatefulWidget {
  const View_complaint({Key? key}) : super(key: key);

  @override
  State<View_complaint> createState() => _View_complaintState();
}

class _View_complaintState extends State<View_complaint> {
  @override
  Widget build(BuildContext context) {
    TextEditingController datecontroller=TextEditingController();
    return MaterialApp(
        home: Scaffold( appBar: AppBar(
          title: Text("VIEW_COMPLAINT"),
          leading:IconButton(
            icon:Icon(Icons.arrow_back), onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>Subadmin_home()));
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
                      SizedBox(height: 30),
                      TextField(decoration: InputDecoration(
                        labelText: "Consumer_name",
                        hintText: "name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      ),
                      SizedBox(height: 30),
                      TextField(decoration: InputDecoration(
                        labelText: "Panchayath_type",
                        hintText: "type",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      ),
                      SizedBox(height: 30),
                      TextField(decoration: InputDecoration(
                        labelText: "Panchayath_name",
                        hintText: "name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      ),
                      SizedBox(height: 30),
                      TextField(decoration: InputDecoration(
                        labelText: "Ward_no",
                        hintText: "ward_no",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      ),

                      SizedBox(height: 30),
                      TextField(decoration: InputDecoration(
                        labelText: "Date",
                        hintText: "date",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      ),
                      SizedBox(height: 30),
                      TextField(decoration: InputDecoration(
                        labelText: "Complaint",
                        hintText: "complaint",
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
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>Reply()));
                            } ,
                            child: Text("REPLY")),
                      )
                    ]
                )
            )
        )
    );
  }
}
