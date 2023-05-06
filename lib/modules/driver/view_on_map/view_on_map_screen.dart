import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/constants.dart';
import 'package:waddy_app/shared/components/my_google_map.dart';
import 'package:waddy_app/shared/network/local/cache_helper.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class DriverViewOnMapScreen extends StatefulWidget {
  const DriverViewOnMapScreen({Key? key}) : super(key: key);

  @override
  State<DriverViewOnMapScreen> createState() => _DriverViewOnMapScreenState();
}

class _DriverViewOnMapScreenState extends State<DriverViewOnMapScreen> {
  double sheetHeight = 146.0;
  bool isSheetExpanded = false;
  void onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      sheetHeight -= details.primaryDelta!;
      if (sheetHeight < 146) {
        sheetHeight = 146;
        isSheetExpanded = false;
      } else if (sheetHeight > 400) {
        sheetHeight = 400;
        isSheetExpanded = true;
      }
    });
  }

  @override
  void initState() {
    currentLocationAsString = CacheHelper.getData(key: 'currentLocation');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    deviceHeight = size.height;
    deviceWidth = size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: myFavColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: myFavColor,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            currentLocation == null
                ? const Text("Loading")
                : const MyGoogleMap(
                    isGoToMyLocationEnabled: false,
                    isTracking: false,
                    isPlaces: false,
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onVerticalDragUpdate: onVerticalDragUpdate,
                onVerticalDragEnd: (_) {
                  setState(() {
                    if (sheetHeight > 180) {
                      sheetHeight = 400;
                      isSheetExpanded = true;
                    } else {
                      setState(() {
                        sheetHeight = 146;
                        isSheetExpanded = false;
                      });
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
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
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
                        if (!isSheetExpanded)
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Divider(
                                height: 0,
                                thickness: 1,
                                color: myFavColor4.withOpacity(0.5),
                              ),
                            ),
                          ),
                        if (sheetHeight == 400 && isSheetExpanded)
                          const SizedBox(
                            height: 40,
                          ),
                        if (sheetHeight == 400 && isSheetExpanded)
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
                                  const SizedBox(height: 12,),
                                  Text(
                                    "DURATION",
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4,fontSize: 16),
                                  ),
                                  const SizedBox(height: 6,),
                                  Text(
                                    "3 minute",
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2,fontSize: 16),
                                  ),
                                  const SizedBox(height: 12,),
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
                                  const SizedBox(height: 12,),
                                  Text(
                                    "LOCATION NAME",
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4,fontSize: 16),
                                  ),
                                  const SizedBox(height: 6,),
                                  Text(
                                    "Cairo",
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2,fontSize: 16),
                                  ),
                                  const SizedBox(height: 12,),
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
                                  const SizedBox(height: 12,),
                                  Text(
                                    "ORDER ID",
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4,fontSize: 16),
                                  ),
                                  const SizedBox(height: 6,),
                                  Text(
                                    "ORD016",
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2,fontSize: 16),
                                  ),
                                  const SizedBox(height: 12,),
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
                                  const SizedBox(height: 12,),
                                  Text(
                                    "BOXES",
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4,fontSize: 16),
                                  ),
                                  const SizedBox(height: 6,),
                                  Text(
                                    "4",
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2,fontSize: 16),
                                  ),
                                  const SizedBox(height: 12,),
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
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 25),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundColor: myFavColor,
                  radius: 16,
                  child: Icon(Icons.arrow_back_outlined,color: myFavColor7,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
