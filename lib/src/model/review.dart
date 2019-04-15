import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final restaurantId;
  final reviewer;
  final rating;
  final comment;
  final DocumentReference reference;

  Review({
    @required this.restaurantId,
    @required this.rating,
    @required this.reviewer,
    @required this.comment,
    this.reference
  }) :  assert(restaurantId != null),
        assert(rating != null),
        assert(reviewer != null),
        assert(comment != null);

  Review.fromMap(@required Map<String, dynamic> map, {this.reference})
      : assert(map['restaurant_id'] != null),
        assert(map['reviewer'] != null),
        assert(map['rating'] != null),
        assert(map['comment'] != null),
        restaurantId = map['restaurant_id'],
        reviewer = map['reviewer'],
        rating = map['rating'],
        comment = map['comment'];

  Review.fromSnapshot({@required DocumentSnapshot snapshot})
      : this.fromMap(snapshot.data, reference: snapshot.reference);

}