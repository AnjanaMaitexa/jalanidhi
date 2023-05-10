import 'package:flutter/material.dart';
import 'package:jalanidhi/login.dart';
import 'package:jalanidhi/user/meter_reader_reg.dart';
import 'package:jalanidhi/user/registration.dart';
import 'package:jalanidhi/user/subadmin_reg.dart';
class MainDash extends StatelessWidget {
  const MainDash({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainDashB(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainDashB extends StatefulWidget {
  const MainDashB({super.key, required this.title});

  final String title;

  @override
  State<MainDashB> createState() => _MainDashBState();
}

class _MainDashBState extends State<MainDashB> {

  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child:  InkWell(
            onTap: () {},
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
                  child:  Text(title,
                      style:
                      TextStyle(fontSize: 18.0, color: Colors.black)),
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
        title: Text("Jalanidhi"),
        leading:IconButton(
          icon:Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Login()));
          },
        ),
        /// elevation: .1,
        backgroundColor: Color.fromRGBO(49, 87, 110, 1.0),),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text( "Registration",
              style:TextStyle(
                  fontSize:20,
                  fontWeight:FontWeight.bold,
                  color:Colors.teal
              ),),
          ), SizedBox(
            height: 40,
          ),
          //  GridView.count(
          //   shrinkWrap: true,
          //    crossAxisCount: 2,
          //    padding: EdgeInsets.all(3.0),
          //    children: <Widget>[
          //      makeDashboardItem("USER", Icons.person_2),
          //      makeDashboardItem("COMPANY", Icons.business),
          //      makeDashboardItem("DEPARTMENT", Icons.factory),
          //    ],
          //  ),
          GridView(

            shrinkWrap: true,
            padding: EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10),

            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>reg()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:Colors.green,
                  ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person,size:50,color:Colors.white),
                      Text("CONSUMER",
                          style:
                          TextStyle(fontSize: 18.0, color: Colors.white)),
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>sub_reg()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:Colors.green,
                  ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.business,size:50,color:Colors.white),
                      Text("SUB ADMIN",
                          style:
                          TextStyle(fontSize: 18.0, color: Colors.white)),
                    ],
                  ),),
              ),
              InkWell(
                onTap: (){
                   Navigator.push(context,MaterialPageRoute(builder: (context)=>meter_reg()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:Colors.green,
                  ),
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.factory,size:50,color:Colors.white),
                      Text("METER READER",
                          style:
                          TextStyle(fontSize: 18.0, color: Colors.white)),
                    ],
                  ),),
              )
            ],)
        ],
      ),
    );
  }
}