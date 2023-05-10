import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jalanidhi/meter_reader/Meter_reading.dart';
import 'package:jalanidhi/user/Home%20page.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'View_meter_reading.dart';

class Charge extends StatefulWidget {
 late final int id;
 late final String rs;
 Charge({required this.id,required this.rs});

  @override
  State<Charge> createState() => _ChargeState();
}
enum Gender { credit_card,debit_card,net_banking }
  Gender? _payment = Gender.credit_card;
  String? payment;

class _ChargeState extends State<Charge> {

  late SharedPreferences localStorage;
  late int user_id;
  TextEditingController payment_typecontroller=TextEditingController();
  TextEditingController amountcontroller=TextEditingController();
  TextEditingController connection_datecontroller=TextEditingController();
  bool _isLoading=false;
  void registerUser()async {
    localStorage = await SharedPreferences.getInstance();
    user_id = (localStorage.getInt('user_id') ?? 0);
    amountcontroller.text=widget.rs;
    print(amountcontroller.text);
    setState(() {
      _isLoading = true;
    });

    var data = {
      "consumer": user_id.toString(),
      "reading_amount": amountcontroller.text,
    };
    print(data);
    var res = await Api().authData(data,'/api/meter_reading_payment');
    var body = json.decode(res.body);
    print(body);
    if(body['success']==true)
    {
      print(body);

      _showDialog(context);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      _showDialog(context);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>userhome()));

    }
    else
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

    }
  }

  Future<void> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("payment successfull"),
            content: Image.asset("images/img_11.png"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context)=>userhome())),

          child: const Text('OK'),
              ),
            ],
          );
        });
  }

  @override

  Widget build(BuildContext context) {
    TextEditingController datecontroller=TextEditingController();
    return MaterialApp(
      home: Scaffold( appBar: AppBar(
        title: Text("SERVICE_CHARGE"),
        leading:IconButton(
          icon:Icon(Icons.arrow_back), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewreading()));
        },
        ),
      ),
        body: Container(
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text("Service charge",
              //   style: TextStyle(
              //     fontSize: 20,
              //     color: Colors.green,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: Align(
                    alignment: Alignment.centerLeft, child: Text("payment *")),
              ),
              ListTile(
                title: const Text('Credit_card'),
                leading: Radio<Gender>(
                  value: Gender.credit_card,
                  groupValue: _payment,
                  onChanged: (Gender? value) {
                    setState(() {
                      _payment = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Debit_card'),
                leading: Radio<Gender>(
                  value: Gender.debit_card,
                  groupValue: _payment,
                  onChanged: (Gender? value) {
                    setState(() {
                      _payment = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Net_banking'),
                leading: Radio<Gender>(
                  value: Gender.net_banking,
                  groupValue: _payment,
                  onChanged: (Gender? value) {
                    setState(() {
                      _payment = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: amountcontroller,
                readOnly: true,
                decoration: InputDecoration(
                labelText:widget.rs ,
                hintText: widget.rs,
                hintStyle: TextStyle(
                    color: Colors.green
                ),
                border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              ),
              // SizedBox(height: 30),
              // TextField(
              //   maxLines: 3,
              //   decoration: InputDecoration(
              //     enabled: false,
              //     labelText: "Card details",
              //     hintText: "details",
              //     border:
              //     OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              //   ),
              // ),
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
                      registerUser();
                    } ,
                    child: Text("CONTINUE")),
              ),
              SizedBox(height: 30),





            ],
          ),),
      ),);
  }
}
