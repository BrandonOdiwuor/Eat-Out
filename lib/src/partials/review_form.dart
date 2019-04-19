import 'package:flutter/material.dart';
import '../model/reviews_bloc.dart';
import '../model/restaurant.dart';
import '../model/review.dart';

class ReviewForm extends StatefulWidget {
  final ReviewsBloc bloc;
  final Restaurant restaurant;

  ReviewForm({this.bloc, this.restaurant});

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  final _ratingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review ${widget.restaurant.name}'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: _form(context),
      ),
    );
  }

  Widget _form(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: TextFormField(
              controller: _ratingController,
              decoration: InputDecoration(
                  labelText: 'Rating',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
              ),
              validator: (rating) {
                if(rating.isEmpty) {
                  return 'Rating field cannot be empty';
                }
                if(int.parse(rating) < 1) {
                  return 'Rating cannot be less than 1';
                }
                if(int.parse(rating) > 5) {
                  return 'Rating cannot be greater than 5';
                }
              },
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: TextFormField(
              controller: _commentController,
              decoration: InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
              ),
              maxLines: 4,
              validator: (comment) {
                if(comment.isEmpty) return 'Comment field cannot be empty';
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: RaisedButton(
              onPressed: () {
                if(_formKey.currentState.validate()) {

                  final review = Review(
                    reviewer: 'Brandon Odiwuor',
                    rating: int.parse(_ratingController.text),
                    comment: _commentController.text,
                    restaurantId: widget.restaurant.reference.documentID,
                  );
                  widget.bloc.addReview.add(review);
                  Navigator.pop(context);
                }
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Submit'),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Icon(Icons.send),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}