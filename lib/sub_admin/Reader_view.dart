import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Add panchayath.dart';
import 'View_meter_reader.dart';

class View_read extends StatefulWidget {
  final int id;

  View_read({required this.id});

  @override
  State<View_read> createState() => _View_readState();
}

class _View_readState extends State<View_read> {
  String name = "";
  String place = "";
  String destini = "";
  String phn = "";
  String email = "";
  late int userid;
  late SharedPreferences prefs;
  TextEditingController nameController = TextEditingController();
  TextEditingController  placeController = TextEditingController();
  TextEditingController  destiniController = TextEditingController();
  TextEditingController  phnController = TextEditingController();
  TextEditingController  emailController = TextEditingController();

  @override
  initState() {
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {

    userid =widget.id;
    print('login_idupdate ${userid}');
    var res = await Api()
        .getData('/api/single_meter_reader/' + userid.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['meter_reader_name'];
      place = body['data']['meter_reader_district'];
      destini = body['data']['meter_reader_city'];
      phn = body['data']['meter_reader_phoneno'];
      email = body['data']['meter_reader_email'];

      nameController.text = name;
      placeController.text=place;
      destiniController.text=destini;
      emailController.text = email;
      phnController.text = phn;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
      title: Text("View_meter_readers"),
      leading:IconButton(
        icon:Icon(Icons.arrow_back), onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>View_reader()));
      },
      ),
    ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(children: [
          SizedBox(height: 30),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: "Reader_name",
              hintText: "name",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          SizedBox(height: 30),
          TextField(
            controller: placeController,
            decoration: InputDecoration(
              labelText: "Place",
              hintText: "place",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          SizedBox(height: 30),
          TextField(
            controller: destiniController,
            decoration: InputDecoration(
              labelText: "Destination",
              hintText: "destination",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          SizedBox(height: 30),
          TextField(
            controller: phnController,
            decoration: InputDecoration(
              labelText: "phone no",
              hintText: "phone",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          SizedBox(height: 30),
          TextField(
            controller: emailController,
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
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>area(id:userid)));
                } ,
                child: Text("ADD AREA")),
          ),
        ],
        ),
      ),
    );
  }
}
