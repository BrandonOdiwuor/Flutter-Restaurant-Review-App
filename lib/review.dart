import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final comment;
  final rating;
  final reviewer;
  final restaurant_reference;
  final DocumentReference reference;

  Review({
    @required this.comment,
    @required this.rating,
    @required this.reviewer,
    this.restaurant_reference,
    this.reference
  });

  Review.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['reviewer'] != null),
      assert(map['rating'] != null),
      assert(map['comment'] != null),
      assert(map['restaurant_reference'] != null),
      reviewer = map['reviewer'],
      comment = map['comment'],
      rating = map['rating'],
      restaurant_reference= map['restaurant_reference'];

  Review.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() {
    return '$reviewer, $rating, $comment \n';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'reviewer': reviewer,
      'rating': rating,
      'comment': comment,
      'restaurant_reference': restaurant_reference
    };
    return json;
  }
}