import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reading extends StatefulWidget {
  const Reading ({Key? key}) : super(key: key);

  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {

  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController readingController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool _isLoading = false;
  late SharedPreferences prefs;
  late String company_id,depart_id;
  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  List person = [];
  String? selectedId;
  var dropDownValue;
  late int login_id;
  Future<void> getLogin() async {
    prefs = await SharedPreferences.getInstance();
    depart_id = (prefs.getString('department_id') ?? '');

  }

  Future getAllperson()async{
    var res = await Api().getData('/api/all_consumer');
    var body = json.decode(res.body);

    setState(() {
      person=body['data'];

      print('compans ${person}');

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllperson();
    getLogin();
  }

  late String startDate;
  late String endDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        startDate='${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
      });
    }
  }
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedEndDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;

        endDate='${selectedEndDate.day}/${selectedEndDate.month}/${selectedEndDate.year}';
      });
    }
  }
  void addReading() async {
    prefs = await SharedPreferences.getInstance();
    login_id = (prefs.getInt('user_id') ?? 0);
    print("userid${login_id}");

    setState(() {
      _isLoading = true;
    });

    var data = {
      "consumer": selectedId,
      "meter_reader":login_id.toString() ,
      "current_meter_reading": readingController.text,
      "meter_reading_date": startDate,
      "meter_reading_duedate": endDate,
      "meter_reading_price": amountController.text,
    };
    print(data);

    var res = await Api().authData(data, '/api/meter_reading');
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
          builder: (context) => Reader_home(),
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
    TextEditingController datecontroller=TextEditingController();
    return MaterialApp(
      home: Scaffold( appBar: AppBar(
        title: Text("METER_READING"),
        leading:IconButton(
          icon:Icon(Icons.arrow_back), onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Reader_home()));
        },
        ),
      ),
              body: Container(
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text("Meter reading",
              //   style: TextStyle(
              //     fontSize: 20,
              //     color: Colors.green,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              SizedBox(height: 30),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                labelText:"Amount" ,
                hintText: "amount",
                hintStyle: TextStyle(
                    color: Colors.green
                ),
                border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: readingController,
                decoration: InputDecoration(
                labelText:"Current_reading" ,
                hintText: "reading",
                hintStyle: TextStyle(
                    color: Colors.green
                ),
                border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              ),
              SizedBox(height: 30),
              Row(

                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      height: 45,
                      width:150 ,
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text('${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black38
                          ),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Start date'),
                  ),
                ],
              ),
              Row(

                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      height: 45,
                      width:150 ,
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text('${selectedEndDate.year}-${selectedEndDate.month}-${selectedEndDate.day}',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black38
                          ),),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  ElevatedButton(
                    onPressed: () => _selectEndDate(context),
                    child: const Text('End date'),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)) ,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    hint: Text('Consumer'),
                    value: selectedId,
                    items: person
                        .map((type) => DropdownMenuItem<String>(
                      value: type['id'].toString(),
                      child: Text(
                        type['name'],
                        style: TextStyle(color: Colors.black),
                      ),
                    ))
                        .toList(),
                    onChanged: (type) {
                      setState(() {
                        selectedId = type;
                      });
                    }),
              ),



              //         SizedBox(
      //           height: 30,
      //         ),
      //
      //         Row(
      //           children: [
      //             Expanded(
      //               child: TextField(
      //                 controller: datecontroller,
      //                   onTap: () async{
      //                   DateTime? pickedDate= await showDatePicker(
      //                       context: context,
      //                       initialDate: DateTime.now(),
      //                       firstDate: DateTime(2000),
      //                       lastDate: DateTime(2100)
      //                   );
      //                   if(pickedDate!=null){
      //                     datecontroller.text=
      //                         DateFormat('yyyy-mm-dd').format(pickedDate);
      //                   }
      //                   },
      //                 decoration: InputDecoration(
      //                   prefixIcon: Icon(Icons.date_range),
      //                   hintText: "Date",
      //                     border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(30),
      //               ),
      //             ),
      //         ),
      // ),
      //                 ]
      //             ),
        SizedBox(height: 30),
        SizedBox(height: 50,
            width: 100),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              // padding: EdgeInsets.all(20)
            ),
            onPressed: (){
              addReading();
            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Reader_home()));
            } ,

            child: Text("SUBMIT")),
        ],
          ),
    ),
    ),
    );
  }
}
