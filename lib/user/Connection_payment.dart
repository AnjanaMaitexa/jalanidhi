import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jalanidhi/user/Home%20page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';
import 'api.dart';

class Payment extends StatefulWidget {
  const Payment ({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}
enum Gender { credit_card,debit_card,net_banking }
Gender? _payment = Gender.credit_card;
String? payment;

class _PaymentState extends State<Payment> {
  DateTime? _selectDate;

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
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  late SharedPreferences localStorage;
  late int user_id;
  TextEditingController payment_typecontroller=TextEditingController();
  TextEditingController amountcontroller=TextEditingController();
  TextEditingController connection_datecontroller=TextEditingController();
  bool _isLoading=false;
  void registerUser()async {
    localStorage = await SharedPreferences.getInstance();
    user_id = (localStorage.getInt('user_id') ?? 0);
    amountcontroller.text="1500";
    setState(() {
      _isLoading = true;
    });

    var data = {
      "consumer": user_id.toString(),
      "connection_amt": amountcontroller.text,
    };
    print(data);
    var res = await Api().authData(data,'/api/consumer_connection');
    var body = json.decode(res.body);
    print(body);
    if(body['success']==true)
    {
      print(body);
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

  @override
  Widget build(BuildContext context) {
    TextEditingController datecontroller=TextEditingController();


    return MaterialApp(
      home: Scaffold( appBar: AppBar(
        title: Text("PAYMENT DEATAILS"),
        leading:IconButton(
          icon:Icon(Icons.arrow_back), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>userhome()));
        },
        ),
      ),
        body: Container(
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text("Payment",
              //   style: TextStyle(
              //     fontSize: 20,
              //     color: Colors.green,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: Align(
                    alignment: Alignment.centerLeft, child: Text("payment_type *")),
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
                readOnly: true,
                controller: amountcontroller,
                decoration: InputDecoration(
                  labelText: "1500",
                  hintText: "1500",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              // SizedBox(height: 30),
              // TextField(decoration: InputDecoration(
              //   enabled: false,
              //   labelText:"Card/transaction details" ,
              //   hintText: "details",
              //   hintStyle: TextStyle(
              //       color: Colors.green
              //   ),
              //   border:OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(30)),
              // ),
              // ),
     SizedBox(
                height: 30,
              ),

              // Row(
              //     children: [
              //       Expanded(
              //         child: TextField(
              //           controller: datecontroller,
              //           onTap: () async{
              //             DateTime? pickedDate= await showDatePicker(
              //                 context: context,
              //                 initialDate: DateTime.now(),
              //                 firstDate: DateTime(2000),
              //                 lastDate: DateTime(2100)
              //             );
              //             if(pickedDate!=null){
              //               datecontroller.text=
              //                   DateFormat('yyyy-mm-dd').format(pickedDate);
              //             }
              //           },
              //           decoration: InputDecoration(
              //             prefixIcon: Icon(Icons.date_range),
              //             hintText: "Date",
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(30),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ]
              //
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
