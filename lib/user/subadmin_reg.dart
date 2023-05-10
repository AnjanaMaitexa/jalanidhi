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

class sub_reg extends StatefulWidget {
  const sub_reg({Key? key}) : super(key: key);

  @override
  State<sub_reg> createState() => _sub_regState();
}
enum Gender { male, female, other }

 class _sub_regState extends State<sub_reg> {
  Gender? _gen = Gender.male;

  final _formKey = GlobalKey<FormState>();
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


  TextEditingController subadmin_namecontroller=TextEditingController();
  TextEditingController subadmin_districtcontroller=TextEditingController();
  TextEditingController subadmin_citycontroller=TextEditingController();
  TextEditingController subadmin_datecontroller=TextEditingController();
  TextEditingController subadmin_pincodecontroller=TextEditingController();
  TextEditingController subadmin_phonenocontroller=TextEditingController();
  TextEditingController subadmin_gendercontroller=TextEditingController();
  TextEditingController subadmin_emailcontroller=TextEditingController();
  // TextEditingController category_proofcontroller=TextEditingController();
  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  bool _isLoading=false;
  void registerUser()async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "subadmin_name": subadmin_namecontroller.text,
      "subadmin_district": subadmin_districtcontroller.text,
      "subadmin_city": subadmin_citycontroller.text,
      "subadmin_dob": subadmin_datecontroller.text,
      "subadmin_pincode":  subadmin_pincodecontroller.text,
      "subadmin_phoneno": subadmin_phonenocontroller.text,
      "subadmin_gender": _gen.toString(),
      "subadmin_email": subadmin_emailcontroller.text,
      "username": usernamecontroller.text,
      "password": passwordcontroller.text,
    };
    print(data);
    var res = await Api().authData(data,'/api/subadmin_register');
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
      title: Text("SUB ADMIN REGISTRATION"),
      leading:IconButton(
        icon:Icon(Icons.arrow_back), onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
      },
      ),
    ),

      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: ListView(children: [
          SizedBox(height: 30),
          TextFormField(
            validator: (value){
              if(value == null || value.isEmpty){
                return "Field can't be empty";
              }
            },
            controller: subadmin_namecontroller,
            decoration: InputDecoration(
              labelText: "subadmin_name",
              hintText: "subadmin_name",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            validator: (value){
              if(value == null || value.isEmpty){
                return "Field can't be empty";
              }
            },
            controller: subadmin_districtcontroller,
            decoration: InputDecoration(
              labelText: "subadmin_district",
              hintText: "subadmin_district",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            validator: (value){
              if(value == null || value.isEmpty){
                return "Field can't be empty";
              }
            },
            controller: subadmin_citycontroller,
            decoration: InputDecoration(
              labelText: "subadmin_city",
              hintText: "subadmin_city",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          SizedBox(height: 30),
          Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: subadmin_datecontroller,
                    onTap: () async{
                      DateTime? pickedDate= await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100)
                      );
                      if(pickedDate!=null){
                        subadmin_datecontroller.text=
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
          TextFormField(
            validator: (value){
              if(value == null || value.isEmpty){
                return "Field can't be empty";
              }
            },
            controller: subadmin_pincodecontroller,
            decoration: InputDecoration(
              labelText: "subadmin_pincode",
              hintText: "subadmin_pincode",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            validator: (value){
              if(value == null || value.isEmpty){
                return "Field can't be empty";
              }
            },
            controller: subadmin_phonenocontroller,
            decoration: InputDecoration(
              labelText: "subadmin_phone_no",
              hintText: "subadmin_phoneno",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            validator: (value){
              if(value == null || value.isEmpty){
                return "Field can't be empty";
              }
            },
            controller: subadmin_emailcontroller,
            decoration: InputDecoration(
              labelText: "subadmin_email",
              hintText: "subadmin_email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10),
            child: Align(
                alignment: Alignment.centerLeft, child: Text("Gender *")),
          ),
          ListTile(
            title: const Text('Male'),
            leading: Radio<Gender>(
              value: Gender.male,
              groupValue: _gen,
              onChanged: (Gender? value) {
                setState(() {
                  _gen = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Female'),
            leading: Radio<Gender>(
              value: Gender.female,
              groupValue: _gen,
              onChanged: (Gender? value) {
                setState(() {
                  _gen = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Other'),
            leading: Radio<Gender>(
              value: Gender.other,
              groupValue: _gen,
              onChanged: (Gender? value) {
                setState(() {
                  _gen = value;
                });
              },
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            validator: (value){
              if(value == null || value.isEmpty){
                return "Field can't be empty";
              }
            },
            controller: usernamecontroller,
            decoration: InputDecoration(
              labelText: "username",
              hintText: "username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
          SizedBox(height: 30),
          TextFormField(
            validator: (value){
              if(value == null || value.isEmpty){
                return "Field can't be empty";
              }
            },
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
                  // Navigator.push(context,MaterialPageRoute(builder: (context)=>Subadmin_home()));
                } ,
                child: Text("SEND")),
          ),
        ],
        ),
      ),
    );
  }
}
