import 'package:flutter/material.dart';
import 'package:mountain_companion/database/wish_db_helper.dart';
import 'dart:async';
import 'package:mountain_companion/models/wish.dart';

Future<List<Wish>> getWishesFromDB() async {
  var dbHelper = WishDBHelper();
  Future<List<Wish>> wishes = dbHelper.getWishes();
  return wishes;
}

class MyWishList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyWishListState();
  }
}

class MyWishListState extends State<MyWishList> {
  final updateController = new TextEditingController();
  final wishFormKey = new GlobalKey<FormState>();
  var wish1 = new Wish();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          'Seznam želja',
          style: TextStyle(fontSize: 26.0),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<Wish>>(
          future: getWishesFromDB(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 6.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data[index].name,
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6.0),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            16.0, 10.0, 16.0, 10.0),
                                        content: SingleChildScrollView(
                                          child: Form(
                                            key: wishFormKey,
                                            child: TextFormField(
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                hintText:
                                                    snapshot.data[index].name,
                                              ),
                                              style: TextStyle(
                                                  fontSize: 22.0,
                                                  color: Colors.black),
                                              controller: updateController,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              keyboardType: TextInputType.text,
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              updateController.text = '';
                                              Navigator.pop(context);
                                            },
                                            child: Text('PREKLIČI'),
                                          ),
                                          FlatButton(
                                            onPressed: () {
                                              var dbHelper = new WishDBHelper();
                                              Wish wish = new Wish();
                                              wish.id = snapshot.data[index].id;
                                              wish.name =
                                                  updateController.text != ''
                                                      ? updateController.text
                                                      : snapshot
                                                          .data[index].name;
                                              updateController.text = '';
                                              dbHelper.updateWish(wish);
                                              Navigator.pop(context);
                                              setState(() {
                                                getWishesFromDB();
                                              });
                                            },
                                            child: Text('POTRDI'),
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
                            padding: EdgeInsets.all(6.0),
                            child: GestureDetector(
                              onTap: () {
                                var dbHelper = new WishDBHelper();
                                dbHelper.deleteWish(snapshot.data[index]);
                                setState(() {
                                  getWishesFromDB();
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
            builder: (_) => AlertDialog(
                  contentPadding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                  content: SingleChildScrollView(
                    child: Form(
                      key: wishFormKey,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(fontSize: 22.0, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Vnesite lokacijo",
                        ),
                        validator: (val) => val.length == 0
                            ? "Lokacija ne sme biti prazna!"
                            : null,
                        onSaved: (val) => wish1.name = val,
                        autofocus: true,
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
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        if (this.wishFormKey.currentState.validate()) {
                          wishFormKey.currentState.save();
                        } else {
                          return null;
                        }
                        var dbHelper = new WishDBHelper();
                        dbHelper.addNewWish(wish1);
                        Navigator.pop(context);
                        setState(() {
                          getWishesFromDB();
                        });
                      },
                      child: Text(
                        'POTRDI',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
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

  @override
  void initState() {
    super.initState();
  }
}
