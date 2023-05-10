import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';

import '../login.dart';
import '../sub_admin/Add panchayath.dart';
import '../sub_admin/View_meter_reader.dart';
import 'api.dart';

class meter_reg extends StatefulWidget {
  const meter_reg({Key? key}) : super(key: key);

  @override
  State<meter_reg> createState() => _meter_regState();
}
enum Gender { male, female, other }

class _meter_regState extends State<meter_reg> {
  Gender? _gen = Gender.male;
  var children;
  String? gender;
  String? categ;
  String dropdownvalue = 'Select district';
  // List of items in our dropdown menu
  var items = [
    'Select district',
    'Kasargode',
    'Kannur',
    'Kozhikode',
    'Eranakulam',
    'Kottayam',
    'Edukki',
    'Malappuram',
    'Palakkad',
    'Kollam',
    'Thiruvanandapuram',
    'Wayanad',
    'Alappuzha',
    'Thrissur',
    'Pathanamthitta',
  ];


  TextEditingController meter_reader_namecontroller=TextEditingController();
  TextEditingController meter_reader_districtcontroller=TextEditingController();
  TextEditingController meter_reader_citycontroller=TextEditingController();
  TextEditingController meter_reader_datecontroller=TextEditingController();
  TextEditingController meter_reader_pincodecontroller=TextEditingController();
  TextEditingController meter_reader_phonenocontroller=TextEditingController();
  TextEditingController meter_reader_emailcontroller=TextEditingController();
  TextEditingController meter_reader_gendercontroller=TextEditingController();
  // TextEditingController category_proofcontroller=TextEditingController();
  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  bool _isLoading=false;
  void registerUser()async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "meter_reader_name": meter_reader_namecontroller.text,
      "meter_reader_district": meter_reader_districtcontroller.text,
      "meter_reader_city": meter_reader_citycontroller.text,
      "meter_reader_dob": meter_reader_datecontroller.text,
      "meter_reader_pincode":  meter_reader_pincodecontroller.text,
      "meter_reader_phoneno": meter_reader_phonenocontroller.text,
      "meter_reader_gender": _gen.toString(),
       "meter_reader_email": meter_reader_emailcontroller.text,
      "username": usernamecontroller.text,
      "password": passwordcontroller.text,
    };
    print(data);
    var res = await Api().authData(data,'/api/meter_reader_register');
    var body = json.decode(res.body);

    if(body['success']==true)
    {
      print(body);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

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
    return Scaffold( appBar: AppBar(
      title: Text("METER READER REGISTRATION"),
      leading:IconButton(
        icon:Icon(Icons.arrow_back), onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
      },
      ),
    ),

      body: ListView(children: [
        SizedBox(height: 30),
        TextField(
          controller: meter_reader_namecontroller,
          decoration: InputDecoration(
            labelText: "meter_reader_name",
            hintText: "reder_name",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          controller: meter_reader_districtcontroller,
          decoration: InputDecoration(
            labelText: "meter_reader_district",
            hintText: "reder_district",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          controller: meter_reader_citycontroller,
          decoration: InputDecoration(
            labelText: "meter_reader_city",
            hintText: "reder_city",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
        SizedBox(height: 30),
        Row(
            children: [
              Expanded(
                child: TextField(
                  controller: meter_reader_datecontroller,
                  onTap: () async{
                    DateTime? pickedDate= await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100)
                    );
                    if(pickedDate!=null){
                      meter_reader_datecontroller.text=
                          DateFormat('yyyy-mm-dd').format(pickedDate);
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range),
                    hintText: "DOB",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ]
        ),
        SizedBox(height: 30),
        TextField(
          controller: meter_reader_pincodecontroller,
          decoration: InputDecoration(
            labelText: "meter_reader_pincode",
            hintText: "reder_pincode",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          controller: meter_reader_phonenocontroller,
          decoration: InputDecoration(
            labelText: "meter_reader_phone_no",
            hintText: "reder_phoneno",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          controller: meter_reader_emailcontroller,
          decoration: InputDecoration(
            labelText: "meter_reader_email",
            hintText: "reader_email",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10),
          child: Align(
              alignment: Alignment.centerLeft, child: Text("Gender *")),
        ),
        RadioListTile(
          title: Text("Male"),
          value: "male",
          groupValue: gender,
          onChanged: (value){
            setState(() {
              gender = value.toString();
            });
          },
        ),

        RadioListTile(
          title: Text("Female"),
          value: "female",
          groupValue: gender,
          onChanged: (value){
            setState(() {
              gender = value.toString();
            });
          },
        ),

        RadioListTile(
          title: Text("Other"),
          value: "other",
          groupValue: gender,
          onChanged: (value){
            setState(() {
              gender = value.toString();
            });
          },
        ),
        SizedBox(height: 30),
        TextField(
          controller: usernamecontroller,
          decoration: InputDecoration(
            labelText: "username",
            hintText: "username",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          controller: passwordcontroller,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "password",
            hintText: "password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30)),
          ),
        ),
        SizedBox(height: 30),

        SizedBox(
          width: 5,
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
              child: Text("SEND")),
        ),
      ],
      ),
    );
  }
}
