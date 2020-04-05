import 'package:cloud_firestore/cloud_firestore.dart';
import './favourite.dart';
import './login.dart';
import 'package:flutter/material.dart';
import './authentication.dart';

import 'event.dart';

class EventsScreen extends StatefulWidget {
  EventsScreen({Key key, this.title, this.uid}) : super(key: key);
  final String title;
  final String uid;
  @override
  _EventsScreenState createState() => _EventsScreenState(uid);
}

class _EventsScreenState extends State<EventsScreen> {
  _EventsScreenState(uid);
  String uid;
  Firestore db = Firestore.instance;
  List<Event> events = [];
  List<Favourite> favourites = [];
  
  @override
  void initState() {
    super.initState();
    if (mounted) {
      getData();
    }
    
  }

  @override
  Widget build(BuildContext context) {
    // Access a Cloud Firestore instance from your Activity
    
    Authentication auth = new Authentication();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
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
        body: Center(
          child: ListView.builder(
            itemCount: (events == null) ? 0 : events.length,
            itemBuilder: (context, position) {
              String sub =
                  'Date: ${events[position].data} - Start: ${events[position].orainizio} - End: ${events[position].orafine}';
              return ListTile(
                  title: Text(events[position].descrizione),
                  subtitle: Text(sub),
                  trailing: (events[position].isFavourite)
                      ? IconButton(
                          icon: Icon(Icons.star, color: Colors.amber),
                          onPressed: () {
                            toggleFavourite(events[position], position);
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.star_border, color: Colors.grey),
                          onPressed: () {
                            toggleFavourite(events[position], position);
                          },
                        ));
            },
          ),
        ));
  }

  Future getData() async {
    List<Favourite> favs = await getUserFavourites();
    events = await getEventsList();

    events.forEach((Event event) {
      if (isUserFavourite(event)) {
        event.isFavourite = true;
      } else {
        event.isFavourite = false;
      }
    });
      setState(() {
        this.events = events;
        this.favourites = favs;
      });
    }
  
  void toggleFavourite(Event event, position) {
    event.isFavourite = !event.isFavourite;
    if (event.isFavourite) {
      addFavourite(event, uid);
    } else {
       Favourite f = favourites.firstWhere((Favourite f) {
        return (f.eventId == event.id && f.userId ==uid) ;
      });
      deleteFavourite(f.id);
    }
    setState(() {
      events[position] = event;
    });
  }

  Future<List<Event>> getEventsList() async {
    //Stream<QuerySnapshot> snapshots = db.collection('events').snapshots();
    var data = await db.collection('events').getDocuments();
    int i = 0;
    if (data != null) {
      events = data.documents.map((documentSnapshot) => Event.fromMap(documentSnapshot.data)).toList();
      events.forEach((f) {
        f.id = data.documents[i].documentID;
        i++;
      });
    }
    return events;
  }
    
  Future<List<Favourite>> getUserFavourites() async {
    //retrieves only the documents that belong to the current user
    CollectionReference favs = db.collection('favourites');
    int i = 0;
    var data = await favs.where('userId', isEqualTo: uid).getDocuments();
    if (data != null) {
      favourites = data.documents.map((documentSnapshot) => Favourite.fromMap(documentSnapshot.data)).toList();
      favourites.forEach((f) {
        f.id = data.documents[i].documentID;
        i++;
      });
    }
    return favourites;
  }

  bool isUserFavourite(Event e) {
    //checks whether the event that was passed is a user's favourite
    String eventId = e.id;

    if (favourites != null) {
      //very nice syntax!
      Favourite f = favourites.firstWhere((Favourite f) => f.eventId == eventId, orElse: ()=> null);

      if (f == null) {
        return false;
      } else {
        return true;
      }
    }
    else {
      return false;
    }
  }

  Future addFavourite(event, uid) async {
    var fav = {'userId': uid, 'eventId': event.id};
    db
        .collection('favourites')
        .add(fav)
        .then((onValue) => print('Insert favourite OK'));
  }

  Future deleteFavourite(String favId) async {
    await db.collection('favourites').document(favId).delete();
  }
}
