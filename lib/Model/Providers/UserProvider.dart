import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Model/Classes/User.dart' as myUser;

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  myUser.User? _user;

  myUser.User? get user => _user;

  UserProvider() {
    _auth.authStateChanges().listen((User? user) async => _onAuthStateChanged(
        user != null
            ? myUser.User.fromFirestore(
                await _firestore.collection('Users').doc(user.uid).get())
            : null));
  }

  Future<void> _onAuthStateChanged(myUser.User? user) async {
    _user = user;
    notifyListeners();
  }

  void setUser(myUser.User user) {
    _user = user;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  //add user to collection
  Future<void> addUserToCollection(String uName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestore.collection('Users').doc(user.uid).set({
        'email': user.email,
        'userName': uName,
      });
      notifyListeners();
    }
  }
}
