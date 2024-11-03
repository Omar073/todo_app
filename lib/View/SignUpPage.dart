import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Model/Classes/User.dart' as myUser;

import '../Model/Providers/TodoProvider.dart';
import '../Model/Providers/UserProvider.dart';
import 'HomePage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Handle successful sign-up
      debugPrint('Sign up successful');
      // Set the current user in the UserProvider
      Provider.of<UserProvider>(context, listen: false)
          .addUserToCollection(_userNameController.text);

      final doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user?.uid)
          .get();
      myUser.User u1 = myUser.User.fromFirestore(doc);
      Provider.of<UserProvider>(context, listen: false).setUser(u1);

      // Fetch todos for the new user
      // await Provider.of<TodoProvider>(context, listen: false).fetchTodos();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<TodoProvider>(context, listen: false).fetchTodos();
      });

      // Navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle sign-up error
      debugPrint("failed to sign up");
      debugPrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
