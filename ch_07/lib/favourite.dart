class Favourite {
  String _id;
  String _eventId;
  String _userId;
 
Favourite(this._id, this._eventId, this._userId);

String get id => _id;
String get eventId => _eventId;
String get userId => _userId;

set id(String id) {
  _id = id;
}

Favourite.map(dynamic obj) {
    this._id = obj['id'];
    this._eventId = obj['eventId'];
    this._userId = obj['userId'];
  }

Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['eventId'] = _eventId;
    map['userId'] = _userId;
   
    return map;
  }
 
  Favourite.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._eventId = map['eventId'];
    this._userId = map['userId'];
   
  }
  }