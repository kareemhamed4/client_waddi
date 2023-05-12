import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waddy_app/modules/common/onboarding/waddy_on_boarding_screen.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class SecondSplashScreen extends StatelessWidget {
  const SecondSplashScreen({Key? key}) : super(key: key);

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
        nextScreen: const WaddyOnBoardingScreen(),
        splash: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomLeft,
          children: [
            Image.asset(
              "assets/images/splash2-bg.png",
              width: size.width,
              height: size.height,
              fit: BoxFit.fitHeight,
            ),
            Container(
              color: myFavColor8.withOpacity(0.4),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,bottom: 60),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome To 👋",style: Theme.of(context).textTheme.labelLarge!.copyWith(color: myFavColor7,fontSize: 40),),
                  mySizedBox(size: size,myHeight: 5),
                  Text("WADDI",style: Theme.of(context).textTheme.labelLarge!.copyWith(color: myFavColor,fontSize: 80),),
                  mySizedBox(size: size,myHeight: 5),
                  Text("The Best App For Shipping & Delivery\nIn Egypt",style: Theme.of(context).textTheme.labelLarge!.copyWith(color: myFavColor7,fontSize: 20),),
                ],
              ),
            ),
          ],
        ),
        splashIconSize: size.height,
        backgroundColor: myFavColor,
      ),
    );
  }
}
