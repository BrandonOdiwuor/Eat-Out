import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  final name;
  final location;
  final type;
  final imageUrl;
  var currentRating;
  var reviewsCount;
  final DocumentReference reference;

  Restaurant({
    @required this.name,
    @required this.type,
    @required this.location,
    @required this.imageUrl,
    this.reference,
    this.currentRating = 0,
    this.reviewsCount = 0,
  }) :  assert(name != null),
        assert(type != null),
        assert(location != null);

  Restaurant.fromMap(@required Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['location'] != null),
        assert(map['type'] != null),
        assert(map['image_url'] != null),
        assert(map['current_rating'] != null),
        assert(map['reviews_count'] != null),
        name = map['name'],
        location = map['location'],
        type = map['type'],
        imageUrl = map['image_url'],
        currentRating = map['current_rating'],
        reviewsCount = map['reviews_count'];

  Restaurant.fromSnapshot({@required DocumentSnapshot snapshot})
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() {
    return 'name: $name, type: $type, location: $location';
  }
}