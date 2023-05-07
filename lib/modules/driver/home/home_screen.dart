import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/modules/driver/attach_bill/attach_bill_screen.dart';
import 'package:waddy_app/modules/driver/create_route/create_route_screen.dart';
import 'package:waddy_app/modules/driver/notification/notification_screen.dart';
import 'package:waddy_app/modules/driver/reports/reports_screen.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myFavColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: myFavColor,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        title: Image.asset("assets/images/waddi.png"),
        centerTitle: true,
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: false,
            floating: true,
            backgroundColor: myFavColor,
            expandedHeight: size.height * 120 / size.height,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage("assets/images/ahmed.jpg"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Good Morning",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          color: myFavColor2, fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.handHoldingHeart,
                                    color: myFavColor7,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Saed Reda",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: myFavColor5, fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        navigateTo(context, const DriverNotificationScreen());
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: myFavColor7),
                        ),
                        child: Icon(
                          Icons.notifications,
                          color: myFavColor7,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  mySizedBox(size: size, myHeight: 23),
                  Image.asset("assets/images/on-boarding-1.png"),
                  mySizedBox(size: size, myHeight: 44),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            navigateTo(
                                context, const DriverCreateRouteScreen());
                          },
                          child: Container(
                            width: size.width * 150 / size.width,
                            height: size.height * 100 / size.height,
                            decoration: BoxDecoration(
                                color: myFavColor7,
                                border: Border.all(
                                  color: myFavColor,
                                ),
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(24))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: myFavColorWithOpacity,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: myFavColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.route,
                                        color: myFavColor7,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "Routes",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontSize: 20, color: myFavColor8),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      mySizedBox(size: size, myWidth: 30),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            navigateTo(context, const DriverReportScreen());
                          },
                          child: Container(
                            width: size.width * 150 / size.width,
                            height: size.height * 100 / size.height,
                            decoration: BoxDecoration(
                                color: myFavColor7,
                                border: Border.all(
                                  color: myFavColor,
                                ),
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(24))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: myFavColorWithOpacity,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: myFavColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.filePrescription,
                                        color: myFavColor7,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "Reports",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontSize: 20, color: myFavColor8),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            navigateTo(
                                context, const DeliveryAttachBillScreen());
                          },
                          child: Container(
                            width: size.width * 150 / size.width,
                            height: size.height * 100 / size.height,
                            decoration: BoxDecoration(
                                color: myFavColor7,
                                border: Border.all(
                                  color: myFavColor,
                                ),
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(24))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: myFavColorWithOpacity,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: myFavColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.moneyBills,
                                        color: myFavColor7,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "Attach Bill",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontSize: 20, color: myFavColor8),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      mySizedBox(size: size, myWidth: 30),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: size.width * 150 / size.width,
                            height: size.height * 100 / size.height,
                            decoration: BoxDecoration(
                                color: myFavColor7,
                                border: Border.all(
                                  color: myFavColor,
                                ),
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(24))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: myFavColorWithOpacity,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: myFavColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.exclamation,
                                        color: myFavColor7,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "Help Center",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontSize: 20, color: myFavColor8),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
