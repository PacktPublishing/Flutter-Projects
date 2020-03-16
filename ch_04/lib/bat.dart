import 'package:flutter/material.dart';

class Bat extends StatelessWidget {
  final double width;
  final double height;
  Bat(this.width, this.height);
  
  @override
  Widget build(BuildContext context) {
   return Container(
      width: width,
      height: height,
      decoration: new BoxDecoration(
        color: Colors.blue[900],
      ),
    );
  }
}