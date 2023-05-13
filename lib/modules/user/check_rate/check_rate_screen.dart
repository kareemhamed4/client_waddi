import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/custom_icons_icons.dart';
import 'package:waddy_app/modules/user/check_rate/cubit/cubit.dart';
import 'package:waddy_app/modules/user/check_rate/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class CheckRateScreen extends StatelessWidget {
  const CheckRateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController pickupController = TextEditingController();
    TextEditingController destinationController = TextEditingController();
    TextEditingController dimensionController = TextEditingController();
    TextEditingController shipDateController = TextEditingController();

    return BlocConsumer<CheckRateCubit,CheckRateStates>(
      listener: (context,state){},
      builder: (context,state){
        CheckRateCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: defaultAppBar(context: context, title: "Check Rate"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.circleDot,
                            color: myFavColor,
                          ),
                          Container(
                            width: 1,
                            height: 50,
                            color: myFavColor4,
                          ),
                          FaIcon(
                            FontAwesomeIcons.locationPin,
                            color: myFavColor,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            myTextFormField(
                                context: context,
                                controller: pickupController,
                                radius: 10,
                                hint: "Pick up Location",
                                suffixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.locationCrosshairs,
                                      color: myFavColor,
                                    ),
                                  ],
                                )),
                            mySizedBox(size: size, myHeight: 24),
                            myTextFormField(
                                context: context,
                                controller: destinationController,
                                radius: 10,
                                hint: "Package Destination",
                                suffixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.locationCrosshairs,
                                      color: myFavColor,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  mySizedBox(size: size, myHeight: 30),
                  myDivider(),
                  Text(
                    "Tell us more about your shipment",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 20,
                      color: myFavColor8,
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 20),
                  Text(
                    "Dimension",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      color: myFavColor8,
                    ),
                  ),
                  myTextFormField(
                    context: context,
                    controller: dimensionController,
                    radius: 10,
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: FaIcon(FontAwesomeIcons.boxOpen,color: myFavColor4,size: 20,),
                        ),
                      ],
                    ),
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Kg",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16, color: myFavColor4),
                        ),
                      ],
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 20),
                  Text(
                    "NO . of packages",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      color: myFavColor8,
                    ),
                  ),
                  myDropDownButton(
                      context: context,
                      prefix: FaIcon(FontAwesomeIcons.boxOpen,color: myFavColor4,size: 20,),
                      dropMenuItems: cubit.noOfPackages,
                      selectedValue: cubit.selectedNoOfPackages ?? "",
                      hintText: cubit.selectedNoOfPackages ?? "1",
                      onChange: (value) {
                        cubit.selectedNoOfPackages = value.toString();
                      }),
                  mySizedBox(size: size, myHeight: 20),
                  Text(
                    "Ship Date",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 18,
                      color: myFavColor8,
                    ),
                  ),
                  myTextFormField(
                      context: context,
                      controller: shipDateController,
                      hint: "Thursday, January 26, 2023",
                      radius: 10,
                      prefixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Icon(CustomIcons.calendar,color: myFavColor4,size: 20,),
                          ),
                        ],
                      ),
                      suffixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: myFavColor2,
                          ),
                        ],
                      ),
                  ),
                  mySizedBox(size: size, myHeight: 44),
                  myMaterialButton(
                    context: context,
                    onPressed: () {
                      showMyBottomSheet(
                        size: size,
                        context: context,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
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
                                mySizedBox(size: size, myHeight: 20),
                                Text(
                                  "Rates",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(fontSize: 28),
                                ),
                                mySizedBox(size: size, myHeight: 12),
                                myDivider(),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Benha train station street",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(fontSize: 16, height: 1),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Pick up location",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                fontSize: 14,
                                                color: myFavColor4),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.arrowRightArrowLeft,
                                              color: myFavColor,
                                            ),
                                          ],
                                        )),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Shebeen El-Koum, Menoufia",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(fontSize: 16, height: 1),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Package Destination",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                fontSize: 14,
                                                color: myFavColor4),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                myDivider(),
                                mySizedBox(size: size, myHeight: 20),
                                Container(
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
                                    elevation: 2,
                                    color: myFavColor7,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Image.asset(
                                                      "assets/images/yellowShape.png"),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 9),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.boxOpen,
                                                      color: myFavColor7,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 24,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Regular",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(fontSize: 20),
                                                  ),
                                                  Text(
                                                    "3 - 4 days",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                        color: myFavColor4),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "25 EGP",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: myFavColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                mySizedBox(size: size, myHeight: 26),
                                Container(
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
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Image.asset(
                                                      "assets/images/roseShape.png"),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 6),
                                                    child: FaIcon(
                                                      FontAwesomeIcons.cartShopping,
                                                      color: myFavColor7,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 24,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Express",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(fontSize: 20),
                                                  ),
                                                  Text(
                                                    "1 - 2 days",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                        color: myFavColor4),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "48 EGP",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: myFavColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                mySizedBox(size: size, myHeight: 35),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    height: 50,
                    labelWidget: Text(
                      "Check",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
