import 'package:flutter/material.dart';
import 'package:jalanidhi/login.dart';
import 'package:jalanidhi/meter_reader/View_panchayath.dart';
import 'package:jalanidhi/meter_reader/View_notification.dart';
import 'package:jalanidhi/meter_reader/Meter_reading.dart';
import 'package:jalanidhi/meter_reader/singlearea.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Reader_notification.dart';
class Reader_home extends StatefulWidget {
  const Reader_home({Key? key}) : super(key: key);
  @override
  State<Reader_home> createState() => _Reader_homeState();
}
class _Reader_homeState extends State<Reader_home> {
  late SharedPreferences localStorage;

  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: InkWell(
            onTap: () async {
              if (title == 'Meter_readings') {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                    builder: (context) => Reading()
                ));
              // } else if (title == 'New_Connection') {
              //   Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => reg(),
              //   ));
              } else if (title == 'View_area') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Singlearea(),
                ));
              } else if (title == 'View_notification') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>Viewnot(),// Reader_not(),
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
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('METER_READER_HOME'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){},
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/img_7.png"),fit: BoxFit.cover)
        ),
        child: Column(
          children: [
            GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                padding: EdgeInsets.all(3.0),
                children: <Widget>[
                  makeDashboardItem("Meter_readings", Icons.storage),
                  makeDashboardItem("View_area", Icons.view_carousel),
                  makeDashboardItem("View_notification", Icons.details),
                   makeDashboardItem("Logout", Icons.logout),
                ]
            ),
          ],
        ),
      ),
    );
  }
}
