
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/View_consumers.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Viewconsumers extends StatefulWidget {
  const Viewconsumers({Key? key}) : super(key: key);

  @override
  State<Viewconsumers> createState() => _ViewconsumersState();
}

class _ViewconsumersState extends State<Viewconsumers> {
  List _loadconsumer = [];
  bool isLoading = false;
  late SharedPreferences localStorage;
  late int user_id;
  late int consume_id;

  late bool isExpanded=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _fetchConsumer();
  }

  _fetchConsumer() async {
    var res = await Api()
        .getData('/api/all_consumer');
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print("items${items}");
      setState(() {
        _loadconsumer = items;
      });
    } else {
      setState(() {
        _loadconsumer = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Consumer"),
        leading:IconButton(onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Subadmin_home(),
          ));
        },
            icon: Icon(Icons.arrow_back)),
      ),
      body:Container(
        child: Column(
            children:<Widget> [

              Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: Text("Consumers",style: TextStyle(
                  fontSize:26,
                  fontWeight: FontWeight.bold,

                ),),
              ),
              SizedBox(height:20),
              ListView.builder(
                shrinkWrap:true,
                itemCount: _loadconsumer.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: ()async {
                      consume_id=_loadconsumer[index]['id'];
                      print("id${consume_id}");
                     Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => View_profile(id:consume_id) ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        child: ListTile(
                          title:  Text(_loadconsumer[index]['name'],
                            style:TextStyle(
                              fontSize: 18,fontWeight: FontWeight.bold,
                            ) ,),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text("Panchayath: "+_loadconsumer[index]['panchayath_name'],
                              style:TextStyle(
                                fontSize: 15,fontWeight: FontWeight.bold,
                              ) ,),
                          ),
                           trailing: Text("Phone:"+_loadconsumer[index]['phone_no'],
                             style:TextStyle(
                               fontSize: 18,fontWeight: FontWeight.bold,
                             ) ,),
                          /*   ElevatedButton(onPressed: (){},
                                    child: Text("APPROVE")),
                                ElevatedButton(onPressed: (){

                                },
                                    child: Text("REJECT"))*/

                        ),
                      ),
                    ),
                  );
                },
              )
            ]),

      ),

    );
  }
}

