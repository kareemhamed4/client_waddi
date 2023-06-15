import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waddy_app/modules/common/splash/second_splash_screen.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class FirstSplashScreen extends StatefulWidget {
  final bool isUserLoginBefore;
  final bool isDelegateLoginBefore;
  final bool isNoLoginDetected;
  final bool isFirstTime;
  const FirstSplashScreen({
    Key? key,
    this.isUserLoginBefore = false,
    this.isDelegateLoginBefore = false,
    this.isNoLoginDetected = false,
    this.isFirstTime = false,
  }) : super(key: key);

  @override
  State<FirstSplashScreen> createState() => _FirstSplashScreenState();
}

class _FirstSplashScreenState extends State<FirstSplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: myFavColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: myFavColor,
          systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: AnimatedSplashScreen(
        nextScreen: SecondSplashScreen(
            isUserLoginBefore: widget.isUserLoginBefore,
            isDelegateLoginBefore: widget.isDelegateLoginBefore,
            isNoLoginDetected: widget.isNoLoginDetected,
            isFirstTime: widget.isFirstTime,
        ),
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
        duration: 1200,
      ),
    );
  }
}
