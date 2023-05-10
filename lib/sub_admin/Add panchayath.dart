import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jalanidhi/sub_admin/View_meter_reader.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login.dart';
import '../user/Add_reader.dart';
import '../user/api.dart';

class area extends StatefulWidget {
  final int id;

  area({required this.id});

  @override
  State<area> createState() => _areaState();
}

class _areaState extends State<area> {

  String? valuechoose;
  late SharedPreferences localStorage;
  List StateList = [
    'Grama panchayath',
    'Block panchayath',
    'Jilla Panjayath',
  ];
  late int subid;
  TextEditingController panchayath_typecontroller=TextEditingController();
  TextEditingController panchayath_namecontroller=TextEditingController();
  TextEditingController ward_nocontroller=TextEditingController();
  TextEditingController sub_admincontroller=TextEditingController();
  bool _isLoading=false;
  void registerUser()async {
     localStorage=await SharedPreferences.getInstance();
     subid=(localStorage.getInt('login_id') ?? 0);
    setState(() {
      _isLoading = true;
    });

    var data = {
      "panchayath_type": panchayath_typecontroller.text,
      "panchayath_name": panchayath_namecontroller.text,
      "ward_no": ward_nocontroller.text,
      "sub_admin": sub_admincontroller.text,

    };
    print(data);
    var res = await Api().authData(data,'/api/panchayath_details');
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

  TextEditingController typecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController wardno = TextEditingController();


  List department = [];
  List _loadreader = [];
  var dropDownValue;
  late SharedPreferences prefs;
  late int login_id;

  void addComplaint() async {
    int reader=widget.id;
    prefs = await SharedPreferences.getInstance();
    login_id = (prefs.getInt('user_id') ?? 0);
    print("userid${login_id}");

    setState(() {
      _isLoading = true;
    });

    var data = {
      "sub_admin": login_id.toString(),
      "panchayath_type": valuechoose,
      "panchayath_name": namecontroller.text,
      "ward_no": wardno.text,
      "meter_reader": reader.toString(),
    };
    print(data);

    var res = await Api().authData(data, '/api/panchayath_details');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print("suuc${body}");
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
      Navigator.push(
        this.context, //add this so it uses the context of the class
        MaterialPageRoute(
          builder: (context) => View_reader(),
        ), //MaterialpageRoute
      );
      //   Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context)=>View_Comp()));

    }
    else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  @override
        Widget build(BuildContext context) {
      return Scaffold( appBar: AppBar(
        title: Text("ADD Panchayath"),
        leading:IconButton(
          icon:Icon(Icons.arrow_back), onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>Add_reader()));
        },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [


                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 5,right: 5,top: 10),
                    decoration:
                        BoxDecoration(
                          border: Border.all(color: Colors.grey,width: 1),
                            borderRadius: BorderRadius.circular(30)),
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 36,
                      isExpanded: true,
                      underline: SizedBox(),
                      hint: Text("select panchayath"),
                      value: valuechoose,
                      onChanged: (newvalue) {
                        setState(() {
                          valuechoose = newvalue.toString();
                        });
                      },
                      items: StateList.map((valuestate) {
                        return DropdownMenuItem(
                            value: valuestate, child: Text(valuestate));
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    labelText: "Panchayath name",
                    hintText: "name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
          SizedBox(height: 10),
          TextField(
            controller: wardno,
            decoration: InputDecoration(
              labelText: "Ward no",
              hintText: "ward no",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
                // SizedBox(height: 10),
                // TextField(
                //   decoration: InputDecoration(
                //     labelText: "Status",
                //     hintText: "status",
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(30)),
                //   ),
                // ),
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
                    addComplaint();
                  } ,
                  child: Text("SEND")),
           ),


        ],
            ),
      ),
        );
  }
}
