import 'dart:async';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class MyReusableComponent {
  static Future<void> performTask({
    required BuildContext context,
    required Future<void> Function() somethingToDo,
    required GlobalKey<LiquidPullToRefreshState> refreshIndicatorKey,
  }) {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 2), () {
      completer.complete();
    });

    somethingToDo(); // Execute the provided function

    return completer.future.then<void>((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
            label: 'RETRY',
            textColor: myFavColor5,
            onPressed: () {
              refreshIndicatorKey.currentState!.show();
            },
          ),
        ),
      );
    });
  }
}