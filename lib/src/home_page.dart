import 'package:flutter/material.dart';
import 'dropdown_button.dart';
import 'model/restaurant.dart';
import 'restaurant_tile.dart';
import 'model/restaurants_bloc.dart';
import 'colors.dart';

class HomePage extends StatefulWidget {
  final bloc = RestaurantsBloc();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eat Out'),
        elevation: 0.0,
      ),
      body: _body(context),
      backgroundColor: cranePurple800,
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _filterForms(),
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            margin: EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _header(context),
                StreamBuilder(
                  stream: widget.bloc.loading,
                  initialData: true,
                  builder: (context, snapshot) {
                    if(snapshot.data == true) {
                      return LinearProgressIndicator();
                    } else {
                      return Expanded(
                        child: _buildRestaurants(context),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: StreamBuilder(
        stream: widget.bloc.restaurantsCount,
        initialData: 0,
        builder: (context, snapshot) {
          return Text(
            '${snapshot.data} Available Restaurants',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
          );
        },
      ),
    );
  }

  Widget _buildRestaurants(BuildContext context) {
    return Container(
      child: StreamBuilder<List<Restaurant>>(
          stream: widget.bloc.restaurants,
          initialData: <Restaurant>[],
          builder: (context, snapshot) {
            return ListView(
              children: snapshot.data.map((restaurant) => RestaurantTile(restaurant: restaurant)).toList(),
            );
          }
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Divider(),
    );
  }

  Widget _filterForms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: MyDropDownButton(
            items: widget.bloc.restaurantLocations,
            filter: _onLocationChanged,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: MyDropDownButton(
            items: widget.bloc.restaurantTypes,
            filter: _onTypeChanged,
          ),
        ),
      ],
    );
  }

  void _onLocationChanged(String location) {
    widget.bloc.locationFilter.add(location);
  }

  void _onTypeChanged(String type) {
    widget.bloc.typeFilter.add(type);
  }
}