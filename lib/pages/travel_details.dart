import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mountain_companion/database/travel_db_helper.dart';
import 'package:mountain_companion/helper/confirmation_alert.dart';
import 'package:mountain_companion/helper/constants.dart';
import 'package:mountain_companion/models/travel.dart';
import 'package:mountain_companion/pages/gallery_mode.dart';

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
  List<String> imgPaths;
  List<String> imgPaths2 = [];
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
              imgPaths = [travel.photo1, travel.photo2, travel.photo3, travel.photo4, travel.photo5, travel.photo6];
              for(int i = 0; i < imgPaths.length; i++) {
                if (imgPaths[i].length > 8) {
                  imgFileList.add(File(imgPaths[i]));
                  imgPaths2.add(imgPaths[i]);
                }
              }
              headerImage = imgFileList.length == 0 ? null : imgFileList[0]; //add default img

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
                    backgroundColor: Colors.blue,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        travel.title,
                        style: TextStyle(),
                      ),
                      background: Image.file(File(travel.headerPhoto), //add default img!
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
                              myExpansionTile('Lokacija:', 'Lokacija', travel.finalLocation, locationList),
                              myExpansionTile('Čas hoje:', 'Ura', travel.finalTime, timeList),
                              myExpansionTile('Višinska razlika:', 'Višina', travel.finalHeight, heightList),
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

  Widget myExpansionTile(String title, title2, value, List list) {
    return Card(
      elevation: 4.0,
      child: ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(title, style: TextStyle(
              fontSize: 20.0,
              color: Colors.blue,
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
              return expansionChild(title2 + ' ' + (index + 1).toString() + ':', list[index]);
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
              fontSize: 18.0,
              color: Colors.green,
              fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(value, style: TextStyle(
                fontSize: 20.0,
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
                  fontSize: 20.0,
                  color: Colors.blue,
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
                  fontSize: 20.0,
                  color: Colors.blue,
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
        return GestureDetector(
          child: Image.file(list[index], fit: BoxFit.scaleDown),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GalleryMode(img: list[index],),
            ),
          ),
          onDoubleTap: () {
            Travel newTravel = new Travel();
            var dbHelper2 = new TravelDBHelper();
            newTravel.id = widget.travelID;
            newTravel.headerPhoto = this.imgPaths2[index];
            newTravel.title = this.travel.title;
            newTravel.date = this.travel.date;
            newTravel.finalLocation = this.travel.finalLocation;
            newTravel.finalTime = this.travel.finalTime;
            newTravel.finalHeight = this.travel.finalHeight;
            newTravel.notes = this.travel.notes;
            newTravel.location1 = this.travel.location1;
            newTravel.location2 = this.travel.location2;
            newTravel.location3 = this.travel.location3;
            newTravel.location4 = this.travel.location4;
            newTravel.location5 = this.travel.location5;
            newTravel.location6 = this.travel.location6;
            newTravel.time1 = this.travel.time1;
            newTravel.time2 = this.travel.time2;
            newTravel.time3 = this.travel.time3;
            newTravel.time4 = this.travel.time4;
            newTravel.time5 = this.travel.time5;
            newTravel.time6 = this.travel.time6;
            newTravel.height1 = this.travel.height1;
            newTravel.height2 = this.travel.height2;
            newTravel.height3 = this.travel.height3;
            newTravel.height4 = this.travel.height4;
            newTravel.height5 = this.travel.height5;
            newTravel.height6 = this.travel.height6;
            newTravel.photo1 = this.travel.photo1;
            newTravel.photo2 = this.travel.photo2;
            newTravel.photo3 = this.travel.photo3;
            newTravel.photo4 = this.travel.photo4;
            newTravel.photo5 = this.travel.photo5;
            newTravel.photo6 = this.travel.photo6;
            dbHelper2.updateTravel(newTravel);
            TravelDetailsState().setState(getTravelInfo);
          },
        );
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
