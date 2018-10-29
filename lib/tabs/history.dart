import 'package:flutter/material.dart';
import 'package:mountain_companion/database/travel_db_helper.dart';
import 'dart:async';
import 'package:mountain_companion/models/travel.dart';
import 'package:mountain_companion/pages/wish_list.dart';
import 'package:mountain_companion/pages/stamp_list.dart';
import 'package:mountain_companion/pages/travel_details.dart';
import 'package:mountain_companion/pages/add_new.dart';

Future<List<Travel>> getTravelsFromDB() async {
  var dbHelper = TravelDBHelper();
  Future<List<Travel>> travels = dbHelper.getTravels();
  return travels;
}

class History extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HistoryState();
  }
}

class HistoryState extends State<History> {
  String master = "Loading";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          'Gorski spremljevalec',
          style: TextStyle(fontSize: 26.0),
        ),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext ctx) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyWishList()));
                    },
                    child: Text(
                      'Seznam želja',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyStampList()));
                    },
                    child: Text(
                      'Zbirka žigov',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: FutureBuilder<List<Travel>>(
          future: getTravelsFromDB(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Card(
                        elevation: 6.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
                              child: Text(
                                snapshot.data[index].title,
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                snapshot.data[index].date,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                snapshot.data[index].location,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                              child: Image.network(
                                  'http://www.lepote-slovenije.si/wp-content/uploads/2018/05/triglavska-jezera-750x445.jpg'),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TravelDetails())),
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
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNew()));
        },
        elevation: 10.0,
        highlightElevation: 4.0,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
