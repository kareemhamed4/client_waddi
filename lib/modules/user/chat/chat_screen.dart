import 'package:flutter/material.dart';

class UserChatScreen extends StatelessWidget {
  const UserChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Chat Screen',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
