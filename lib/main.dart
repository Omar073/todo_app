import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Model/Providers/TodoProvider.dart';
import 'View/LandingPage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: MaterialApp(
        home: LandingPage(),
      ),
    );
  }
}