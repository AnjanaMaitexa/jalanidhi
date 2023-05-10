import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jalanidhi/meter_reader/Meter_reading.dart';
import 'package:jalanidhi/user/Home%20page.dart';

import 'View_meter_reading.dart';

class Charge extends StatefulWidget {
  const Charge ({Key? key}) : super(key: key);

  @override
  State<Charge> createState() => _ChargeState();
}
enum Gender { credit_card,debit_card,net_banking }
  Gender? _payment = Gender.credit_card;
  String? payment;

class _ChargeState extends State<Charge> {
  Future<void> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("payment successfull"),
            content: Image.asset("images/img_11.png"),

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
              TextField(decoration: InputDecoration(
                labelText:"Charge" ,
                hintText: "charge",
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
                      _showDialog(context);
                    } ,
                    child: Text("CONTINUE")),
              ),
              SizedBox(height: 30),





            ],
          ),),
      ),);
  }
}
