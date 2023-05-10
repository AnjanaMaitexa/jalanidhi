
import 'package:flutter/material.dart';

class login extends StatelessWidget {
  const login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp( home:statefull() ,);

  }
}
class statefull extends StatefulWidget {
  const statefull({Key? key}) : super(key: key);

  @override
  State<statefull> createState() => _statefullState();
}

class _statefullState extends State<statefull> {
  @override
  Widget build(BuildContext context) {
    return    Scaffold(
      appBar: AppBar(
        title: Text("login"),
        leading:IconButton(
          icon:Icon(Icons.menu), onPressed: () {  },
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                  "asset/water.png"
              ),
            ),
            Text("lOGIN",
              style: TextStyle(
                fontSize: 20,
                color: Colors.lightGreen,
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: 30),
            TextField(decoration: InputDecoration(
              labelText:"username" ,
              hintText: "username",
              hintStyle: TextStyle(
                  color: Colors.green
              ),
              border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            ),
            SizedBox(height: 30),
            TextField(decoration: InputDecoration(
              labelText: "password",
              hintText: "password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            ),
            SizedBox(height: 30),
            Text("forgot your password"),
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
                  onPressed: (){} ,
                  child: Text("LOGIN")),
            ),
            SizedBox(height: 30),
            Text("do you have an account")





          ],
        ),),
    );
  }
}
