import 'package:flutter/material.dart';
import './place_dialog.dart';
import 'dbhelper.dart';

class ManagePlaces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Places'),),
      body: PlacesList(),
    );
  }
}

class PlacesList extends StatefulWidget {
  @override
  _PlacesListState createState() => _PlacesListState();
}

class _PlacesListState extends State<PlacesList> {
  DbHelper helper = DbHelper();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:  helper.places.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
              key: Key(helper.places[index].name),
              onDismissed: (direction) {
                String strName = helper.places[index].name;
                helper.deletePlace(helper.places[index]);
                setState(() {
                  helper.places.removeAt(index);
                });
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("$strName deleted")));
              },
              child:ListTile(
          title: Text(helper.places[index].name),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              PlaceDialog dialog = PlaceDialog(helper.places[index], false);
              showDialog(
                context: context,
                builder: (context) =>
                    dialog.buildAlert(context));
                },),
        ));
      },
    );
  }
}