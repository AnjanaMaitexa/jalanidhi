import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jalanidhi/login.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/Home%20page.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String user = "Consumer";
  String sub="Subadmin";
  String reader="reader";

  String role="";
  late SharedPreferences localStorage;
  Future<void> checkRoleAndNavigate() async {
    localStorage = await SharedPreferences.getInstance();
    role = (localStorage.getString('role') ?? '');
    print(role);
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
    } else  {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context)=>Login()));
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 4);
    return Timer(duration, checkRoleAndNavigate);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Image(image: AssetImage("images/water.png")),
    );
  }
}


