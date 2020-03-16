import 'dart:io';

import 'package:flutter/material.dart';
import './dbhelper.dart';
import './place.dart';
import 'camera_screen.dart';

class PlaceDialog {
  final txtName = TextEditingController();
  final txtLat = TextEditingController();
  final txtLon = TextEditingController();
  final bool isNew;
  final Place place;

  PlaceDialog(this.place, this.isNew);

  Widget buildAlert(BuildContext context) {
    DbHelper helper = DbHelper();
    txtName.text = place.name;
    txtLat.text = place.lat.toString();
    txtLon.text = place.lon.toString();

    return AlertDialog(
      title: Text('Place'),
      content: SingleChildScrollView(
        child: Column(children: <Widget>[
          TextField(
          controller: txtName,
          decoration: InputDecoration(
            hintText: 'Name'
          ),
        ),
        TextField(
          controller: txtLat,
          decoration: InputDecoration(
            hintText: 'Latitude'
          ),
        ),
        TextField(
          controller: txtLon,
          decoration: InputDecoration(
            hintText: 'Longitude'
          ),
        ),
        (place.image!= '')?Container(child: Image.file(File(place.image))):Container(),
        IconButton(
            icon: Icon(Icons.camera_front),
            onPressed: () {
              if (isNew) {
                helper.insertPlace(place).then((data){
                  place.id = data;
                  MaterialPageRoute route = MaterialPageRoute(builder: (context)=> CameraScreen(place));
                  Navigator.push(context, route);
                });
              } 
              else {
                MaterialPageRoute route = MaterialPageRoute(builder: (context)=> CameraScreen(place));
                Navigator.push(context, route);
              }
            }),
        RaisedButton(
          child: Text('OK'),
          onPressed: () {
            place.name = txtName.text;
            place.lat = double.tryParse(txtLat.text);
            place.lon = double.tryParse(txtLon.text);
            helper.insertPlace(place);
            Navigator.pop(context);
          },
        )

        ]),
      )

    );

  }

}
