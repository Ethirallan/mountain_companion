import 'package:flutter/material.dart';
import 'package:mountain_companion/tabs/history.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return History();
  }
}
