import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/custom_icons_icons.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class DriverNotificationScreen extends StatelessWidget {
  const DriverNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "Notification",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Text(
                "Today",
                style:
                    Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 20,),
              buildNotificationItem(
                  context: context,
                  size: size,
                  shapePath: "assets/images/redShape.png",
                  iconWidget: FaIcon(FontAwesomeIcons.chartSimple,color: myFavColor7,),
                  title: "You Have a New Bonus !",
                  subTitle: "You got a bonus to get the work done quickly.",
              ),
              const SizedBox(height: 30,),
              Text(
                "Yesterday",
                style:
                    Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 20,),
              buildNotificationItem(
                context: context,
                size: size,
                shapePath: "assets/images/yellowShape.png",
                iconWidget: FaIcon(FontAwesomeIcons.locationDot,color: myFavColor7,),
                title: "New update!",
                subTitle: "Your address has been updated ",
              ),
              const SizedBox(height: 16,),
              buildNotificationItem(
                context: context,
                size: size,
                shapePath: "assets/images/roseShape.png",
                iconWidget: FaIcon(FontAwesomeIcons.triangleExclamation,color: myFavColor7,),
                title: "Warning !",
                subTitle: "Traffic congestion on your way!",
              ),
              const SizedBox(height: 30,),
              Text(
                "December 20, 2023",
                style:
                    Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 20,),
              buildNotificationItem(
                context: context,
                size: size,
                shapePath: "assets/images/tentShape.png",
                iconWidget: FaIcon(CustomIcons.wallet,color: myFavColor7,),
                title: "Check your credit card !",
                subTitle: "Your monthly wage is now available.",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildNotificationItem({
    required BuildContext context,
    required String shapePath,
    required Widget iconWidget,
    required String title,
    required String subTitle,
    required Size size,
  }) {
    return Container(
      height: 100,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: myFavColor8.withAlpha(20),
          spreadRadius: 1,
          blurRadius: 7,
          offset: const Offset(0, 0),
        ),
      ]),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: myFavColor7,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(shapePath),
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: iconWidget,
                  ),
                ],
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    width: size.width * 192/ size.width,
                    child: Text(
                      subTitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: myFavColor4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
