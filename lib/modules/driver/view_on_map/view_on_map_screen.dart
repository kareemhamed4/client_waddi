import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/network/local/cache_helper.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/constants/constants.dart';
import 'package:waddy_app/shared/components/my_google_map.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class DriverViewOnMapScreen extends StatefulWidget {
  const DriverViewOnMapScreen({Key? key}) : super(key: key);

  @override
  State<DriverViewOnMapScreen> createState() => _DriverViewOnMapScreenState();
}

class _DriverViewOnMapScreenState extends State<DriverViewOnMapScreen> {
  double sheetHeight = 146.0;
  bool isSheetExpanded = false;
  double startPos = 0.0;
  double startHeight = 0.0;

  @override
  void initState() {
    currentLocationAsString = CacheHelper.getData(key: 'currentLocation');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBarForOnlyStatusBar(),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Visibility(
              visible: currentLocation != null,
              replacement: const Center(
                child: Text("Loading"),
              ),
              child: const MyGoogleMap(
                isGoToMyLocationEnabled: false,
                isTracking: false,
                zoom: 11,
                isPlaces: false,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onVerticalDragStart: (DragStartDetails details) {
                  startPos = details.globalPosition.dy;
                  startHeight = sheetHeight;
                },
                onVerticalDragUpdate: (DragUpdateDetails details) {
                  setState(() {
                    double delta = details.globalPosition.dy - startPos;
                    sheetHeight = startHeight - delta;
                    if (sheetHeight < 146) {
                      sheetHeight = 146;
                      isSheetExpanded = false;
                    } else if (sheetHeight > 420) {
                      sheetHeight = 420;
                      isSheetExpanded = true;
                    }
                  });
                },
                onVerticalDragEnd: (_) {
                  setState(() {
                    if (sheetHeight > 180) {
                      sheetHeight = 420;
                      isSheetExpanded = true;
                    } else {
                      sheetHeight = 146;
                      isSheetExpanded = false;
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  height: sheetHeight,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 20),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 35,
                            height: 4,
                            decoration: BoxDecoration(
                              color: myFavColor4,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          mySizedBox(size: size, myHeight: 30),
                          Text(
                            "Delivery",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: myFavColor2),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Scheduled at : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: 14, color: myFavColor2),
                              ),
                              Text(
                                "08:30 pm ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: 14, color: myFavColor),
                              ),
                              FaIcon(
                                FontAwesomeIcons.clock,
                                color: myFavColor4,
                                size: 16,
                              )
                            ],
                          ),
                          if (sheetHeight == 420 && isSheetExpanded)
                            const SizedBox(
                              height: 40,
                            ),
                          if (sheetHeight == 420 && isSheetExpanded)
                            Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Divider(
                                      height: 0,
                                      thickness: 1,
                                      color: myFavColor4.withOpacity(0.5),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "DURATION",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: myFavColor4, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "3 minute",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: myFavColor2, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Divider(
                                      height: 0,
                                      thickness: 1,
                                      color: myFavColor4.withOpacity(0.2),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "LOCATION NAME",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: myFavColor4, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Cairo",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: myFavColor2, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Divider(
                                      height: 0,
                                      thickness: 1,
                                      color: myFavColor4.withOpacity(0.2),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "ORDER ID",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: myFavColor4, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "ORD016",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: myFavColor2, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Divider(
                                      height: 0,
                                      thickness: 1,
                                      color: myFavColor4.withOpacity(0.2),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "BOXES",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: myFavColor4, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "4",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: myFavColor2, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: myFavColor8.withAlpha(20),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 0),
                          ),
                        ]),
                        child: CircleAvatar(
                          backgroundColor: myFavColor7,
                          radius: 18,
                          child: Icon(
                            Icons.arrow_back_outlined,
                            color: myFavColor,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: myFavColor8.withAlpha(20),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 0),
                          ),
                        ]),
                        child: CircleAvatar(
                          backgroundColor: myFavColor7,
                          radius: 18,
                          child: Icon(
                            Icons.settings,
                            color: myFavColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
