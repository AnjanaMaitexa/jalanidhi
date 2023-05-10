
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jalanidhi/sub_admin/manage_area.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddArea extends StatefulWidget {
  const AddArea({Key? key}) : super(key: key);

  @override
  State<AddArea> createState() => _AddAreaState();
}

class _AddAreaState extends State<AddArea> {
  TextEditingController typecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController wardno = TextEditingController();
  bool _isLoading = false;

  List department = [];
  List _loadreader = [];
  var dropDownValue;
  late SharedPreferences prefs;
  late int login_id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _fetchReader();
  }

  _fetchReader() async {
    var res = await Api()
        .getData('/api/all_meter_reader');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];

      setState(() {
        _loadreader = items;
      });
    } else {
      setState(() {
        _loadreader = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }

  void addComplaint() async {
    prefs = await SharedPreferences.getInstance();
    login_id = (prefs.getInt('user_id') ?? 0);
    print("userid${login_id}");

    setState(() {
      _isLoading = true;
    });

    var data = {
      "sub_admin": login_id.toString(),
      "panchayath_type": typecontroller.text,
      "panchayath_name": namecontroller.text,
      "ward_no": wardno.text,
      "meter_reader": dropDownValue,
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
          builder: (context) => Managearea(),
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
    return Scaffold(
        backgroundColor: Color(0xF5FFFFFF),
        bottomNavigationBar: ElevatedButton(
            style: ElevatedButton.styleFrom
              (backgroundColor: Colors.lightBlueAccent),
            onPressed: () {
              addComplaint();
              // Navigator.of(context).push( MaterialPageRoute(builder: (context)=>View_Comp()));
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 115, left: 115),
              child: Text(
                'SUBMIT',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )),
        appBar: AppBar(
          title: Text("Add Panchayath"),
          backgroundColor: Colors.lightBlueAccent,
          leading: IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Subadmin_home(),
            ));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(

              children: [
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Panchayath type',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black38),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: typecontroller,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText:   'Panchayath type',),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'PanchayathName',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black38),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: namecontroller,
                  // controller: _vehicleNoController,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: 'Panchayath Name'),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'WardNo',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black38),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: wardno,
                  // controller: _vehicleNoController,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: 'WardNo'),
                ),

                SizedBox(height: 10),
                SizedBox(
                  width: double.maxFinite,
                  child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      hint: Text('MeterReaders'),
                      value: dropDownValue,
                      items: _loadreader
                          .map((type) =>
                          DropdownMenuItem<String>(
                            value: type['id'].toString(),
                            child: Text(
                              type['meter_reader_name'].toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ))
                          .toList(),
                      onChanged: (type) {
                        setState(() {
                          dropDownValue = type;
                        });
                      }),
                ),


              ],
            ),
          ),
        ));
  }
}
