import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:treasuremapp_book/places_list.dart';
import 'dbhelper.dart';
import 'place.dart';
import 'place_dialog.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainMap(),
    );
  }
}
class MainMap extends StatefulWidget {
  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  DbHelper helper;
  List<Marker> _markers = [];
  
  final CameraPosition position = CameraPosition(
    target: LatLng(41.9028, 12.4964),
    zoom: 12,
  );

  @override
  void initState() {
    _getCurrentLocation().then((pos){
      _addMarker(pos, 'currpos', 'You are here!');
    }).catchError(
      (err)=> print(err.toString()));
     helper = DbHelper();
     //helper.insertMockData();
     _getData();

    super.initState();
    }

  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: Text('The Treasure Mapp'),
      actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              MaterialPageRoute route = MaterialPageRoute(builder: (context)=> ManagePlaces());
              Navigator.push(context, route);
            },
          ),
        ],),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_location),
        onPressed: () {
          int here = _markers.indexWhere((p)=> p.markerId == MarkerId('currpos'));
          Place place;
          if (here == -1) {
            //the current position is not available
               place = Place(0, '', 0, 0, '');          
          }
          else {
          LatLng pos = _markers[here].position;
             place = Place(0, '', pos.latitude, pos.longitude, '');
          }
          PlaceDialog dialog = PlaceDialog(place, true);
          showDialog(
            context: context,
            builder: (context) =>
                dialog.buildAlert(context));
      },
      ),
       body: Container(child: GoogleMap(
          initialCameraPosition: position,
          markers: Set<Marker>.of(_markers),

      ),
    ));
  }

  Future _getCurrentLocation() async {
    bool isGeolocationAvailable = await Geolocator().isLocationServiceEnabled(); 
    Position _position = Position(latitude: this.position.target.latitude, longitude: this.position.target.longitude);
    
    if (isGeolocationAvailable) {
      try { 
        _position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
        print('ok');
      }
      catch (error) {
        return _position;
      }
    }
    return _position;
  }

  void _addMarker(Position pos, String markerId, String markerTitle ) {
    final marker = Marker(
          markerId: MarkerId(markerId),
          position: LatLng(pos.latitude, pos.longitude),
          infoWindow: InfoWindow(title: markerTitle),
          icon: (markerId=='currpos') ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure):BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange)
      );
      _markers.add(marker);
      setState(() {
        _markers = _markers;
      });
  }

  Future _getData() async {
    await helper.openDb();
    // await helper.testDb();
    List <Place> _places =  await helper.getPlaces();
    for (Place p in _places) {
    //  _addMarker(Position(latitude: p.lat, longitude: p.lon), p.id.toString(),  p.name) ;
    }
    setState(() {
      _markers = _markers;
    });
  }
}


