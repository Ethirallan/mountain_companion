import 'package:flutter/material.dart';

class ConfirmationAlert {
  void myAlert(BuildContext context, String title, String message, Function fun) {
    showDialog(
      barrierDismissible: false,
      context: context, builder: (_) =>
        AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(16.0,10.0,16.0,10.0),
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('PREKLIČI'),
            ),
            FlatButton(
              onPressed: fun,
              child: Text('POTRDI'),
            ),
          ],
        ),
    );
  }
}