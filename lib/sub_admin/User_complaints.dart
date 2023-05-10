import 'package:flutter/material.dart';
import 'package:jalanidhi/sub_admin/subadmin_home.dart';
import 'package:jalanidhi/user/sent_complaint.dart';
import 'package:jalanidhi/user/Home%20page.dart';
import 'package:jalanidhi/sub_admin/View_complaint.dart';
class Complaint1 extends StatefulWidget {
  const Complaint1({Key? key}) : super(key: key);


  @override
  State<Complaint1> createState() => _Complaint1State();

}

class _Complaint1State extends State<Complaint1> {
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
          itemCount: Lview.length, itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.blueGrey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              // leading: Image(
              //   image: AssetImage(
              //       Letter[index]
              //   ),
              //
              // )
              // ,
                title: Text(
                  Lview[index],
                  style:TextStyle(
                      fontSize: 20,
                      color: Colors.yellowAccent
                  ),
                ) ,
                trailing:
                IconButton(


                  // style: IconButton.styleFrom(
                  //     primary:Colors.grey,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(0),
                  //       side: BorderSide(strokeAlign: BorderSide.strokeAlignCenter),
                  //     ),
                  //     padding: EdgeInsets.all(0)
                  //
                  // ),

                  onPressed:(){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>View_complaint()));
                  },
                  icon: Icon(Icons.arrow_forward_ios,
                  ),
                )
            ),
          ),
          // IconButton(
          //   icon: Icon(
          //       Icons.ca), onPressed: (
          //     ){},
          // ),
        );
      }
      ),
    );
  }
}

