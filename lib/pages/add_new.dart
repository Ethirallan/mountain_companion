import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mountain_companion/database/travel_db_helper.dart';
import 'package:mountain_companion/models/travel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mountain_companion/helper/new_expanded.dart';
import 'dart:math';

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
  final TextEditingController notesController = new TextEditingController();
  File miniPhoto1;
  File miniPhoto2;
  File miniPhoto3;
  File miniPhoto4;
  File miniPhoto5;
  File miniPhoto6;
  TextEditingController finalLocationCtrl = new TextEditingController();
  TextEditingController finalTimeCtrl = new TextEditingController();
  TextEditingController finalHeightCtrl = new TextEditingController();
  TextEditingController location1Ctrl = new TextEditingController();
  TextEditingController location2Ctrl = new TextEditingController();
  TextEditingController location3Ctrl = new TextEditingController();
  TextEditingController location4Ctrl = new TextEditingController();
  TextEditingController location5Ctrl = new TextEditingController();
  TextEditingController location6Ctrl = new TextEditingController();
  TextEditingController time1Ctrl = new TextEditingController();
  TextEditingController time2Ctrl = new TextEditingController();
  TextEditingController time3Ctrl = new TextEditingController();
  TextEditingController time4Ctrl = new TextEditingController();
  TextEditingController time5Ctrl = new TextEditingController();
  TextEditingController time6Ctrl = new TextEditingController();
  TextEditingController height1Ctrl = new TextEditingController();
  TextEditingController height2Ctrl = new TextEditingController();
  TextEditingController height3Ctrl = new TextEditingController();
  TextEditingController height4Ctrl = new TextEditingController();
  TextEditingController height5Ctrl = new TextEditingController();
  TextEditingController height6Ctrl = new TextEditingController();

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
            NewExpanded(finalLocationCtrl: finalLocationCtrl, finalTimeCtrl: finalTimeCtrl, finalHeightCtrl: finalHeightCtrl, location1Ctrl: location1Ctrl, location2Ctrl: location2Ctrl, location3Ctrl: location3Ctrl, location4Ctrl: location4Ctrl,
            location5Ctrl: location5Ctrl, location6Ctrl: location6Ctrl, time1Ctrl: time1Ctrl, time2Ctrl: time2Ctrl, time3Ctrl: time3Ctrl, time4Ctrl: time4Ctrl, time5Ctrl: time5Ctrl, time6Ctrl: time6Ctrl, height1Ctrl: height1Ctrl, height2Ctrl: height2Ctrl,
            height3Ctrl: height3Ctrl, height4Ctrl: height4Ctrl, height5Ctrl: height5Ctrl, height6Ctrl: height6Ctrl),
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
    travel.notes = notesController.text;
    travel.location1 = location1Ctrl.text;
    travel.location2 = location2Ctrl.text;
    travel.location3 = location3Ctrl.text;
    travel.location4 = location4Ctrl.text;
    travel.location5 = location5Ctrl.text;
    travel.location6 = location6Ctrl.text;
    travel.time1 = time1Ctrl.text;
    travel.time2 = time2Ctrl.text;
    travel.time3 = time3Ctrl.text;
    travel.time4 = time4Ctrl.text;
    travel.time5 = time5Ctrl.text;
    travel.time6 = time6Ctrl.text;
    travel.height1 = height1Ctrl.text;
    travel.height2 = height2Ctrl.text;
    travel.height3 = height3Ctrl.text;
    travel.height4 = height4Ctrl.text;
    travel.height5 = height5Ctrl.text;
    travel.height6 = height6Ctrl.text;
    travel.finalLocation = travel.location1 != null ? travel.location1 : '';
    int res = (int.tryParse(travel.time6) ?? 0) - (int.tryParse(travel.time1) ?? 0);
    print(res.toString() + 'res');
    travel.finalTime = res.toString();
    print(travel.finalTime);
    List<int> myList = [(int.tryParse(travel.height1) ?? 0), (int.tryParse(travel.height2) ?? 0), (int.tryParse(travel.height3) ?? 0), (int.tryParse(travel.height4) ?? 0), (int.tryParse(travel.height5) ?? 0), (int.tryParse(travel.height6) ?? 0)];
    List<int> myList2 = [];
    for (int i = 0; i < myList.length; i++) {
      if (myList[i] == 0) {
        myList2.add(myList[i]);
      }
    }
    if (myList2.length == 0) {
      myList2.add(0);
    }
    int minHeight = myList.reduce(min);
    print('min ' + minHeight.toString());
    int maxHeight = myList.reduce(max);
    print('max ' + maxHeight.toString());
    travel.finalHeight = (maxHeight - minHeight).toString();
    print(travel.finalHeight + 'finalH');
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

