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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: FutureBuilder<List<Travel>>(
        future: getTravelInfo(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.hasData) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 250.0,
                    backgroundColor: Colors.green,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        snapshot.data[widget.myInt].title,
                        style: TextStyle(),
                      ),
                      background: Image.file(File(snapshot.data[widget.myInt].photo1), //add default img!
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
                              buildDataCard('Datum:', snapshot.data[widget.myInt].date),
                              buildDataCard('Lokacija:', snapshot.data[widget.myInt].location),
                              buildDataCard('Čas hoje:', snapshot.data[widget.myInt].time),
                              buildDataCard('Višinska razlika:', snapshot.data[widget.myInt].height),
                              buildDataCard('Zapiski:', snapshot.data[widget.myInt].notes),
                              gallery(
                                snapshot.data[widget.myInt].photo1,
                                snapshot.data[widget.myInt].photo2,
                                snapshot.data[widget.myInt].photo3,
                                snapshot.data[widget.myInt].photo4,
                                snapshot.data[widget.myInt].photo5,
                                snapshot.data[widget.myInt].photo6,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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

  Widget gallery(String photo1, photo2, photo3, photo4, photo5, photo6) {
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
            height: 200.0,
            padding: EdgeInsets.all(8.0),
            child: PageView(
              children: <Widget>[
                showPhoto(photo1),
                showPhoto(photo2),
                showPhoto(photo3),
                showPhoto(photo4),
                showPhoto(photo5),
                showPhoto(photo6),
              ],
            ),
          ),
        ],
      ),
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

  Widget showPhoto(String photo) {
    if (photo == null) {
      return Container();
    } else {
      return Image.file(File(photo), fit: BoxFit.contain,);
    }
  }
}
