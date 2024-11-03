import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/Providers/UserProvider.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages Page'),
      ),
      body: Center(
        child: user == null
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Email: ${user.email}'),
            Text('User ID: ${user.userName}'),
          ],
        ),
      ),
    );
  }
}