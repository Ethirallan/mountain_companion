import 'package:flutter/material.dart';

class AddNew extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddNewState();
  }
}

class AddNewState extends State<AddNew> {
  TextEditingController titleCtr;
  TextEditingController dateCtr;
  TextEditingController timeCtr;
  TextEditingController heightCtr;
  TextEditingController locationCtr;
  TextEditingController noteCtr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dodaj nov izlet",
          style: TextStyle(fontSize: 26.0),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            buildCard('Naslov:', 'Vnesite naslov', titleCtr),
            buildCard('Lokacija:', 'Vnesite lokacijo', locationCtr),
            buildCard('Čas hoje:', 'Vnesite čas', timeCtr),
            buildCard(
                'Višinska razlika:', 'Vnesite višinsko razliko', heightCtr),
            buildCard('Opis:', 'Vnesite opis', noteCtr),
            Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    elevation: 4.0,
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      child: FlatButton(
                        onPressed: _cancel,
                        child: Text(
                          'Prekliči',
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    elevation: 4.0,
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      child: FlatButton(
                        onPressed: _saveToDB,
                        child: Text(
                          'Shrani',
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _cancel() {}

  void _saveToDB() {}
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
