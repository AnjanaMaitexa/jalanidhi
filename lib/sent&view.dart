import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Snd_view extends StatefulWidget {
  const Snd_view({Key? key}) : super(key: key);

  @override
  State<Snd_view> createState() => _Snd_viewState();
}

class _Snd_viewState extends State<Snd_view> {
  DateTime? _selectDate;
  @override
  Widget build(BuildContext context) {
    TextEditingController datecontroller = TextEditingController();
    return MaterialApp(
        home: Scaffold(appBar: AppBar(
          title: Text("SEND&VIEW"),
          leading: IconButton(
            icon: Icon(Icons.menu), onPressed: () {},
          ),
        ),
            body: Container(
              // ignore: prefer_const_literals_to_create_immutables
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                        onPressed: () {},

                        child: Text("Send_complaint")),
                  ],
            ),
        ),
    ),
    );
  }
  }
