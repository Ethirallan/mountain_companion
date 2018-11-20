import 'package:flutter/material.dart';
import 'package:mountain_companion/database/stamp_db_helper.dart';
import 'package:mountain_companion/helper/confirmation_alert.dart';
import 'dart:async';
import 'package:mountain_companion/models/stamp.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<List<Stamp>> getStampsFromDB() async {
  var dbHelper = StampDBHelper();
  Future<List<Stamp>> stamps = dbHelper.getStamps();
  return stamps;
}

class MyStampList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyStampListState();
  }
}

class MyStampListState extends State<MyStampList> {
  TextEditingController updateController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          'Zbirka žigov',
          style: TextStyle(fontSize: 26.0),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<Stamp>>(
          future: getStampsFromDB(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 6.0,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: snapshot.data[index].img == null
                                  ? Text('No image selected.')
                                  : Image.file(File(snapshot.data[index].img)),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  snapshot.data[index].name,
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(16.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (_) => MyAlert(
                                              id: snapshot.data[index].id,
                                              fun: 1,
                                              hint: snapshot.data[index].name,
                                              myPhoto: File(snapshot.data[index].img),
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          size: 30.0,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(16.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          ConfirmationAlert().myAlert(context, 'Opozorilo', 'Ste prepričani, da želite izbrisati žig?', () {
                                            var dbHelper = new StampDBHelper();
                                            dbHelper.deleteStamp(snapshot.data[index]);
                                            setState(() {
                                              getStampsFromDB();
                                            });
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          size: 30.0,
                                          color: Colors.blueGrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.data.length == 0) {
                return Text('Ni podatkov');
              }
            }
            return Container(
              alignment: AlignmentDirectional.center,
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        highlightElevation: 4.0,
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => MyAlert(fun: 0,),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class MyAlert extends StatefulWidget {
  final int id;
  final int fun; // 0 add, 1 update
  final String hint;
  final File myPhoto;
  MyAlert({this.id, this.fun, this.hint, this.myPhoto});
  @override
  State<StatefulWidget> createState() {
    return MyAlertState();
  }
}

class MyAlertState extends State<MyAlert> {
  final stampFormKey1 = new GlobalKey<FormState>();
  var stamp1 = new Stamp();
  File photo;
  bool isOk = true; //validator -> blue/red color of icons

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: stampFormKey1,
              child: TextFormField(
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(fontSize: 22.0, color: Colors.black),
                decoration: InputDecoration(
                  labelText: "Vnesite lokacijo",
                  hintText: widget.hint,
                ),
                validator: (val) =>
                    val.length == 0 && widget.hint == null ? "Lokacija ne sme biti prazna!" : null,
                onSaved: (val) => widget.hint == null ? stamp1.name = val : val.length == 0 ? stamp1.name = widget.hint : stamp1.name = val,
                autofocus: true,
              ),
            ),
            showPhoto(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 10.0, 10.0, 10.0),
                  child: GestureDetector(
                    child: Icon(
                      Icons.add_a_photo,
                      color: isOk ? Colors.blue : Colors.red,
                      size: 30.0,
                    ),
                    onTap: () {
                      takePhoto(1);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 16.0, 10.0),
                  child: GestureDetector(
                    child: Icon(
                      Icons.photo,
                      color: isOk ? Colors.blue : Colors.red,
                      size: 30.0,
                    ),
                    onTap: () {
                      takePhoto(2);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'PREKLIČI',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        FlatButton(
          onPressed: () {
            if (this.stampFormKey1.currentState.validate() && this.stamp1.img != null) {
              stampFormKey1.currentState.save();
              setState(() {
                isOk = true;
              });
            } else {
              if (stamp1 == null) {
                setState(() {
                  isOk = false;
                });
              }
              return null;
            }
            var dbHelper = new StampDBHelper();
            if (widget.fun == 0) {
              dbHelper.addNewStamp(stamp1);
            } else {
              stamp1.id = widget.id;
              dbHelper.updateStamp(stamp1);
            }
            setState(() {
              getStampsFromDB();
            });
            Navigator.pop(context);
            setState(() {
              getStampsFromDB();
            });
          },
          child: Text(
            'POTRDI',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  takePhoto(int x) async {
    var image = await ImagePicker.pickImage(source: x == 1 ? ImageSource.camera : ImageSource.gallery);
    photo = image; //alert image preview

    final String path = await _localPath;
    final File newImage = await image.copy('$path/${DateTime.now().toUtc().toIso8601String()}.png');
    stamp1.img = newImage.path;

    setState(() {
      getStampsFromDB();
      isOk = true;
    });
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Widget showPhoto() {
    if (photo == null) {
      if (widget.myPhoto != null) {
        stamp1.img = widget.myPhoto.path;

        return Container(
            padding: EdgeInsets.only(top: 12.0, bottom: 8.0),
            height: 200.0,
            child: Image.file(
              widget.myPhoto,
            ),
        );
      } else {
        return Container(
          height: 10.0,
        );
      }
    } else {
      return Container(
        padding: EdgeInsets.only(top: 12.0, bottom: 8.0),
        height: 200.0,
        child: Image.file(
          photo,
        ),
      );
    }
  }
}
