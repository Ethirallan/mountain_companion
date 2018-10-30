import 'package:flutter/material.dart';
import 'package:mountain_companion/database/travel_db_helper.dart';
import 'package:mountain_companion/models/travel.dart';

Future<List<Travel>> getTravelInfo() {
  var dbHelper = TravelDBHelper();
  Future<List<Travel>> travels = dbHelper.getTravels();
  return travels;
}

class TravelDetails extends StatefulWidget {
  final int myInt;
  TravelDetails({this.myInt});
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
                      background: Image.network(
                        'http://www.lepote-slovenije.si/wp-content/uploads/2018/05/triglavska-jezera-750x445.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    actions: <Widget>[
                      IconButton(icon: Icon(Icons.share), onPressed: () {}),
                      IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
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
                              gallery(),
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

  Widget buildHeader() {
    return Container(
      constraints: BoxConstraints.expand(
        height: 200.0,
      ),
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'http://www.lepote-slovenije.si/wp-content/uploads/2018/05/triglavska-jezera-750x445.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(
        'Triglavska jezera',
        style: TextStyle(
            fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.bold),
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
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 4.0, 0.0, 8.0),
            child: Text(
              text,
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

  Widget gallery() {
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
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 200.0,
            padding: EdgeInsets.all(8.0),
            child: PageView(
              children: <Widget>[
                Image.network(
                  'http://www.lepote-slovenije.si/wp-content/uploads/2018/05/triglavska-jezera-750x445.jpg',
                  fit: BoxFit.contain,
                ),
                Image.network(
                  'https://www.kamnik.info/wp-content/uploads/2016/08/marija-snezna-2016-97-620x330.jpg',
                  fit: BoxFit.contain,
                ),
                Image.network(
                  'http://www.lepote-slovenije.si/wp-content/uploads/2018/05/triglavska-jezera-750x445.jpg',
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
