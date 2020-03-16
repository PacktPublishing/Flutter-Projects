import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    testData();
    return MaterialApp(
      title: 'Events',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(),
    );
  }

  Future testData() async {
    Firestore db = Firestore.instance;
    var data = await db.collection('event_details').getDocuments();
    if (data != null) {
      var details = data.documents.toList();
      details.forEach((d) {
        print(d.documentID);
       
      });
    }
  }

} 
