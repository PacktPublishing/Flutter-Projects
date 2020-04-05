import '../models/event_detail.dart';
import '../models/favourite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static final Firestore db = Firestore.instance;

  static Future<List<Favourite>> getUserFavourites(String uid) async {
    List<Favourite> favs = [];
    QuerySnapshot docs = await db.collection('favourites')
      .where('userId', isEqualTo: uid).getDocuments();
    if (docs != null) {
      for (DocumentSnapshot doc in docs.documents) {
        favs.add(Favourite.map(doc));
      }
    }
    return favs;
  }  

  static Future addFavourite(EventDetail eventDetail, String uid) {
    Favourite fav = Favourite(null, eventDetail.id, uid);
    var result = db.collection('favourites').add(fav.toMap())
      .then((value) => print(value.documentID))
      .catchError((error)=> print (error));
    return result;
  }

  static Future deleteFavourite(String favId) async {
    await db.collection('favourites').document(favId).delete();
  }

  

}