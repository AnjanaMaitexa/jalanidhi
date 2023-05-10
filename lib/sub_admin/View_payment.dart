import 'package:flutter/material.dart';
import 'package:jalanidhi/sub_admin/Reply.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/Home%20page.dart';

class View_payment extends StatefulWidget {
  const View_payment({Key? key}) : super(key: key);

  @override
  State<View_payment> createState() => _View_paymentState();
}

class _View_paymentState extends State<View_payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("VIEW PAYMENT"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder:(context)=>Subadmin_home()));
            },
          ),
        ),
        body: Container(
            alignment: Alignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                SizedBox(height: 30),
                TextField(decoration: InputDecoration(
                  enabled: false,
                  labelText: "Consumer_name",
                  hintText: "name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                ),
                SizedBox(height: 30),
                TextField(decoration: InputDecoration(
                  labelText: "Panchayath_type",
                  hintText: "type",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                ),
                SizedBox(height: 30),
                TextField(decoration: InputDecoration(
                  labelText: "Panchayath_name",
                  hintText: "name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                ),
                SizedBox(height: 30),
                TextField(decoration: InputDecoration(
                  labelText: "Ward_no",
                  hintText: "ward_no",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                ),
                SizedBox(height: 30),
                TextField(decoration: InputDecoration(
                  enabled: false,
                  labelText: "Amount",
                  hintText: "amount",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                ),
                SizedBox(height: 30),
                TextField(decoration: InputDecoration(
                  enabled: false,
                  labelText: "Date",
                  hintText: "date",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                ),
              ],
            )
        )
    );
  }
}
