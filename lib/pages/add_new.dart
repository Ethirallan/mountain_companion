import 'package:flutter/material.dart';
import 'package:mountain_companion/database/travel_db_helper.dart';
import 'package:mountain_companion/models/travel.dart';

class AddNew extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddNewState();
  }
}

class AddNewState extends State<AddNew> {
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController dateController = new TextEditingController();
  final TextEditingController locationController = new TextEditingController();
  final TextEditingController timeController = new TextEditingController();
  final TextEditingController heightController = new TextEditingController();
  final TextEditingController notesController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("Dodaj nov izlet"),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            buildCard('Naslov:', 'Vnesite naslov', titleController, TextInputType.text),
            buildCard('Datum:', 'Vnesite datum', dateController, TextInputType.datetime),
            buildCard('Lokacija:', 'Vnesite lokacijo', locationController, TextInputType.text),
            buildCard('Čas:', 'Vnesite čas', timeController, TextInputType.datetime),
            buildCard('Višinska razlika:', 'Vnesite višinsko razliko', heightController, TextInputType.number),
            buildCard('Zapiski', 'Vnesite zapiske', notesController, TextInputType.multiline),
            Card(
              elevation: 4.0,
              child: Container(
                height: 180.0,
                child: Center(
                  child: IconButton(
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 34.0,
                        color: Colors.blueGrey,
                      ),
                      onPressed: () {}),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                buildButton('Prekliči', 0),
                buildButton('Shrani', 1),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String name, int fun) {
    return Expanded(
      child: Card(
        elevation: 4.0,
        child: FlatButton(
          onPressed: fun == 0 ? _cancel : _saveToDB,
          child: Text(
            name,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _saveToDB() {
    Travel travel = new Travel();
    var dbHelper = new TravelDBHelper();
    travel.title = titleController.text;
    travel.date = dateController.text;
    travel.location = locationController.text;
    travel.time = timeController.text;
    travel.height = heightController.text;
    travel.notes = notesController.text;
    dbHelper.addNewTravel(travel);
    Navigator.pop(context);
  }

  Widget buildCard(String title, String hint, TextEditingController controller, TextInputType input) {
    return Card(
      elevation: 4.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 14.0, 20.0, 0.0),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 14.0),
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              keyboardType: input,
              controller: controller,
              maxLines: null,
              decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(fontSize: 22.0, color: Colors.grey)),
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.blueGrey,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

}

