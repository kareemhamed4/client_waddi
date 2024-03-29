import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/models/driver/cities_latlang_model.dart';
import 'package:waddy_app/models/user/get_user_orders.dart';
import 'package:waddy_app/modules/user/chat_details/chat_details_screen.dart';
import 'package:waddy_app/modules/user/my_orders/cubit/cubit.dart';
import 'package:waddy_app/network/local/cache_helper.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/constants/constants.dart';
import 'package:waddy_app/shared/components/my_google_map.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class TrackingScreen extends StatefulWidget {
  final UserOrders userOrders;
  const TrackingScreen({Key? key, required this.userOrders}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  int currentStepIndex = 0;
  int currentStepIndex2 = 0;
  double sheetHeight = 410;
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
      body: SafeArea(
        child: Stack(
          children: [
            currentLocation == null
                ? const Text("Loading")
                : MyGoogleMap(
                    isGoToMyLocationEnabled: false,
                    isTracking: false,
                    isPlaces: false,
                    destination:
                        citiesLatLong.indexWhere((city) => city.cityName == widget.userOrders.receivedAddress!) != -1
                            ? destinationLatLong[
                                citiesLatLong.indexWhere((city) => city.cityName == widget.userOrders.receivedAddress!)]
                            : null,
                  ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onVerticalDragStart: (details) {
                  setState(() {
                    startPos = details.globalPosition.dy;
                    startHeight = sheetHeight;
                  });
                },
                onVerticalDragUpdate: (details) {
                  setState(() {
                    double dragDistance = details.globalPosition.dy - startPos;
                    sheetHeight = startHeight - dragDistance;
                    if (sheetHeight < 410) {
                      sheetHeight = 410;
                      isSheetExpanded = false;
                    } else if (sheetHeight > size.height - 40) {
                      sheetHeight = size.height - 40;
                      isSheetExpanded = true;
                    }
                  });
                },
                onVerticalDragEnd: (_) {
                  setState(() {
                    if (sheetHeight > 440) {
                      sheetHeight = size.height - 40;
                      isSheetExpanded = true;
                    } else {
                      sheetHeight = 410;
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
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 35,
                          height: 4,
                          decoration: BoxDecoration(
                            color: myFavColor4,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        mySizedBox(size: size, myHeight: 30),
                        Text(
                          "Your package is on the way",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Arriving at pick up point in 3 mins",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14, color: myFavColor4),
                          textAlign: TextAlign.center,
                        ),
                        if (!isSheetExpanded) mySizedBox(size: size, myHeight: 30),
                        if (sheetHeight == size.height - 40 && isSheetExpanded) mySizedBox(size: size, myHeight: 15),
                        if (sheetHeight == size.height - 40 && isSheetExpanded)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: myDivider(),
                          ),
                        if (sheetHeight == size.height - 40 && isSheetExpanded)
                          const SizedBox(
                            height: 8,
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 27,
                                    backgroundImage: AssetImage("assets/images/splash-1.png"),
                                  ),
                                  const SizedBox(
                                    width: 13,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${widget.userOrders.delegate!.firstName} ${widget.userOrders.delegate!.lastName}",
                                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/icons/star.png",
                                              width: 16,
                                              height: 16,
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              "4.8",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(fontSize: 14, color: myFavColor4),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    String phoneNumber =
                                        widget.userOrders.delegate!.phone!; // Replace with your actual phone number
                                    launchPhoneApp(phoneNumber);
                                  },
                                  icon: Image.asset(
                                    "assets/icons/call.png",
                                    width: 22,
                                    height: 22,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    navigateTo(
                                        context,
                                        UserChatDetailsScreen(
                                            uId: GetUserOrdersCubit.get(context)
                                                .emailToUidMap[widget.userOrders.delegate!.email],
                                            chatUserName:
                                                "${widget.userOrders.delegate!.firstName} ${widget.userOrders.delegate!.lastName}"));
                                  },
                                  icon: Image.asset(
                                    "assets/icons/chat.png",
                                    width: 22,
                                    height: 22,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (sheetHeight == size.height - 40 && isSheetExpanded)
                          const SizedBox(
                            height: 8,
                          ),
                        if (sheetHeight == size.height - 40 && isSheetExpanded)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: myDivider(),
                          ),
                        mySizedBox(size: size, myHeight: 20),
                        if (!isSheetExpanded)
                          Expanded(
                            child: Stepper(
                              physics: const BouncingScrollPhysics(),
                              key: Key(Random.secure().nextDouble().toString()),
                              currentStep: currentStepIndex,
                              onStepCancel: () {
                                if (currentStepIndex > 0) {
                                  setState(() {
                                    currentStepIndex -= 1;
                                  });
                                }
                              },
                              onStepContinue: () {
                                if (currentStepIndex <= 0) {
                                  setState(() {
                                    currentStepIndex += 1;
                                  });
                                }
                              },
                              controlsBuilder: (context, s) {
                                return const SizedBox.shrink();
                              },
                              onStepTapped: (int index) {
                                setState(() {
                                  currentStepIndex = index;
                                });
                              },
                              steps: <Step>[
                                Step(
                                  title: Text(
                                    widget.userOrders.senderAddress!,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  isActive: true,
                                  content: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Location of your order shipped from',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${widget.userOrders.createdAt!.substring(0, 9)} at ${widget.userOrders.createdAt!.substring(11, 16)}",
                                    //'December 22, 2023 | 09:44 AM',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor4),
                                  ),
                                  state: StepState.indexed,
                                ),
                                Step(
                                    title: Text(
                                      widget.userOrders.receivedAddress!,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    content: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'The destination location',
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ),
                                    isActive: true,
                                    subtitle: Text(
                                      widget.userOrders.deliverTime!,
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor4),
                                    ),
                                    state: StepState.indexed),
                              ],
                            ),
                          ),
                        if (sheetHeight == size.height - 40 && isSheetExpanded)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: myFavColorWithOpacity,
                                    radius: 22,
                                    child: const FaIcon(
                                      FontAwesomeIcons.file,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.userOrders.trackId!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: myFavColor2, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Track id",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: myFavColor4, fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: myFavColorWithOpacity,
                                    radius: 22,
                                    child: const FaIcon(
                                      FontAwesomeIcons.solidClock,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.userOrders.deliverTime!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: myFavColor2, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Estimate Time",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: myFavColor4, fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: myFavColorWithOpacity,
                                    radius: 22,
                                    child: const FaIcon(
                                      FontAwesomeIcons.circleInfo,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${widget.userOrders.weight!} Kg",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: myFavColor2, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Package weight",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: myFavColor4, fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        if (sheetHeight == size.height - 40 && isSheetExpanded)
                          const SizedBox(
                            height: 10,
                          ),
                        if (sheetHeight == size.height - 40 && isSheetExpanded)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: myDivider(),
                          ),
                        if (sheetHeight == size.height - 40 && isSheetExpanded)
                          Expanded(
                            child: Stepper(
                              physics: const BouncingScrollPhysics(),
                              key: Key(Random.secure().nextDouble().toString()),
                              currentStep: currentStepIndex2,
                              onStepCancel: () {
                                if (currentStepIndex2 > 0) {
                                  setState(() {
                                    currentStepIndex -= 1;
                                  });
                                }
                              },
                              onStepContinue: () {
                                if (currentStepIndex2 <= 0) {
                                  setState(() {
                                    currentStepIndex2 += 1;
                                  });
                                }
                              },
                              controlsBuilder: (context, s) {
                                return const SizedBox.shrink();
                              },
                              onStepTapped: (int index) {
                                setState(() {
                                  currentStepIndex2 = index;
                                });
                              },
                              steps: <Step>[
                                Step(
                                  title: Text(
                                    'Your order is shipped',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  isActive: true,
                                  content: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Add you wand additional info',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${widget.userOrders.createdAt!.substring(0,9)} | ${widget.userOrders.createdAt!.substring(11,16)}',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor4),
                                  ),
                                  state: StepState.complete,
                                ),
                                Step(
                                    title: Text(
                                      widget.userOrders.senderAddress!,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    content: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Add you wand additional info',
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ),
                                    isActive: true,
                                    subtitle: Text(
                                      'December 22, 2023 | 10:30 AM',
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor4),
                                    ),
                                    state: StepState.complete),
                                Step(
                                  title: Text(
                                    widget.userOrders.receivedAddress!,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  isActive: false,
                                  content: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Waiting',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'December 22, 2023 | 09:44 AM',
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor4),
                                  ),
                                  state: StepState.disabled,
                                ),
                                Step(
                                    title: Text(
                                      'Delivered',
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    content: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Waiting',
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ),
                                    isActive: false,
                                    subtitle: Text(
                                      'December 22, 2023 | 10:30 AM',
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor4),
                                    ),
                                    state: StepState.disabled),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 20),
                child: GestureDetector(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
