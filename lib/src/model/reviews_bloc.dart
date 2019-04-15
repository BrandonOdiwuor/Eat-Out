import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:meta/meta.dart';
import 'review.dart';

class ReviewsBloc {
  final restaurantId;

  ReviewsBloc({@required this.restaurantId}) : assert(restaurantId != null) {
    _addReviewController.stream.listen(_handleReviewAddition);
    _getReviews();
  }

  final _reviewsBS = BehaviorSubject.seeded(<Review>[]);
  Stream get reviews => _reviewsBS.stream;

  final _reviewsCountBS = BehaviorSubject.seeded(0);
  Stream get reviewsCount => _reviewsCountBS.stream;

  final _isLoadingBS = BehaviorSubject.seeded(true);
  Stream get isLoading => _isLoadingBS.stream;

  final _addReviewController = StreamController<Review>();
  Sink get addReview => _addReviewController.sink;

  void _getReviews() async {
    _isLoadingBS.add(true);
    final reviews = <Review>[];
    Stream<QuerySnapshot> stream = Firestore.instance.collection('reviews')
        .where('restaurant_id', isEqualTo: restaurantId).snapshots();
    await for(QuerySnapshot snapshot in stream) {
      snapshot.documents.forEach((documentSnapshot) {
        var r = Review.fromSnapshot(snapshot: documentSnapshot);
        print(r.comment);
        reviews.add(Review.fromSnapshot(snapshot: documentSnapshot));
      });
      _reviewsBS.add(reviews);
      _reviewsCountBS.add(reviews.length);
      _isLoadingBS.add(false);
    }
  }

  void _handleReviewAddition(Review review) {
    Firestore.instance.collection('reviews').document().setData({
      'restaurant_id': review.restaurantId,
      'reviewer': review.reviewer,
      'comment': review.comment,
      'rating': review.rating,
    });
    _getReviews();
  }

  dispose() {
    _reviewsBS.close();
    _addReviewController.close();
  }
}