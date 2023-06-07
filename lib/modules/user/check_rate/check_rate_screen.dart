import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:waddy_app/custom_icons_icons.dart';
import 'package:waddy_app/modules/user/check_rate/cubit/cubit.dart';
import 'package:waddy_app/modules/user/check_rate/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class CheckRateScreen extends StatelessWidget {
  CheckRateScreen({Key? key}) : super(key: key);
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController dimensionController = TextEditingController();
  final TextEditingController shipDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CheckRateCubit, CheckRateStates>(
      listener: (context, state) {
        if (state is CheckRateSuccessStateState) {
          final cubit = BlocProvider.of<CheckRateCubit>(context);
          buildCheckRateBottomSheet(context: context, size: size, cubit: cubit);
        }
        if (state is CheckRateErrorStateState) {
          buildErrorToast(
            context: context,
            title: "Oops",
            description: state.error,
          );
        }
      },
      builder: (context, state) {
        CheckRateCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                SystemChannels.textInput
                    .invokeMethod('TextInput.hide')
                    .then((value) {
                  Timer(const Duration(milliseconds: 250), () {
                    Navigator.pop(context);
                  });
                });
              },
              child: const Icon(
                Icons.arrow_back_outlined,
              ),
            ),
            title: Text(
              "Check Rate",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: myFavColor8, fontSize: 28),
            ),
          ),
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
                  SizedBox(height: 35.h),
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
                          child: FaIcon(
                            FontAwesomeIcons.boxOpen,
                            color: myFavColor4,
                            size: 20,
                          ),
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
                      prefix: FaIcon(
                        FontAwesomeIcons.boxOpen,
                        color: myFavColor4,
                        size: 20,
                      ),
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
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      ).then((value) => value != null
                          ? shipDateController.text =
                              DateFormat.yMMMd().format(value)
                          : shipDateController.text = "");
                    },
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Icon(
                            CustomIcons.calendar,
                            color: myFavColor4,
                            size: 20,
                          ),
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
                  ConditionalBuilder(
                    condition: state is! CheckRateLoadingStateState,
                    builder: (context) => myMaterialButton(
                      context: context,
                      onPressed: () {
                        cubit.checkRate(
                          pickupLocation: pickupController.text,
                          destinationLocation: destinationController.text,
                          weight: int.parse(dimensionController.text.isNotEmpty
                              ? dimensionController.text
                              : "5"),
                          noOfPackages: int.parse(
                            cubit.selectedNoOfPackages != null
                                ? cubit.selectedNoOfPackages.toString()
                                : "1",
                          ),
                        );
                      },
                      height: 50,
                      labelWidget: Text(
                        "Check",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    fallback: (context) => myMaterialButton(
                      height: 50,
                      context: context,
                      onPressed: () {
                        null;
                      },
                      labelWidget: const Center(
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ),
                      ),
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

  Future<dynamic> buildCheckRateBottomSheet({
    required Size size,
    required BuildContext context,
    required CheckRateCubit cubit,
  }) {
    return showMyBottomSheet(
      size: size,
      context: context,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
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
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
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
              SizedBox(height: 27.h),
              myDivider(),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cubit.checkRateModel!.from ?? "",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontSize: 16,
                                    height: 1,
                                  ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Pick up location",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    color: myFavColor4,
                                  ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cubit.checkRateModel!.to ?? "",
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontSize: 16,
                                    height: 1,
                                  ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Package Destination",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 14,
                                    color: myFavColor4,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 27.h),
              myDivider(),
              SizedBox(height: 23.h),
              Container(
                height: 100.h,
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
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/yellowShape.png",
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 9,
                                  ),
                                  child: FaIcon(
                                    FontAwesomeIcons.boxOpen,
                                    color: myFavColor7,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 24.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Regular",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 20,
                                      ),
                                ),
                                Text(
                                  cubit.checkRateModel!.regular!.date ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: myFavColor4,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "${cubit.checkRateModel!.regular!.cost.toString()} EGP",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: myFavColor,
                                  ),
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
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/roseShape.png",
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 6,
                                  ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Express",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 20,
                                      ),
                                ),
                                Text(
                                  cubit.checkRateModel!.express!.date ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: myFavColor4,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          "${cubit.checkRateModel!.express!.cost.toString()} EGP",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: myFavColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35.h),
            ],
          ),
        ),
      ),
    );
  }
}
