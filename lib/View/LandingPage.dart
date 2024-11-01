import 'package:todo_app/View/LoginPage.dart';

import '../View/HomePage.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Container(
          color: Colors.transparent,
          width: double.infinity,
          height: double.infinity,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 50,
                ),
                SizedBox(height: 20),
                Text("الحاجات اللي ورايا",
                    style: TextStyle(fontSize: 30, color: Colors.blue)),
                SizedBox(height: 10),
                Text("Press anywhere to continue")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
