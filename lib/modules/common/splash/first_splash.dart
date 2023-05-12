import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waddy_app/modules/common/splash/second_splash_screen.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class FirstSplashScreen extends StatelessWidget {
  const FirstSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: AnimatedSplashScreen(
        nextScreen: const SecondSplashScreen(),
        splash: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/splash-1.png",
                  width: size.width * 247/375,
                  height: size.height * 275/812,
                ),
              ],
            ),
            if(Platform.isAndroid)
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  color: myFavColor7,
                  strokeWidth: 3,
                ),
              ),
            if(Platform.isIOS)
              CupertinoActivityIndicator(
                color: myFavColor7,
                radius: 15,
              ),
          ],
        ),
        splashIconSize: size.height * 400/812,
        backgroundColor: myFavColor,
      ),
    );
  }
}
