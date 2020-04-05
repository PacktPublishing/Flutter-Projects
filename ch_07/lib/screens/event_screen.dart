import '../models/favourite.dart';
import '../shared/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_detail.dart';
import 'login_screen.dart';
import '../shared/authentication.dart';

class EventScreen extends StatelessWidget {
  final String uid;
  EventScreen(this.uid);
  @override
  Widget build(BuildContext context) {
    Authentication auth = new Authentication();
    return Scaffold(
      appBar: AppBar(
        title: Text('Event'),
        actions:[ 
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                auth.signOut().then((result) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                });
              },
            )
          ],
        ),
      body: EventList(uid)
    );
  }
}

class EventList extends StatefulWidget {
  final String uid;
  EventList(this.uid);
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  //final String uid;
  _EventListState();
  final Firestore db = Firestore.instance;
  List<EventDetail> details = [];
  List<Favourite> favourites = [];
  @override
  void initState() {
    getDetailsList().then((data){
      setState(() {
        details = data;
      });
    });
    FirestoreHelper.getUserFavourites(widget.uid).then((data){
      setState(() {
        favourites = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: (details!= null)? details.length : 0,
      itemBuilder: (context, position){
        String sub='Date: ${details[position].date} - Start: ${details[position].startTime} - End: ${details[position].endTime}';
        Color starColor = (isUserFavourite(details[position].id)?Colors.amber:Colors.grey);
        return ListTile(
          title: Text(details[position].description),
          subtitle: Text(sub),
          trailing: IconButton(
            icon: Icon(Icons.star, color: starColor),
            onPressed: () {toggleFavourite(details[position]);},
          ),
        );
      },
    );
  }

  Future<List<EventDetail>> getDetailsList() async {
    var data = await db.collection('event_details').getDocuments();
    int i = 0;
    if (data!= null) {
      details = data.documents.map((document)=> EventDetail.fromMap(document)).toList();
      details.forEach((detail){
        detail.id = data.documents[i].documentID;
        i++;
      });
    }
    return details;

  }

  toggleFavourite(EventDetail ed) async{
    if (isUserFavourite(ed.id)) {
      Favourite favourite = favourites
        .firstWhere((Favourite f) => (f.eventId == ed.id));
      String favId = favourite.id;
      await FirestoreHelper.deleteFavourite(favId);
    }
    else {
      await FirestoreHelper.addFavourite(ed, widget.uid);
    }
    List<Favourite> updatedFavourites = await FirestoreHelper.getUserFavourites(widget.uid);
    setState(() {
      favourites = updatedFavourites;
    });
  }

  bool isUserFavourite (String eventId) {
    Favourite favourite = favourites
      .firstWhere((Favourite f) => (f.eventId == eventId),
    orElse: () => null  );

    if (favourite==null) 
      return false;
    else 
      return true;
  }
}