import 'package:flutter/material.dart';
import 'package:jalanidhi/sub_admin/User_complaints.dart';
import 'package:jalanidhi/sub_admin/View_complaint.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/Home%20page.dart';
class Reply extends StatefulWidget {
  const Reply({Key? key}) : super(key: key);

  @override
  State<Reply> createState() => _ReplyState();
}

class _ReplyState extends State<Reply> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold( appBar: AppBar(
          title: Text("REPLY"),
          leading:IconButton(
            icon:Icon(Icons.arrow_back), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>View_complaint()));
          },
          ),
        ),
          body: Container(
            // ignore: prefer_const_literals_to_create_immutables
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Reply",
                hintText: "reply",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Subadmin_home()));
                  } ,
                  child: Text("SEND")),
            ),
          ]
            ),
              ),
    ),
    );
  }
}
