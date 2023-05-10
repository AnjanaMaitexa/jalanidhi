import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/Home%20page.dart';
import 'package:jalanidhi/user/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
class profile extends StatefulWidget {
  const profile ({Key? key}) : super(key: key);

  @override
  State<profile> createState() =>_profileState ();
}

class _profileState extends State<profile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController  phnController = TextEditingController();
  TextEditingController  emailController = TextEditingController();
  late int user_id;
  String name = "";
  String email = "";
  String phn = "";
  late SharedPreferences prefs;
  final _formKey = GlobalKey<FormState>();
  @override
  initState() {
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    user_id = (prefs.getInt('user_id') ?? 0 );
    print('login_idupdate ${user_id}');
    var res = await Api()
        .getData('/api/single_consumer/' + user_id.toString());
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['name'];
      phn = body['data']['phone_no'];
      email = body['data']['email'];

      nameController.text = name;
      emailController.text = email;
      phnController.text = phn;

    });
  }
  _update() async {
    setState(() {
      var _isLoading = true;
    });

    var data = {
      "name": nameController.text,
      "email": emailController.text,
      "phone_no": phnController.text,
    };
    print(data);
    var res = await Api().putData(data, '/api/update_consumer/'+user_id.toString());
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => userhome()));
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Profile Page"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>userhome()));
              }
          ),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(image: DecorationImage(
              image: AssetImage("images/img.png"),
              fit: BoxFit.cover
          ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage:AssetImage("images/img_10.png")
                ),
                Text(name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "name",
                  hintStyle: TextStyle(
                      color: Colors.green
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller:phnController,
                  decoration: InputDecoration(
                  labelText: "Phone no",
                  hintText: "phone no",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                ),
                // SizedBox(height: 30),
                // TextField(decoration: InputDecoration(
                //   labelText: "Address",
                //   hintText: "address",
                //   border: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(30),
                //   ),
                // ),
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
                        _update();
                      } ,
                      child: Text("UPDATE")),
                ),
                SizedBox(height: 30),
              ]
          ),
        ),
      ),
    );
  }
}


