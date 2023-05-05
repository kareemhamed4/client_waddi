import 'dart:async';
import 'package:flutter/material.dart';
import 'package:waddy_app/modules/login/waddy_login_screen.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/network/local/cache_helper.dart';

class FirstSplash extends StatefulWidget {
  const FirstSplash({Key? key}) : super(key: key);

  @override
  State<FirstSplash> createState() => _FirstSplashState();
}

class _FirstSplashState extends State<FirstSplash> {
  void onSubmit() {
    CacheHelper.saveData(key: 'firstSplash', value: true).then((value) {
      if (value!) {
        navigateToAndFinish(context, WaddyLoginScreen());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      onSubmit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          colors: [
            Colors.red,
            Colors.redAccent,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Image(
            image: AssetImage('assets/images/splash-1.png'),
            height: 300.0,
            width: 300.0,
          ),
          CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3.0,
          ),
        ],
      ),
    );
  }
}
