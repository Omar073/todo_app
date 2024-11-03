import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String userName;

  User({required this.email, required this.userName});

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      email: data['email'],
      userName: data['userName'],
    );
  }
}