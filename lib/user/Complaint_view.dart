import 'package:flutter/material.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/sent_complaint.dart';
import 'package:jalanidhi/user/Home%20page.dart';
import 'package:jalanidhi/sub_admin/View_complaint.dart';
class Cmplt_view extends StatefulWidget {
  const Cmplt_view({Key? key}) : super(key: key);


  @override
  State<Cmplt_view> createState() => _Cmplt_viewState();

}

class _Cmplt_viewState extends State<Cmplt_view> {
  List Lview = ["Complaint 1", "Complaint 2", "Complaint 3", "Complaint 4", "Complaint 5"];
  List Letter = ["image/sk1.jpg", "image/sk2.jpg", "image/sk3.jpg", "image/s4.jpg", ];

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
      title: Text("COMPLAINTS"),
      leading:IconButton(
        icon:Icon(Icons.arrow_back), onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Subadmin_home()));
      },
      ),
    ),
      body: ListView.builder(
          itemCount: Lview.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => View_complaint()));
              },
              child: Card(
                color: Colors.blueGrey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      Lview[index],
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.yellowAccent
                      ),
                    ),


                  ),

                ),
              ),

            );
          })
    );

  }
}

