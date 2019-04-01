import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  final name;
  final imageUrl;
  final location;
  final rating;
  final reviewsCount;
  final DocumentReference reference;

  Restaurant({
    @required this.name,
    @required this.imageUrl,
    @required this.location,
    @required this.rating,
    @required this.reviewsCount,
    this.reference
  });

  Restaurant.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['name'] != null),
      assert(map['image_url'] != null),
      assert(map['location'] != null),
      assert(map['rating'] != null),
      assert(map['reviews_count'] != null),
      name = map['name'],
      imageUrl = map['image_url'],
      location = map['location'],
      rating = map['rating'],
      reviewsCount = map['reviews_count'];

  Restaurant.fromSnapShot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);
}