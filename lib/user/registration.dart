import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jalanidhi/login.dart';
import 'package:jalanidhi/user/Connection_payment.dart';

import 'api.dart';

class reg extends StatefulWidget {
  const reg({Key? key}) : super(key: key);

  @override
  State<reg> createState() => _regState();
}

enum Gender { male, female, other }

class _regState extends State<reg> {
  Gender? _gen = Gender.male;
  var children;
  String? gender;
  String? categ;
  String dropdownvalue = 'Select Panchayath';
  File? imageFile;
  // List of items in our dropdown menu
  var items = [
    'Select Panchayath',
    'Grama panchayath',
    'Jilla panchayath',
    'Block panchayath',
  ];
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choose from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.pop(context);
                      //  _openGallery(context);
                    },
                  ),
                  SizedBox(height: 10),
                  const Padding(padding: EdgeInsets.all(0.0)),
                  GestureDetector(
                    child: const Text("Camera"),
                    onTap: () {
                      _getFromCamera();

                      Navigator.pop(context);
                      //   _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }


  final _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller=TextEditingController();
  TextEditingController house_namecontroller=TextEditingController();
  TextEditingController datecontroller=TextEditingController();
  TextEditingController house_nocontroller=TextEditingController();
  TextEditingController aadhar_nocontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController gendercontroller=TextEditingController();
  TextEditingController pin_codecontroller=TextEditingController();
  TextEditingController phone_nocontroller=TextEditingController();
  TextEditingController districtcontroller=TextEditingController();
  TextEditingController panchayath_namecontroller=TextEditingController();
  TextEditingController ward_nocontroller=TextEditingController();
  TextEditingController categorycontroller=TextEditingController();
  // TextEditingController category_proofcontroller=TextEditingController();
  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  bool _isLoading=false;
  void registerUser()async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "name": namecontroller.text,
      "house_name": house_namecontroller.text,
      "dob": datecontroller.text,
      "house_no": house_nocontroller.text,
      "aadhar_no":  aadhar_nocontroller.text,
      "email": emailcontroller.text,
      "gender": _gen.toString(),
      "pin_code": pin_codecontroller.text,
      "phone_no": phone_nocontroller.text,
      "panchayath_type": dropdownvalue.toString(),
      "ward_no": ward_nocontroller.text,
      "category":categ.toString(),
      "category_proof":"image",
      "panchayath_name": panchayath_namecontroller.text,
      // "email": category_proofcontroller.text,
      "username": usernamecontroller.text,
      "password": passwordcontroller.text,
    };
    print(data);
    var res = await Api().authData(data,'/api/consumer_register');
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
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTRATION"),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(

            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
              ),
              SizedBox(height: 30),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Field can't be empty";
                  }
                },
                controller: namecontroller,
                decoration: InputDecoration(
                  labelText: "Consumer Name",
                  hintText: "name",
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Field can't be empty";
                  }
                },
                controller: house_namecontroller,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: "House name",
                  hintText: "house name",
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: datecontroller,
                        onTap: () async{
                          DateTime? pickedDate= await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100)
                          );
                          if(pickedDate!=null){
                            datecontroller.text=
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
              SizedBox(height: 10),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Field can't be empty";
                  }
                },
                controller: house_nocontroller,
                decoration: InputDecoration(
                  labelText: "House no",
                  hintText: "house no",
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Field can't be empty";
                  }
                },
                controller: aadhar_nocontroller,
                decoration: InputDecoration(
                  labelText: "Aadhaar no",
                  hintText: "aadhaar no",
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Field can't be empty";
                  }
                },

                controller: emailcontroller,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "email",
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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
              SizedBox(height: 10),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Field can't be empty";
                  }
                },
                controller: pin_codecontroller,
                decoration: InputDecoration(
                  labelText: "Pincode",
                  hintText: "pin",
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Field can't be empty";
                  }
                },
                keyboardType: TextInputType.number,
                controller: phone_nocontroller,
                decoration: InputDecoration(
                    labelText: "Phone no",
                    hintText: "phone",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
              SizedBox(height: 10),
              Container(
                width: double.maxFinite,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black38),
                ),
                child: DropdownButton(
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(items),
                      ),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Field can't be empty";
                  }
                },
                controller:panchayath_namecontroller,
                decoration: InputDecoration(
                    labelText: "Panchayath name",
                    hintText: "name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Field can't be empty";
                  }
                },
                controller: ward_nocontroller,
                decoration: InputDecoration(
                    labelText: "Ward no",
                    hintText: "ward no",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "Category",
                      style: TextStyle(fontSize: 16),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text("APL"),
                        value: "Apl",
                        groupValue: categ,
                        onChanged: (value) {
                          setState(() {
                            categ = value.toString();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text("BPL"),
                        value: "Bpl",
                        groupValue: categ,
                        onChanged: (value) {
                          setState(() {
                            categ = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Row(children: [
                Container(),
                SizedBox(height: 40),
                Row(
                  children: [
                    Container(
                      child: imageFile == null
                          ? Container(
                              child: Column(
                                children: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      //    _getFromGallery();
                                      _showChoiceDialog(context);
                                    },
                                    child: Text("Upload Image"),
                                  ),
                                  Container(
                                    height: 40.0,
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Image.file(
                                    imageFile!,
                                    width: 100,
                                    height: 100,
                                    //  fit: BoxFit.cover,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    //    _getFromGallery();
                                    _showChoiceDialog(context);
                                  },
                                  child: Text("Upload Image"),
                                ),
                              ],
                            ),

                    ),
                  ],
                ),
              ]),
              SizedBox(height: 10),
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
                        borderRadius: BorderRadius.circular(30))),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Field can't be empty";
                  }
                },
                obscureText: true,
                controller: passwordcontroller,
                decoration: InputDecoration(
                    labelText: "password",
                    hintText: "password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    // padding: EdgeInsets.all(20)
                  ),
                  onPressed: () {
                    registerUser();
                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment()));
                  },
                  child: Text("SUBMIT")),
            ]),
          ),
        )
      ]),
    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}
