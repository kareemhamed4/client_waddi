import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/modules/user/new_make_order/cubit/cubit.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

//ignore: must_be_immutable
class PackageDetailsScreen extends StatelessWidget {
  PackageDetailsScreen({Key? key}) : super(key: key);
  final TextEditingController packageWeightController = TextEditingController();
  final TextEditingController packageNotesController = TextEditingController();
  final TextEditingController packageLengthController = TextEditingController();
  final TextEditingController packageWidthController = TextEditingController();
  final TextEditingController packageHeightController = TextEditingController();
  var formKey = GlobalKey<FormState>();

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
      Column(
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
            controller: packageWeightController,
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
                  controller: packageLengthController,
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
                  controller: packageWidthController,
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
                  controller: packageHeightController,
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
            minLines: 3,
            controller: packageNotesController,
          ),
          mySizedBox(
            size: size,
            myHeight: 20,
          ),
        ],
      );
}
