
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/Home%20page.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:jalanidhi/user/main_reg_dashboard.dart';
import 'package:jalanidhi/user/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late int login_id;
  String user = "Consumer";
  String sub="Subadmin";
  String reader="reader";

  bool _obscuretext = true;
  bool passwordVisible = false;
  String role='';
  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
 bool _isLoading=false;
 late SharedPreferences localStorage;

  final _formKey = GlobalKey<FormState>();
  pressLoginButton() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'username': usernamecontroller.text.trim(), //username for email
      'password': passwordcontroller.text.trim()
    };
    var res = await Api().authData(data,'/api/login_users');
    var body = json.decode(res.body);

    print("body${body}");
    if (body['success'] == true) {

      role=body['data']['role'];
      localStorage = await SharedPreferences.getInstance();
      localStorage.setString('role', body['data']['role']);
      localStorage.setInt('login_id', body['data']['login_id']);
      localStorage.setInt('user_id', body['data']['user_id']);
      print(role);
      print('login_id ${body['data']['login_id']}');
      print('user_id ${body['data']['user_id']}');

      if (user == role) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>userhome()));

      } else if (sub == role) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Subadmin_home(),
        ));
      } else if (reader == role) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Reader_home(),
        ));
      }

    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(/* appBar: AppBar(
        title: Text("LOGIN"),
    leading:IconButton(
    icon:Icon(Icons.menu), onPressed: () {  },
    ),
    ),*/
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(image: DecorationImage(
              image: AssetImage("images/img_18.png"),
              fit: BoxFit.cover
          )),
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          Text("Login",
    style: TextStyle(
    fontSize: 20,
    color: Colors.green,
    fontWeight: FontWeight.bold,
    ),
        ),
    SizedBox(height: 30),
    TextField(
      controller: usernamecontroller,
      decoration: InputDecoration(
    labelText:"username" ,
    hintText: "username",
    hintStyle: TextStyle(
    color: Colors.green
    ),
    border:OutlineInputBorder(
    borderRadius: BorderRadius.circular(30)),
    ),
    ),
    SizedBox(height: 30),
    TextField(
      obscureText: true,
      controller: passwordcontroller,
      decoration: InputDecoration(
    labelText: "password",
    hintText: "password",
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    ),
    ),
    ),
    SizedBox(height: 30),
    // Text("forgot your password"),
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
      pressLoginButton();
     // Navigator.push(context, MaterialPageRoute(builder: (context)=>userhome()));
    } ,
    child: Text("LOGIN")),
    ),
    SizedBox(height: 30),
    InkWell(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>MainDash()));
        },
        child: Text("do you have an account"))
    ],
    ),
        ),
      ),
    );
  }
}
