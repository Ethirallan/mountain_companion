import 'package:flutter/material.dart';

class AddNew extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddNewState();
  }
}

class AddNewState extends State <AddNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj nov izlet"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(

        ),
      ),
    );
  }
}

Widget buildCard(String title, String hint, TextEditingController controller) {
  return Card(
    elevation: 4.0,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(16.0, 8.0, 0.0, 0.0),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(16.0, 4.0, 0.0, 8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
            ),
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    ),
  );
}