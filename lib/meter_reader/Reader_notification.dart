import 'package:flutter/material.dart';
import 'package:jalanidhi/user/Home%20page.dart';
import 'package:jalanidhi/meter_reader/Meter_reader_home.dart';
class Reader_not extends StatefulWidget {
  const Reader_not({Key? key}) : super(key: key);


  @override
  State<Reader_not> createState() => _Reader_notState();

}

class _Reader_notState extends State<Reader_not> {
  List Lview = ["Notification 1", "Notification 2", "Notification 3", "Notification 4", "Notification 5"];
  List Letter = ["image/sk1.jpg", "image/sk2.jpg", "image/sk3.jpg", "image/s4.jpg", ];

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
      title: Text("VIEW NOTIFICATION"),
      leading:IconButton(
        icon:Icon(Icons.arrow_back), onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Reader_home()));
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
              ElevatedButton(

                  style: ElevatedButton.styleFrom(
                      primary:Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        side: BorderSide(strokeAlign: BorderSide.strokeAlignCenter),
                      ),
                      padding: EdgeInsets.all(0)

                  ),

                  onPressed:(){},
                  child: Text("CANCEL",
                    style: TextStyle(
                        color: Colors.black
                    ),
                  )
              ),
            ),
            // IconButton(
            //   icon: Icon(
            //       Icons.ca), onPressed: (
            //     ){},
            // ),
          ),
        );
      }
      ),
    );
  }
}

