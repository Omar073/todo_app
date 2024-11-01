import 'package:flutter/cupertino.dart';

class LastActivityPage extends StatefulWidget {
  const LastActivityPage({super.key});

  @override
  State<LastActivityPage> createState() => _LastActivityPageState();
}

class _LastActivityPageState extends State<LastActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text("Last Activity Page"),
      ],
    );
  }
}
