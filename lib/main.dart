import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_reviews_app/restaurant.dart';
import 'package:restaurant_reviews_app/review_form.dart';
import 'package:restaurant_reviews_app/reviews_page.dart';
import 'package:restaurant_reviews_app/restaurant_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Reviews',
      home: _HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }

}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants Review'),
        //elevation: 0.0,
      ),
      body: _buildBody(context),
    );
  }
  
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('restaurants').snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();

        return _buildRestaurantsList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildRestaurantsList (BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildRestaurant(context, data)).toList(),
    );
  }

  Widget _buildRestaurant(BuildContext context, DocumentSnapshot data) {
    final restaurant = Restaurant.fromSnapShot(data);
    return RestaurantCard(restaurant: restaurant);
  }
 }