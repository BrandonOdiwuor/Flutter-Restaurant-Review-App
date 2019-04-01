import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_reviews_app/restaurant.dart';
import 'package:restaurant_reviews_app/review.dart';
import 'package:restaurant_reviews_app/review_form.dart';

class ReviewsPage extends StatelessWidget {
  final Restaurant restaurant;

  ReviewsPage({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${restaurant.name}'),
        elevation: 0.0,
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReviewForm(restaurant: restaurant,)
            ),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('reviews').where(
          'restaurant_reference', isEqualTo: restaurant.reference.documentID
      ).snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();

        return _buildReviewsList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildReviewsList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildReview(context, data)).toList(),
    );
  }

  Widget _buildReview(BuildContext context, DocumentSnapshot data) {
    Review review = Review.fromSnapshot(data);
    return ListTile(
      leading: CircleAvatar(
        child: Text(review.reviewer.substring(0, 1).toUpperCase()),
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