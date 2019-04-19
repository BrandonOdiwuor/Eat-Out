import 'package:flutter/material.dart';
import '../model/review.dart';
import 'colors.dart';

class ReviewTile extends StatelessWidget{
  final Review review;

  ReviewTile({this.review});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(review.reviewer.substring(0, 1).toUpperCase()),
        backgroundColor: cranePurple800,
      ),
      title: Text(review.reviewer),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _reviewsStarWidget(review.rating),
          Text(review.comment),
        ],
      ),
    );
  }

  Widget _reviewsStarWidget(int rating) {
    var stars = <Widget>[];
    for (int i = 0; i < 5; i++) {
      Icon star = i < rating
          ? Icon(Icons.star, color: Colors.orangeAccent, size: 12)
          : Icon(Icons.star_border, color: Colors.orangeAccent, size: 12);
      stars.add(star);
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}