import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class UserNotificationSettingScreen extends StatefulWidget {
  const UserNotificationSettingScreen({Key? key}) : super(key: key);

  @override
  State<UserNotificationSettingScreen> createState() => _UserNotificationSettingScreenState();
}

class _UserNotificationSettingScreenState extends State<UserNotificationSettingScreen> {
  bool isGeneralNotification = true;
  bool isSound = true;
  bool isVibrate = false;
  bool isSpecialOffers = true;
  bool isPromo = false;
  bool isPayments = false;
  bool isAppUpdate = true;
  bool isNewServiceAvailable = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "Notification",
        titleColor: myFavColor2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "General Notification",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2,fontSize: 24),
                ),
                FlutterSwitch(
                  value: isGeneralNotification,
                  height: 25,
                  width: 45,
                  activeColor: myFavColor,
                  toggleSize: 20,
                  onToggle: (val) {
                    setState(() {
                      isGeneralNotification = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sound",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2,fontSize: 24),
                ),
                FlutterSwitch(
                  value: isSound,
                  height: 25,
                  width: 45,
                  activeColor: myFavColor,
                  toggleSize: 20,
                  onToggle: (val) {
                    setState(() {
                      isSound = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Vibrate",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2,fontSize: 24),
                ),
                FlutterSwitch(
                  value: isVibrate,
                  height: 25,
                  width: 45,
                  activeColor: myFavColor,
                  toggleSize: 20,
                  onToggle: (val) {
                    setState(() {
                      isVibrate = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Special Offers",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2,fontSize: 24),
                ),
                FlutterSwitch(
                  value: isSpecialOffers,
                  height: 25,
                  width: 45,
                  activeColor: myFavColor,
                  toggleSize: 20,
                  onToggle: (val) {
                    setState(() {
                      isSpecialOffers = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Promo & Discount",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2,fontSize: 24),
                ),
                FlutterSwitch(
                  value: isPromo,
                  height: 25,
                  width: 45,
                  activeColor: myFavColor,
                  toggleSize: 20,
                  onToggle: (val) {
                    setState(() {
                      isPromo = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payments",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2,fontSize: 24),
                ),
                FlutterSwitch(
                  value: isPayments,
                  height: 25,
                  width: 45,
                  activeColor: myFavColor,
                  toggleSize: 20,
                  onToggle: (val) {
                    setState(() {
                      isPayments = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "App Update",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2,fontSize: 24),
                ),
                FlutterSwitch(
                  value: isAppUpdate,
                  height: 25,
                  width: 45,
                  activeColor: myFavColor,
                  toggleSize: 20,
                  onToggle: (val) {
                    setState(() {
                      isAppUpdate = val;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New Service Available",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2,fontSize: 24),
                ),
                FlutterSwitch(
                  value: isNewServiceAvailable,
                  height: 25,
                  width: 45,
                  activeColor: myFavColor,
                  toggleSize: 20,
                  onToggle: (val) {
                    setState(() {
                      isNewServiceAvailable = val;
                    });
                  },
                ),
              ],
            ),
            mySizedBox(size: size,myHeight: 175),
          ],
        ),
      ),
    );
  }
}
