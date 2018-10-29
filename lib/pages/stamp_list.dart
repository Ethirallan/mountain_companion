import 'package:flutter/material.dart';
import 'package:mountain_companion/database/stamp_db_helper.dart';
import 'dart:async';
import 'package:mountain_companion/models/stamp.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

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
                                  : Image.memory(Base64Codec()
                                      .decode(snapshot.data[index].img)),
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
                                            builder: (_) => AlertDialog(
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(16.0,
                                                          10.0, 16.0, 10.0),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Center(
                                                      child: Container(
                                                        padding: EdgeInsets.all(
                                                            16.0),
                                                        child: Text(
                                                          'Kaj želite spremeniti?',
                                                          style: TextStyle(
                                                              fontSize: 22.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'PREKLIČI',
                                                        style: TextStyle(
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                    FlatButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder:
                                                              (_) =>
                                                                  AlertDialog(
                                                                    contentPadding:
                                                                        EdgeInsets.fromLTRB(
                                                                            16.0,
                                                                            10.0,
                                                                            16.0,
                                                                            10.0),
                                                                    content:
                                                                        SingleChildScrollView(
                                                                          child: Column(
                                                                            children: <Widget>[
                                                                              Container(
                                                                                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                                                                                child: Text('Izberi:', style: TextStyle(fontSize: 22.0),),
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment:
                                                                                MainAxisAlignment
                                                                                    .center,
                                                                                crossAxisAlignment:
                                                                                CrossAxisAlignment
                                                                                    .center,
                                                                                children: <
                                                                                    Widget>[
                                                                                  Container(
                                                                                    padding: EdgeInsets.fromLTRB(
                                                                                        16.0,
                                                                                        10.0,
                                                                                        10.0,
                                                                                        10.0),
                                                                                    child:
                                                                                    IconButton(
                                                                                      icon:
                                                                                      Icon(
                                                                                        Icons.add_a_photo,
                                                                                        color: Colors.blue,
                                                                                      ),
                                                                                      onPressed:
                                                                                          () {
                                                                                        Navigator.pop(context);
                                                                                        takePhoto(1, snapshot.data[index].id, snapshot.data[index].name);
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: EdgeInsets.fromLTRB(
                                                                                        10.0,
                                                                                        10.0,
                                                                                        16.0,
                                                                                        10.0),
                                                                                    child:
                                                                                    IconButton(
                                                                                      icon:
                                                                                      Icon(
                                                                                        Icons.photo,
                                                                                        color: Colors.blue,
                                                                                      ),
                                                                                      onPressed:
                                                                                          () {
                                                                                        Navigator.pop(context);
                                                                                        takePhoto(2, snapshot.data[index].id, snapshot.data[index].name);
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                  ),
                                                        );
                                                      },
                                                      child: Text(
                                                        'SLIKO',
                                                        style: TextStyle(
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                    FlatButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder:
                                                              (_) =>
                                                                  AlertDialog(
                                                                    contentPadding:
                                                                        EdgeInsets.fromLTRB(
                                                                            16.0,
                                                                            10.0,
                                                                            16.0,
                                                                            10.0),
                                                                    content:
                                                                        SingleChildScrollView(
                                                                      child:
                                                                          Form(
                                                                        child:
                                                                            TextFormField(
                                                                          autofocus:
                                                                              true,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            hintText:
                                                                                snapshot.data[index].name,
                                                                          ),
                                                                          style: TextStyle(
                                                                              fontSize: 22.0,
                                                                              color: Colors.black),
                                                                          controller:
                                                                              updateController,
                                                                          textCapitalization:
                                                                              TextCapitalization.sentences,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    actions: <
                                                                        Widget>[
                                                                      FlatButton(
                                                                        onPressed:
                                                                            () {
                                                                          updateController.text =
                                                                              '';
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: Text(
                                                                            'PREKLIČI'),
                                                                      ),
                                                                      FlatButton(
                                                                        onPressed:
                                                                            () {
                                                                          var dbHelper =
                                                                              new StampDBHelper();
                                                                          Stamp
                                                                              stamp =
                                                                              new Stamp();
                                                                          stamp.id = snapshot
                                                                              .data[index]
                                                                              .id;
                                                                          stamp.name = updateController.text != ''
                                                                              ? updateController.text
                                                                              : snapshot.data[index].name;
                                                                          updateController.text =
                                                                              '';
                                                                          dbHelper
                                                                              .updateStamp(stamp);
                                                                          Navigator.pop(
                                                                              context);
                                                                          setState(
                                                                              () {
                                                                            getStampsFromDB();
                                                                          });
                                                                        },
                                                                        child: Text(
                                                                            'POTRDI'),
                                                                      ),
                                                                    ],
                                                                  ),
                                                        );
                                                      },
                                                      child: Text(
                                                        'NASLOV',
                                                        style: TextStyle(
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                  ],
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
                                          var dbHelper = new StampDBHelper();
                                          dbHelper.deleteStamp(
                                              snapshot.data[index]);
                                          setState(() {
                                            getStampsFromDB();
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
              }
            } else if (snapshot.data.length == 0) {
              return Text('Ni podatkov');
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
            builder: (_) => MyAlert(),
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

  takePhoto(int x, int index, String name) async {
    Stamp stamp2 = Stamp();
    stamp2.id = index;
    stamp2.name = name;
    StampDBHelper db = StampDBHelper();
    var image = await ImagePicker.pickImage(
        source: x == 1 ? ImageSource.camera : ImageSource.gallery);
    Future<void> doThis() {
      List<int> imageBytes = image.readAsBytesSync();
      String base64 = Base64Codec().encode(imageBytes);
      stamp2.img = base64;
      db.updateStamp(stamp2);
      return null;
    }
    await doThis();
    setState(() {
      getStampsFromDB();
    });
  }
}

class MyAlert extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAlertState();
  }
}

class MyAlertState extends State<MyAlert> {
  final stampFormKey1 = new GlobalKey<FormState>();
  var stamp1 = new Stamp();
  File photo;
  bool isOk = true;

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
                ),
                validator: (val) =>
                    val.length == 0 ? "Lokacija ne sme biti prazna!" : null,
                onSaved: (val) => stamp1.name = val,
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
            if (this.stampFormKey1.currentState.validate() &&
                this.stamp1.img != null) {
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
            dbHelper.addNewStamp(stamp1);
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
    var image = await ImagePicker.pickImage(
        source: x == 1 ? ImageSource.camera : ImageSource.gallery);
    Future<void> doThis() {
      photo = image;
      List<int> imageBytes = image.readAsBytesSync();
      String base64 = Base64Codec().encode(imageBytes);
      stamp1.img = base64;
      return null;
    }

    await doThis();
    setState(() {
      getStampsFromDB();
      isOk = true;
    });
  }

  Widget showPhoto() {
    return photo == null
        ? Container(
            height: 10.0,
          )
        : Container(
            padding: EdgeInsets.only(top: 12.0, bottom: 8.0),
            height: 200.0,
            child: Image.file(
              photo,
            ),
          );
  }
}
