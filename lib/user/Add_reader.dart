import 'package:flutter/material.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';

import '../sub_admin/Add panchayath.dart';
import '../sub_admin/View_meter_reader.dart';

class Add_reader extends StatefulWidget {
  const Add_reader({Key? key}) : super(key: key);

  @override
  State<Add_reader> createState() => _Add_readerState();
}

class _Add_readerState extends State<Add_reader> {
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
            labelText: "Reader_name",
            hintText: "name",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          decoration: InputDecoration(
            labelText: "Place",
            hintText: "place",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          decoration: InputDecoration(
            labelText: "Destination",
            hintText: "Destination",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          decoration: InputDecoration(
            labelText: "phone no",
            hintText: "phone",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          decoration: InputDecoration(
            labelText: "Email",
            hintText: "mail",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
        SizedBox(height: 30),

        SizedBox(
          width: 5,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                // padding: EdgeInsets.all(20)
              ),
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Subadmin_home()));
              } ,
              child: Text("ADD")),
        ),
      ],
      ),
    );
  }
}
