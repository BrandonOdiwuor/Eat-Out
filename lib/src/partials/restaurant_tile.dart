import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../model/restaurant.dart';
import '../restaurant_page.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantTile({@required this.restaurant}) : assert(restaurant != null);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(16.0),
      title: Text(restaurant.name),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/loading.gif',
          image: restaurant.imageUrl,
          height: 56.0,
          width: 100.0,
          fit: BoxFit.fill,
        ),
      ),
      subtitle: _subtitle(),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantPage(restaurant: restaurant),
          ),
        );
      },
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
                child: _restaurantsStarWidget(),
              ),
              Text('${restaurant.reviewsCount} reviews'),
            ],
          ),
          Text('${restaurant.location} · ${restaurant.type}'),
        ],
      ),
    );
  }

  Widget _restaurantsStarWidget() {
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
}