import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:io';

class GalleryMode extends StatelessWidget{
  GalleryMode({this.img});
  final File img;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PhotoView(
            imageProvider: FileImage(img),
        ),
      ),
    );
  }
}