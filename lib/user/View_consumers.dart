import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/Home%20page.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
class View_profile extends StatefulWidget {

  final int id;

  View_profile({required this.id});

  @override
  State<View_profile> createState() =>_View_profileState ();
}

class _View_profileState extends State<View_profile> {
  String name = "";
  String house_name = "";
  String aadhar_no = "";
  String email = "";
  String category = "";
  String ward_no = "";
  String panchayath_type = "";
  String panchayath_name = "";
  String phone_no = "";
  late int userid;
  late SharedPreferences prefs;
  TextEditingController nameController = TextEditingController();
  TextEditingController  houseController = TextEditingController();
  TextEditingController  adharController = TextEditingController();
  TextEditingController  emailController = TextEditingController();
  TextEditingController  phnController = TextEditingController();
  TextEditingController  categController = TextEditingController();
  TextEditingController  wardController = TextEditingController();
  TextEditingController  typeController = TextEditingController();
  TextEditingController  pnameController = TextEditingController();

  @override
  initState() {
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {

    userid =widget.id;
    print('login_idupdate ${userid}');
    var res = await Api()
        .getData('/api/single_consumer/' + userid.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['name'];
      house_name = body['data']['house_name'];
      email = body['data']['email'];
      aadhar_no = body['data']['aadhar_no'];
      phone_no = body['data']['phone_no'];
      panchayath_type = body['data']['panchayath_type'];
      panchayath_name = body['data']['panchayath_name'];
      ward_no = body['data']['ward_no'];
      category = body['data']['category'];

      nameController.text = name;
      houseController.text=house_name;
      adharController.text=aadhar_no;
      emailController.text = email;
      phnController.text = phone_no;
      typeController.text = panchayath_type;
      pnameController.text=panchayath_name;
      wardController.text=ward_no;
      categController.text=category;

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Consumer Page"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Subadmin_home()));
              }
          ),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(image: DecorationImage(
              image: AssetImage("images/img.png"),
              fit: BoxFit.cover
          ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                    backgroundImage:AssetImage("images/img_10.png")
                ),
                Text("Name    :   "+name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text("HouseName  :  "+house_name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text("Email    :   "+email,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text("AAdharNo   :   "+aadhar_no,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text("Type    :   "+panchayath_type,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text("Type Name    :    "+panchayath_name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text("Ward No   :    "+ward_no,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text("Category    :   "+category,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ]
          ),
        ),
      ),
    );
  }
}


