import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mountain_companion/database/travel_db_helper.dart';
import 'package:mountain_companion/helper/confirmation_alert.dart';
import 'package:mountain_companion/helper/constants.dart';
import 'package:mountain_companion/models/travel.dart';

Future<List<Travel>> getTravelInfo() {
  var dbHelper = TravelDBHelper();
  Future<List<Travel>> travels = dbHelper.getTravels();
  return travels;
}

class TravelDetails extends StatefulWidget {
  final int myInt;
  final int travelID;
  TravelDetails({this.myInt, this.travelID});
  @override
  State<StatefulWidget> createState() {
    return TravelDetailsState();
  }
}

class TravelDetailsState extends State<TravelDetails> {
  Travel travel;
  List<File> imgFileList = [];
  File headerImage;
  List<String> locationList = [];
  List<String> timeList = [];
  List<String> heightList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: FutureBuilder<List<Travel>>(
        future: getTravelInfo(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.hasData) {
              travel = snapshot.data[widget.myInt];
              List<String> imgPaths = [travel.photo1, travel.photo2, travel.photo3, travel.photo4, travel.photo5, travel.photo6];
              for(int i = 0; i < imgPaths.length; i++) {
                if (imgPaths[i].length > 8) {
                  imgFileList.add(File(imgPaths[i]));
                }
              }
              headerImage = imgFileList.length == 0 ? null : imgFileList[0]; //add defaultImg

              for (int i = 0; i < 6; i++) {
                if (i == 0) {
                  if (travel.location1.isNotEmpty) {
                    locationList.add(travel.location1);
                  }
                  if (travel.time1.isNotEmpty) {
                    timeList.add(travel.time1);
                  }
                  if (travel.height1.isNotEmpty) {
                    heightList.add(travel.height1);
                  }
                } else if (i == 1) {
                  if (travel.location2.isNotEmpty) {
                    locationList.add(travel.location2);
                  }
                  if (travel.time2.isNotEmpty) {
                    timeList.add(travel.time2);
                  }
                  if (travel.height2.isNotEmpty) {
                    heightList.add(travel.height2);
                  }
                } else if (i == 2) {
                  if (travel.location3.isNotEmpty) {
                    locationList.add(travel.location3);
                  }
                  if (travel.time3.isNotEmpty) {
                    timeList.add(travel.time3);
                  }
                  if (travel.height3.isNotEmpty) {
                    heightList.add(travel.height3);
                  }
                } else if (i == 3) {
                  if (travel.location4.isNotEmpty) {
                    locationList.add(travel.location4);
                  }
                  if (travel.time4.isNotEmpty) {
                    timeList.add(travel.time4);
                  }
                  if (travel.height4.isNotEmpty) {
                    heightList.add(travel.height4);
                  }
                } else if (i == 4) {
                  if (travel.location5.isNotEmpty) {
                    locationList.add(travel.location5);
                  }
                  if (travel.time5.isNotEmpty) {
                    timeList.add(travel.time5);
                  }
                  if (travel.height5.isNotEmpty) {
                    heightList.add(travel.height5);
                  }
                } else if (i == 5) {
                  if (travel.location6.isNotEmpty) {
                    locationList.add(travel.location6);
                  }
                  if (travel.time6.isNotEmpty) {
                    timeList.add(travel.time6);
                  }
                  if (travel.height6.isNotEmpty) {
                    heightList.add(travel.height6);
                  }
                }
              }

              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 250.0,
                    backgroundColor: Colors.green,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        travel.title,
                        style: TextStyle(),
                      ),
                      background: Image.file(headerImage, //add default img!
                        fit: BoxFit.cover,
                      ),
                    ),
                    actions: <Widget>[
                      PopupMenuButton(
                        onSelected: pickAction,
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (BuildContext ctx) {
                          return Constants.details.map((String action) {
                            return PopupMenuItem<String>(
                              value: action,
                              child: Text(action, style: TextStyle(fontSize: 20.0),),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              buildDataCard('Datum:', travel.date),
                              myExpansionTile('Lokacija:', travel.finalLocation, locationList),
                              myExpansionTile('Čas hoje:', travel.time1, timeList),
                              myExpansionTile('Višinska razlika:', travel.height6, heightList),
                              buildDataCard('Zapiski:', travel.notes),
                              gallery(imgFileList),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.data.isEmpty) {
              return Text('Ni podatkov');
            }
          }
          return Container(
            alignment: AlignmentDirectional.center,
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget myExpansionTile(String title, value, List list) {
    //value = '';
    return Card(
      elevation: 4.0,
      child: ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(title, style: TextStyle(
              fontSize: 18.0,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold),
            ),
            Text(value, style: TextStyle(
                fontSize: 22.0,
                color: Colors.blueGrey,
                fontWeight: FontWeight.normal),
            ),
          ],
        ),
        children: <Widget>[
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return expansionChild(title, list[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget expansionChild(String title, value) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, bottom: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(
              fontSize: 20.0,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(value, style: TextStyle(
                fontSize: 22.0,
                color: Colors.blueGrey,
                fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDataCard(String title, String text) {
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
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 4.0, 0.0, 8.0),
            child: Text(
              text,
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

  Widget gallery(List list) {
    return Card(
      elevation: 4.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 0.0, 0.0),
            child: Text(
              'Galerija:',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 360.0,
            padding: EdgeInsets.all(14.0),
            child: draw(list),
          ),
        ],
      ),
    );
  }

  Widget draw(List list) {
    return PageView.builder(
      itemCount: list.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Image.file(list[index], fit: BoxFit.scaleDown);
      },
    );
  }

  void pickAction(String action) {
    if (action == Constants.edit) {

    } else if (action == Constants.delete) {
      ConfirmationAlert().myAlert(context, 'Opozorilo', 'Ste prepričani, da želite izbrisati izlet?', () {
        Travel travel = new Travel();
        travel.id = widget.travelID;
        var dbHelper = new TravelDBHelper();
        dbHelper.deleteTravel(travel);
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }
  }
}
