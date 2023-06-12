import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/models/driver/delegate_get_his_orders_model.dart';
import 'package:waddy_app/modules/driver/orders/cubit/cubit.dart';
import 'package:waddy_app/network/local/cache_helper.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/constants/constants.dart';
import 'package:waddy_app/shared/components/my_google_map.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class DriverCreateRouteScreen extends StatefulWidget {
  const DriverCreateRouteScreen({Key? key}) : super(key: key);

  @override
  State<DriverCreateRouteScreen> createState() => _DriverCreateRouteScreenState();
}

class _DriverCreateRouteScreenState extends State<DriverCreateRouteScreen> {
  int currentStepRouteIndex = 0;
  double sheetHeight = 360.0;
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
            currentLocation == null
                ? const Text("Loading")
                : const MyGoogleMap(
                    isGoToMyLocationEnabled: false,
                    isTracking: false,
                    zoom: 11,
                    isPlaces: false,
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
                    if (sheetHeight < 360) {
                      sheetHeight = 360;
                      isSheetExpanded = false;
                    } else if (sheetHeight > 480) {
                      sheetHeight = 480;
                      isSheetExpanded = true;
                    }
                  });
                },
                onVerticalDragEnd: (_) {
                  setState(() {
                    if (sheetHeight > 390) {
                      sheetHeight = 480;
                      isSheetExpanded = true;
                    } else {
                      sheetHeight = 360;
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
                    child: isSheetExpanded
                        ? Column(
                            children: [
                              buildBottomSheetWithExpanded(size: size, currentStepIndex: currentStepRouteIndex),
                              Expanded(
                                child: Stepper(
                                  key: Key(Random.secure().nextDouble().toString()),
                                  currentStep: currentStepRouteIndex,
                                  onStepCancel: () {
                                    if (currentStepRouteIndex > 0) {
                                      setState(() {
                                        currentStepRouteIndex -= 1;
                                      });
                                    }
                                  },
                                  onStepContinue: () {
                                    if (currentStepRouteIndex <= 0) {
                                      setState(() {
                                        currentStepRouteIndex += 1;
                                      });
                                    }
                                  },
                                  controlsBuilder: (context, s) {
                                    return const SizedBox.shrink();
                                  },
                                  onStepTapped: (int index) {
                                    setState(() {
                                      currentStepRouteIndex = index;
                                    });
                                  },
                                  steps: <Step>[
                                    Step(
                                      title: Text(
                                        'عزبة أبو باشا',
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
                                      ),
                                      isActive: true,
                                      content: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          children: [
                                            Text(
                                              '3:00 PM - 3:15 PM',
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: myMaterialButton(
                                                    context: context,
                                                    onPressed: () {},
                                                    height: 40,
                                                    radius: 9,
                                                    labelWidget: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "Start",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .labelLarge!
                                                              .copyWith(fontSize: 12),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        FaIcon(
                                                          FontAwesomeIcons.paperPlane,
                                                          size: 16,
                                                          color: myFavColor7,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                    flex: 4,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: myCustomMaterialButtonLeft(
                                                            context: context,
                                                            onPressed: () {},
                                                            height: 40,
                                                            radius: 5,
                                                            labelWidget: Text(
                                                              "DELIVERED",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge!
                                                                  .copyWith(fontSize: 12),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: myCustomMaterialButtonRight(
                                                            context: context,
                                                            bgColor: myFavColorWithOpacity,
                                                            onPressed: () {},
                                                            height: 40,
                                                            radius: 5,
                                                            labelWidget: Text(
                                                              "FAILED",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge!
                                                                  .copyWith(fontSize: 12, color: myFavColor),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: myMaterialButton(
                                                      context: context,
                                                      onPressed: () {},
                                                      height: 40,
                                                      radius: 9,
                                                      labelWidget: FaIcon(
                                                        FontAwesomeIcons.pen,
                                                        size: 16,
                                                        color: myFavColor7,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'عزبة أبو باشا، كفر بطا، بنها، القليوبية، مصر',
                                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor4),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: currentStepRouteIndex == 0 ? myFavColor2 : myFavColor4,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                      state: StepState.indexed,
                                    ),
                                    Step(
                                      title: Text(
                                        'كفر الجزار',
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
                                      ),
                                      isActive: true,
                                      content: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          children: [
                                            Text(
                                              '3:15 PM - 3:30 PM',
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: myMaterialButton(
                                                    context: context,
                                                    onPressed: () {},
                                                    height: 40,
                                                    radius: 9,
                                                    labelWidget: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "Start",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .labelLarge!
                                                              .copyWith(fontSize: 12),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        FaIcon(
                                                          FontAwesomeIcons.paperPlane,
                                                          size: 16,
                                                          color: myFavColor7,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                    flex: 4,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: myCustomMaterialButtonLeft(
                                                            context: context,
                                                            onPressed: () {},
                                                            height: 40,
                                                            radius: 5,
                                                            labelWidget: Text(
                                                              "DELIVERED",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge!
                                                                  .copyWith(fontSize: 12),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: myCustomMaterialButtonRight(
                                                            context: context,
                                                            bgColor: myFavColorWithOpacity,
                                                            onPressed: () {},
                                                            height: 40,
                                                            radius: 5,
                                                            labelWidget: Text(
                                                              "FAILED",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge!
                                                                  .copyWith(fontSize: 12, color: myFavColor),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: myMaterialButton(
                                                      context: context,
                                                      onPressed: () {},
                                                      height: 40,
                                                      radius: 9,
                                                      labelWidget: FaIcon(
                                                        FontAwesomeIcons.pen,
                                                        size: 16,
                                                        color: myFavColor7,
                                                      )),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'كفر الجزار، بنها، القليوبية، مصر',
                                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor4),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: currentStepRouteIndex == 1 ? myFavColor2 : myFavColor4,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                      state: StepState.indexed,
                                    ),
                                    Step(
                                      title: Text(
                                        "جامعة بنها",
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
                                      ),
                                      isActive: true,
                                      content: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          children: [
                                            Text(
                                              '3:00 PM - 3:15 PM',
                                              style: Theme.of(context).textTheme.bodySmall,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: myMaterialButton(
                                                    context: context,
                                                    onPressed: () {},
                                                    height: 40,
                                                    radius: 9,
                                                    labelWidget: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          "Start",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .labelLarge!
                                                              .copyWith(fontSize: 12),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        FaIcon(
                                                          FontAwesomeIcons.paperPlane,
                                                          size: 16,
                                                          color: myFavColor7,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                    flex: 4,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: myCustomMaterialButtonLeft(
                                                            context: context,
                                                            onPressed: () {},
                                                            height: 40,
                                                            radius: 5,
                                                            labelWidget: Text(
                                                              "DELIVERED",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge!
                                                                  .copyWith(fontSize: 12),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: myCustomMaterialButtonRight(
                                                            context: context,
                                                            bgColor: myFavColorWithOpacity,
                                                            onPressed: () {},
                                                            height: 40,
                                                            radius: 5,
                                                            labelWidget: Text(
                                                              "FAILED",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge!
                                                                  .copyWith(fontSize: 12, color: myFavColor),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: myMaterialButton(
                                                      context: context,
                                                      onPressed: () {},
                                                      height: 40,
                                                      radius: 9,
                                                      labelWidget: FaIcon(
                                                        FontAwesomeIcons.pen,
                                                        size: 16,
                                                        color: myFavColor7,
                                                      )),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'شارع الشهيد فريد ندي، بنها، القليوبية، مصر',
                                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor4),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: currentStepRouteIndex == 2 ? myFavColor2 : myFavColor4,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                      state: StepState.indexed,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : buildBottomSheetWithoutExpanded(
                            size: size, ordersByCity: DriverOrdersCubit.get(context).ordersByCity),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: myFavColor7,
                      boxShadow: [
                        BoxShadow(
                          color: myFavColor8.withAlpha(20),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    width: size.width * 192 / size.width,
                    height: 36,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.pen,
                          color: myFavColor,
                          size: 16,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Route 1 - Feb 11 2023",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14, color: myFavColor2),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSheetExpanded = !isSheetExpanded;
                        sheetHeight = !isSheetExpanded ? 360 : 480;
                      });
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
                          Icons.settings,
                          color: myFavColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomSheetWithExpanded({
    required Size size,
    required int currentStepIndex,
  }) =>
      Column(
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
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
          mySizedBox(size: size, myHeight: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: size.width,
              ),
              Text(
                "Stop.",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: myFavColor2),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Start 03:00 pm, End 03:30 pm",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14, color: myFavColor2),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  FaIcon(
                    FontAwesomeIcons.clock,
                    color: myFavColor4.withOpacity(0.5),
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Start from Istanha, Albagour  \n, Almonfeia ",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14, color: myFavColor2, height: 1),
              ),
              const SizedBox(
                width: 6,
              ),
              FaIcon(
                FontAwesomeIcons.house,
                color: myFavColor4.withOpacity(0.5),
                size: 16,
              ),
            ],
          ),
          const SizedBox(
            height: 27,
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: myFavColor4.withOpacity(0.3),
          ),
        ],
      );

  Widget buildBottomSheetWithoutExpanded({
    required Size size,
    required Map<String, List<Orders>> ordersByCity,
  }) =>
      Column(
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
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
          mySizedBox(size: size, myHeight: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: size.width,
              ),
              Text(
                "Stop.",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: myFavColor2),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Start 03:00 pm, End 03:30 pm",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14, color: myFavColor2),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  FaIcon(
                    FontAwesomeIcons.clock,
                    color: myFavColor4.withOpacity(0.5),
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ordersByCity.keys.toList()[index],
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(color: myFavColor2),
                      ),
                      Container(
                        width: 40,
                        height: 18,
                        decoration: BoxDecoration(
                          color: myFavColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Home",
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: myFavColor7, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.ellipsisVertical,
                        size: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 44),
                        child: Text(
                          "قسم بنها، بنها، مصر",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14, color: myFavColor4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              separatorBuilder: (context, index) => Divider(
                height: 0,
                thickness: 1,
                color: myFavColor4.withOpacity(0.3),
              ),
              itemCount: ordersByCity.length,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: myMaterialButton(
                      context: context,
                      onPressed: () {},
                      height: 47,
                      radius: 9,
                      labelWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Start Route",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 20),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          FaIcon(
                            FontAwesomeIcons.paperPlane,
                            size: 16,
                            color: myFavColor7,
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: myMaterialButton(
                      context: context,
                      onPressed: () {},
                      height: 47,
                      radius: 9,
                      labelWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Optimize",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 20),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          FaIcon(
                            FontAwesomeIcons.route,
                            size: 16,
                            color: myFavColor7,
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
}
