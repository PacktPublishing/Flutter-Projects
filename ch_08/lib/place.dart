class Place {
  int id;
  String name;
  double lat;
  double lon;
  String image;


  Place(this.id, this.name, this.lat, this.lon, this.image);

  Map<String, dynamic> toMap() {
    return {
      'id': (id==0)?null:id,
      'name': name,
      'lat': lat,
      'lon': lon,
      'image': image
    };
  }


}