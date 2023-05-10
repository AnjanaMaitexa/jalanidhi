import 'package:flutter/material.dart';
import 'package:jalanidhi/user/Complaints.dart';
import 'package:jalanidhi/user/Connection_payment.dart';
import 'package:jalanidhi/user/registration.dart';
import 'package:jalanidhi/user/View_Connection.dart';
import 'package:jalanidhi/meter_reader/View_notification.dart';
import 'package:jalanidhi/user/sent_complaint.dart';
import 'package:jalanidhi/user/View_meter_reading.dart';
import 'package:jalanidhi/user/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';
import 'View_meter_reading.dart';

class userhome extends StatefulWidget {
  const userhome({Key? key}) : super(key: key);
  @override
  State<userhome> createState() => _userhomeState();
}
class _userhomeState extends State<userhome> {
  late SharedPreferences localStorage;
  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: InkWell(
            onTap: () async {
              if (title == 'Sent_Complaints') {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                    builder: (context) => Complaints()
                ));
              } else if (title == 'New_Connection') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Payment(),
                ));
              } else if (title == 'View_notification') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Viewnot(),
                ));
              } else if (title == 'View_meter_reading') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Viewreading(),
                ));
              }else if (title == 'View_profile') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => profile(),
                ));
              }
              else if (title == 'Logout') {
                localStorage = await SharedPreferences.getInstance();
                localStorage.setBool('login', true);
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => Login()));

              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                Center(
                  child: Text(title,
                      style: TextStyle(fontSize: 18.0, color: Colors.black)),
                )

              ],

            ),
          ),
        ),
            );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User_home'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/img_7.png"),fit: BoxFit.cover)
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  padding: EdgeInsets.all(3.0),
                  children: <Widget>[
                    makeDashboardItem("New_Connection", Icons.water_sharp),
                    makeDashboardItem("Sent_Complaints", Icons.edit_calendar_rounded),
                    makeDashboardItem("View_notification", Icons.details),
                    makeDashboardItem("View_meter_reading",Icons.read_more),
                    makeDashboardItem("View_profile", Icons.contact_page),
                    makeDashboardItem("Logout", Icons.logout),
                    //  makeDashboardItem("Logout", Icons.logout),
                  ]
                ),
            ],
          ),
        ),
      ),
      );
  }
}
