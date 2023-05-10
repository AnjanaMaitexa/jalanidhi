import 'package:flutter/material.dart';
import 'package:jalanidhi/login.dart';
import 'package:jalanidhi/sub_admin/consumer.dart';
import 'package:jalanidhi/sub_admin/manage_area.dart';
import 'package:jalanidhi/sub_admin/payments.dart';
import 'package:jalanidhi/user/profile.dart';
import 'package:jalanidhi/user/Complaints.dart';
import 'package:jalanidhi/user/registration.dart';
import 'package:jalanidhi/sub_admin/View_complaint.dart';
import 'package:jalanidhi/meter_reader/View_notification.dart';
import 'package:jalanidhi/user/sent_complaint.dart';
import 'package:jalanidhi/sub_admin/Add panchayath.dart';
import 'package:jalanidhi/sub_admin/profile.dart';
import 'package:jalanidhi/sub_admin/View_connection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../user/Complaint_view.dart';
import 'View_meter_reader.dart';
import '../user/View_Connection.dart';
import '../user/View_consumers.dart';
import 'User_complaints.dart';
import 'View_payment.dart';
class Subadmin_home extends StatefulWidget {
  const Subadmin_home({Key? key}) : super(key: key);
  @override
  State<Subadmin_home> createState() => _Subadmin_homeState();
}
class _Subadmin_homeState extends State<Subadmin_home> {
  late SharedPreferences localStorage;
  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child: InkWell(
            onTap: () async {
            /*  if (title == 'View_Complaint') {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                    builder: (context) => Cmplt_view(),
                ));
              } else*/ if (title == 'View_consumers') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Viewconsumers(),
                ));
              } else if (title == 'Connection_mgmnt') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Vcnnctn(),
                ));
              // } else if (title == 'View_payment') {
              //   Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => View_payment (),
              //   ));
              } else if (title == 'Meter_reader_mgmnt') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => View_reader(),
                ));
              }
                else if (title == 'ManagePanchayath') {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Managearea(),
                  ));
                }
                else if (title == 'Payments') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Payments(),
                ));
              }
                else if (title == 'Logout') {
                  localStorage = await SharedPreferences.getInstance();
                  localStorage.setBool('login', true);
                  Navigator.pushReplacement(context,
                      new MaterialPageRoute(builder: (context) => Login()));

                }
                else{
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => Subadmin_home()));

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
        title: Text('SUBADMIN_HOME'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){},
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/img_7.png"),fit: BoxFit.cover)
        ),
        child:SingleChildScrollView(
    child: Column(
          children: [
            GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                padding: EdgeInsets.all(3.0),
                children: <Widget>[
             //     makeDashboardItem("View_Complaint", Icons.display_settings),
                  makeDashboardItem("Connection_mgmnt", Icons.link),
                  makeDashboardItem("Meter_reader_mgmnt", Icons.read_more),
                  makeDashboardItem("View_consumers", Icons.image_search_outlined),
                  makeDashboardItem("ManagePanchayath", Icons.location_city),
                  makeDashboardItem("Payments", Icons.payments),
                  makeDashboardItem("Logout", Icons.logout),
                  // makeDashboardItem("View_payment", Icons.view_sidebar)

                  //  makeDashboardItem("Logout", Icons.logout),
                ]
            ),
          ],
        ),
      ),
    )
    );
  }
}
