
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jalanidhi/user/Home%20page.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:jalanidhi/user/sent_complaint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  List _loaddisease = [];
  bool isLoading = false;
  late SharedPreferences localStorage;
  late int user_id;
  String complaint="";
  String dates="";
  String reply="";
  late bool isExpanded=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _fetchDisease();
  }

  _fetchDisease() async {
    localStorage = await SharedPreferences.getInstance();
    user_id = (localStorage.getInt('user_id') ?? 0);

    var res = await Api()
        .getData('/api/complaintsingle_view/' + user_id.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      complaint = body['data']['complaint'];

      dates = body['data']['date'];
      reply = body['data']['reply'].toString();
    });
  }
      /* if (res.statusCode == 200) {
      var items = json.decode(res.body);
      print("items${items}");
      setState(() {
        complaint = items['data']['complaint'];

        dates = items['data']['date'];
        reply = items['data']['reply'].toString();
        //  _loaddisease = items;
      });
    } else {
      setState(() {
        _loaddisease = [];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF5DCEEFD) ,
      appBar: AppBar(
        title: Text("Complaint Management",style: TextStyle(color: Color(0xFF8F371B)),),
        backgroundColor: Colors.white ,
        leading:IconButton(onPressed:(){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>userhome()));
        },
            icon: Icon(Icons.arrow_back,color: Color(0xFF8F371B))),
      ),
      body: Container(

        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
              children:<Widget> [

                Padding(
                  padding: const EdgeInsets.only(top:15.0),
                  child: Text("Complaints",style: TextStyle(
                      fontSize:26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8F371B)
                  ),),
                ),
                SizedBox(height:20),
                Card(
                    child:Container(
                        child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(complaint,),
                                          Text(dates),
                                        ],
                                      ),


                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children:[
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isExpanded = !isExpanded;
                                              });
                                            },
                                            child: isExpanded?Icon(Icons.arrow_drop_up):Icon(Icons.arrow_drop_down),
                                          ),
                                          Visibility(
                                            visible: isExpanded,
                                            child: AnimatedContainer(
                                              duration: Duration(milliseconds: 300),
                                              height: isExpanded ? 50.0 : 0.0,
                                              child:/*reply == "null"? Text("No reply available"):*/ Text(reply),
                                            ),
                                          )
                                        ],
                                      ),
                                    )]
                              )]
                        )
                    )
                )
                /*  ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap:true,
                  itemCount: _loaddisease.length,
                  itemBuilder: (context,index){
                    return Card(
                        child:Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(complaint,),
                                        Text(dates),
                                      ],
                                    ),


                                  ),
                                *//*  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children:[
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isExpanded = !isExpanded;
                                            });
                                          },
                                          child: isExpanded?Icon(Icons.arrow_drop_up):Icon(Icons.arrow_drop_down),
                                        ),
                                        Visibility(
                                          visible: isExpanded,
                                          child: AnimatedContainer(
                                            duration: Duration(milliseconds: 300),
                                            height: isExpanded ? 50.0 : 0.0,
                                            child:Text(reply),
                                          ),
                                        )
                                      ],
                                    ),
                                  )*//*
                                ],
                              ),
                            ],
                          ),
                        )


                    );
                  },
                )*/
              ]),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddComplaint(),
          ));
        },
        tooltip: 'Add Complaints',
        child: const Icon(Icons.add),
      ),
    );

  }

}