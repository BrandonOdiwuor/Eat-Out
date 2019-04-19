import 'package:flutter/material.dart';
import 'model/restaurant.dart';
import 'model/reviews_bloc.dart';
import 'partials/review_tile.dart';
import 'model/review.dart';
import 'partials/colors.dart';
import 'partials/review_form.dart';

class RestaurantPage extends StatelessWidget {
  final Restaurant restaurant;
  ReviewsBloc bloc;

  RestaurantPage({this.restaurant}) {
    bloc = ReviewsBloc(
        restaurantId: restaurant.reference.documentID
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: cranePurple800,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReviewForm(
                  bloc: bloc,
                  restaurant: restaurant,
                ),
              ),
            );
          }),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _picture(),
        _description(),
        Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Text(
            'Reviews:',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
          ),
        ),
        StreamBuilder(
          stream: bloc.isLoading,
          initialData: true,
          builder: (context, snapshot) {
            if(snapshot == true) {
              return LinearProgressIndicator();
            } else {
              return _displayReviews();
            }
          },
        ),
      ],
    );
  }

  Widget _picture() {
    return Stack(
      children: <Widget>[
        Container(
          child: Image.network(
            restaurant.imageUrl,
            //height: 250,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 24.0,
          left: 8.0,
          child: BackButton(color: Colors.white),
        )
      ],
    );
  }

  Widget _description() {
    return Container(
      //padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Text(
              restaurant.name,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: _subtitle(),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _subtitle() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('${restaurant.currentRating}'),
              Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: _starWidget(),
              ),
              Text('${restaurant.reviewsCount} reviews'),
            ],
          ),
          Text('${restaurant.type} Restaurant · Open'),
        ],
      ),
    );
  }

  Widget _starWidget() {
    var stars = <Widget>[];
    for (int i = 0; i < 5; i++) {
      Icon star = i < restaurant.currentRating
          ? Icon(Icons.star, color: Colors.orangeAccent, size: 12)
          : Icon(Icons.star_border, color: Colors.orangeAccent, size: 12);
      stars.add(star);
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }

  Widget _displayReviews() {
    return StreamBuilder(
      stream: bloc.reviewsCount,
      initialData: 0,
      builder: (context, snapshot) {
        if(snapshot.data == 0) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'No reviews yet',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          );
        } else {
          return Expanded(
            child: _reviews(),
          );
        }
      },
    );
  }

  Widget _reviews() {
    return Container(
      child: StreamBuilder<List<Review>>(
        stream: bloc.reviews,
        initialData: List<Review>(),
        builder: ((context, snapshot) {
          return ListView(
            children: snapshot.data.map((review) => ReviewTile(review: review)).toList(),
          );
        }),
      ),
    );
  }
}