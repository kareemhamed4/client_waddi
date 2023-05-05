import 'package:flutter/material.dart';
import 'package:waddy_app/shared/components/components.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification',),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => notify(context),
          separatorBuilder: (context, index) => const SizedBox(height: 10.0,),
          itemCount: 10,
      ),
    );
  }
}
