import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantBloc {
  String _currentRestaurantType;
  String _currentRestaurantLocation;

  RestaurantBloc() {
    _typeFilterController.stream.listen(_handleTypeFilter);
    _locationFilterController.stream.listen(_handleLocationFilter);
    _currentRestaurantType = restaurantTypes[0];
    _currentRestaurantLocation = restaurantLocations[0];
    _getRestaurants();
  }

  final _typeFilterController = StreamController<String>();
  Sink get typeFilter => _typeFilterController.sink;

  final _locationFilterController = StreamController<String>();
  Sink get locationFilter => _locationFilterController.sink;

  final _restaurantsBS = BehaviorSubject.seeded(<Restaurant>[]);
  Stream get restaurants => _restaurantsBS.stream;

  final _restaurantsCountBS = BehaviorSubject.seeded(0);
  Stream get restaurantsCount => _restaurantsCountBS.stream;

  final _isLoadingBS = BehaviorSubject.seeded(true);
  Stream get loading => _isLoadingBS.stream;

  void _handleTypeFilter(String type) {
    _currentRestaurantType = type;
    _getRestaurants();
  }

  void _handleLocationFilter(String location) async {
    _currentRestaurantLocation = location;
    _getRestaurants();
  }

  void _getRestaurants() async {
    _isLoadingBS.add(true);
    List<Restaurant> restaurants = <Restaurant>[];
    Stream<QuerySnapshot> stream = _getQuerySnapshot();
    await for(QuerySnapshot querySnapshot in stream) {
      querySnapshot.documents.forEach((documentSnapshot) {
        restaurants.add(Restaurant.fromSnapshot(snapshot: documentSnapshot));
      });
      _restaurantsBS.add(restaurants);
      _restaurantsCountBS.add(restaurants.length);
      _isLoadingBS.add(false);
    }
  }

  Stream<QuerySnapshot> _getQuerySnapshot() {
    if(_currentRestaurantLocation == restaurantLocations[0]) {
      return _currentRestaurantType == restaurantTypes[0] ?
      Firestore.instance.collection('restaurants').snapshots() :
      Firestore.instance.collection('restaurants')
          .where('type', isEqualTo: _currentRestaurantType).snapshots();
    } else {
      return _currentRestaurantType == restaurantTypes[0] ?
      Firestore.instance.collection('restaurants')
          .where('location', isEqualTo: _currentRestaurantLocation).snapshots() :
      Firestore.instance.collection('restaurants')
          .where('type', isEqualTo: _currentRestaurantType)
          .where('location', isEqualTo: _currentRestaurantLocation).snapshots();
    }
  }

  void dispose() {
    _locationFilterController.close();
    _typeFilterController.close();
    _restaurantsBS.close();
  }

  List<String> get restaurantTypes => <String>[
    'All Restaurants',
    'Brazilian',
    'Lebanese',
    'Ethiopian',
    'Japanese',
    'Indian',
    'Cuban',
    'Ghanaian',
    'Nigerian',
    'Swahili',
  ];

  List<String> get restaurantLocations => [
    'All Nairobi',
    'CBD',
    'Westlands',
    'Kileleshwa',
    'Kilimani',
    'Lavington',
  ];
}