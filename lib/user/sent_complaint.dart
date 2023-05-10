
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jalanidhi/user/Complaints.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddComplaint extends StatefulWidget {
  const AddComplaint({Key? key}) : super(key: key);

  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  TextEditingController _compcontroller = TextEditingController();
  TextEditingController _descontroller = TextEditingController();
  bool _isLoading = false;
  TextEditingController controller=TextEditingController();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  late SharedPreferences localStorage;
  late int user_id;
  final _formKey = GlobalKey<FormState>();

  void registerComplaint()async {
    localStorage = await SharedPreferences.getInstance();
    user_id = (localStorage.getInt('user_id') ?? 0);
    print('user_id ${user_id}');
    setState(() {
      _isLoading = true;
    });

    var data = {
      "consumer": user_id.toString(),
      "complaint": _compcontroller.text,
      "date": formattedDate,

    };
    print("patient data${data}");
    var res = await Api().authData(data,'/api/consumer_complaints');
    var body = json.decode(res.body);

    if(body['success']==true)
    {
      print('res${body}');
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Complaints()));
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

    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color(0xF5FFFFFF) ,
        appBar: AppBar(
          title: Text(" Complaints"),
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key:_formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(

                children: [

                  SizedBox(height: 30),
                  Text(
                    'Add Complaint',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Complaint',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black38),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _compcontroller,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        hintText: 'Complaint'),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Description',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black38),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _descontroller,
                    // controller: _vehicleNoController,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        hintText: 'Description'),
                  ),
                  SizedBox(height: 100),


                  GestureDetector(
                    onTap: (){
                      registerComplaint();

                    },
                    child: Container(
                      width: w*0.5,
                      height:h*0.08,
                      color:  Color(0xFF772F16),
                      child: Center(
                        child: Text("Submit",style:TextStyle(
                            fontSize:36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

}