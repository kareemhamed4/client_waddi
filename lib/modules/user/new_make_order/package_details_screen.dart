import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/modules/user/check_rate/cubit/cubit.dart';
import 'package:waddy_app/modules/user/new_make_order/cubit/cubit.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

//ignore: must_be_immutable
class PackageDetailsScreen extends StatelessWidget {
  const PackageDetailsScreen({Key? key, required this.senderAddress, required this.receiverAddress}) : super(key: key);
  final String senderAddress;
  final String receiverAddress;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<NewMakeOrderCubit>(context);
    Size size = MediaQuery.of(context).size;
    return buildPackageDetailsContent(
        context: context, size: size, cubit: cubit);
  }

  Widget buildPackageDetailsContent({
    required BuildContext context,
    required NewMakeOrderCubit cubit,
    required Size size,
  }) =>
      Form(
        key: cubit.packageFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Package Category",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: myFavColor8, fontSize: 16),
            ),
            mySizedBox(
              size: size,
              myHeight: 6,
            ),
            myDropDownButton(
                context: context,
                prefix: FaIcon(
                  FontAwesomeIcons.boxOpen,
                  color: myFavColor4,
                  size: 20,
                ),
                validateText: "please choose",
                dropMenuItems: cubit.packageCategory,
                selectedValue: cubit.selectedPackageCategory ?? "",
                hintText: cubit.selectedPackageCategory ?? "Medium Packages",
                onChange: (value) {
                  cubit.selectedPackageCategory = value.toString();
                }),
            mySizedBox(size: size, myHeight: 20),
            Text(
              "Weight",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: myFavColor8, fontSize: 16),
            ),
            mySizedBox(
              size: size,
              myHeight: 6,
            ),
            myTextFormField(
              context: context,
              controller: cubit.packageWeightController,
              validate: (value) {
                if (value!.isEmpty) {
                  return "required";
                }
                return null;
              },
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
            mySizedBox(
              size: size,
              myHeight: 12,
            ),
            Text(
              "Dimension",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: myFavColor8, fontSize: 16),
            ),
            mySizedBox(
              size: size,
              myHeight: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Length",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor8, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    "Width",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor8, fontSize: 14),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    "Height",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor8, fontSize: 14),
                  ),
                ),
              ],
            ),
            mySizedBox(
              size: size,
              myHeight: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: myTextFormField(
                    context: context,
                    controller: cubit.packageLengthController,
                    radius: 10,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "cm",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16, color: myFavColor4),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: myTextFormField(
                    context: context,
                    controller: cubit.packageWidthController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                    radius: 10,
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "cm",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16, color: myFavColor4),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: myTextFormField(
                    context: context,
                    controller: cubit.packageHeightController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                    radius: 10,
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "cm",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16, color: myFavColor4),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            mySizedBox(
              size: size,
              myHeight: 12,
            ),
            Text(
              "Select Service",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: myFavColor8, fontSize: 16),
            ),
            mySizedBox(
              size: size,
              myHeight: 6,
            ),
            myDropDownButton(
                context: context,
                prefix: FaIcon(
                  FontAwesomeIcons.truckMoving,
                  color: myFavColor4,
                  size: 20,
                ),
                dropMenuItems: cubit.serviceCategory,
                validateText: "please choose",
                selectedValue: cubit.selectedService ?? "",
                hintText: cubit.selectedService ?? "Shipping",
                onChange: (value) {
                  cubit.selectedService = value.toString();
                }),
            mySizedBox(
              size: size,
              myHeight: 12,
            ),
            Text(
              "Notes",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: myFavColor8, fontSize: 16),
            ),
            mySizedBox(
              size: size,
              myHeight: 6,
            ),
            myTextFormField(
              context: context,
              validate: (value) {
                if (value!.isEmpty) {
                  return "required";
                }
                return null;
              },
              minLines: 3,
              controller: cubit.packageNotesController,
            ),
            mySizedBox(
              size: size,
              myHeight: 20,
            ),
            myMaterialButton(
              context: context,
              height: 50,
              labelWidget: Text(
                "Continue",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {
                if(cubit.packageFormKey.currentState!.validate()){
                  cubit.packageFormKey.currentState!.save();
                  context.read<CheckRateCubit>().checkRate(
                      pickupLocation: senderAddress,
                      destinationLocation: receiverAddress,
                      weight: int.parse(cubit.packageWeightController.text),
                      noOfPackages: 1,
                  );
                  cubit.plusStepper();
                }
              },
            ),
          ],
        ),
      );
}
