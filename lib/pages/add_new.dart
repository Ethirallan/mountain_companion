import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mountain_companion/database/travel_db_helper.dart';
import 'package:mountain_companion/models/travel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mountain_companion/helper/new_expanded.dart';

class AddNew extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddNewState();
  }
}

class AddNewState extends State<AddNew> {
  Travel travel = new Travel();
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController dateController = new TextEditingController();
  final TextEditingController locationController = new TextEditingController();
  final TextEditingController timeController = new TextEditingController();
  final TextEditingController heightController = new TextEditingController();
  final TextEditingController notesController = new TextEditingController();
  File miniPhoto1;
  File miniPhoto2;
  File miniPhoto3;
  File miniPhoto4;
  File miniPhoto5;
  File miniPhoto6;

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
            NewExpanded(heightCtrl: heightController, timeCtrl: timeController, locationCtrl: locationController,),
            buildCard('Zapiski', 'Vnesite zapiske', notesController, TextInputType.multiline),
            galleryCard(),
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

  Widget galleryCard() {
    return Card(
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 34.0,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        takePhoto(1);
                      }
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.photo,
                        size: 34.0,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        takePhoto(0);
                      }
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: miniPhoto1 != null ? Container(padding: EdgeInsets.all(4.0), child: GestureDetector(onDoubleTap: () {
                    miniPhoto1 = null;
                    travel.photo1 = null;
                    setState(() {
                      galleryCard();
                    });
                  }, child: Image.file(miniPhoto1, fit: BoxFit.contain,))) : Container(),
                ),
                Expanded(
                  child: miniPhoto2 != null ? Container(padding: EdgeInsets.all(4.0), child: GestureDetector(onDoubleTap: () { miniPhoto2 = null; travel.photo2 = null; setState(() {
                    galleryCard();
                  });}, child: Image.file(miniPhoto2, fit: BoxFit.contain,))) : Container(),
                ),
                Expanded(
                  child: miniPhoto3 != null ? Container(padding: EdgeInsets.all(4.0), child: GestureDetector(onDoubleTap: () { miniPhoto3 = null; travel.photo3 = null; setState(() {
                    galleryCard();
                  });}, child: Image.file(miniPhoto3, fit: BoxFit.contain,))) : Container(),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: miniPhoto4 != null ? Container(padding: EdgeInsets.all(4.0), child: GestureDetector(onDoubleTap: () { miniPhoto4 = null; travel.photo4 = null; setState(() {
                    galleryCard();
                  });}, child: Image.file(miniPhoto4, fit: BoxFit.contain,))) : Container(),
                ),
                Expanded(
                  child: miniPhoto5 != null ? Container(padding: EdgeInsets.all(4.0), child: GestureDetector(onDoubleTap: () { miniPhoto5 = null; travel.photo5 = null; setState(() {
                    galleryCard();
                  });}, child: Image.file(miniPhoto5, fit: BoxFit.contain,))) : Container(),
                ),
                Expanded(
                  child: miniPhoto6 != null ? Container(padding: EdgeInsets.all(4.0), child: GestureDetector(onDoubleTap: () { miniPhoto6 = null; travel.photo6 = null; setState(() {
                    galleryCard();
                  });}, child: Image.file(miniPhoto6, fit: BoxFit.contain,))) : Container(),
                ),
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
              color: Colors.blue,
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

  takePhoto(int x) async {
    var image = await ImagePicker.pickImage(source: x == 1 ? ImageSource.camera : ImageSource.gallery);
    //File photo = image; //alert image preview

    final String path = await _localPath;
    final File newImage = await image.copy('$path/${DateTime.now().toUtc().toIso8601String()}.png');

    if (travel.photo1 == null) {
      travel.photo1 = newImage.path;
      miniPhoto1 = image;
    } else if (travel.photo2 == null) {
      travel.photo2 = newImage.path;
      miniPhoto2 = image;
    } else if (travel.photo3 == null) {
      travel.photo3 = newImage.path;
      miniPhoto3 = image;
    } else if (travel.photo4 == null) {
      travel.photo4 = newImage.path;
      miniPhoto4 = image;
    } else if (travel.photo5 == null) {
      travel.photo5 = newImage.path;
      miniPhoto5 = image;
    } else if (travel.photo6 == null) {
      travel.photo6 = newImage.path;
      miniPhoto6 = image;
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Maksimalno število slik izbrano')));
    }

    setState(() {
      galleryCard();
    });
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}

