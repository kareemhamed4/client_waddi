import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/layout/user/cubit/cubit.dart';
import 'package:waddy_app/layout/user/layout_screen.dart';
import 'package:waddy_app/modules/user/check_rate/cubit/cubit.dart';
import 'package:waddy_app/modules/user/new_make_order/cubit/cubit.dart';
import 'package:waddy_app/modules/user/new_make_order/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

//ignore: must_be_immutable
class ReviewSummaryAndConfirmScreen extends StatelessWidget {
  final String senderName;
  final String senderPhone;
  final String senderEmail;
  final String senderPostalCode;
  final String senderAddress;

  final String receiverName;
  final String receiverPhone;
  final String receiverEmail;
  final String receiverPostalCode;
  final String receiverAddress;
  final String selectedService;
  ReviewSummaryAndConfirmScreen(
      {Key? key,
      required this.senderName,
      required this.senderPhone,
      required this.senderEmail,
      required this.senderPostalCode,
      required this.senderAddress,
      required this.receiverName,
      required this.receiverPhone,
      required this.receiverEmail,
      required this.receiverPostalCode,
      required this.receiverAddress,
      required this.selectedService})
      : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<NewMakeOrderCubit>(context);
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<NewMakeOrderCubit,NewMakeOrderStates>(
      listener: (context,state){
        if(state is MakeOrderSuccessState){
          navigateToAndFinish(context, const UserLayoutScreen()).then((value){
            context.read<UserLayoutCubit>().changeBottom(1, context);
          });
        }
      },
      builder: (context,state) {
        return buildConfirmOrderBody(
            context: context, size: size, cubit: cubit);
      });
  }

  Widget buildConfirmOrderBody({
    required Size size,
    required BuildContext context,
    required NewMakeOrderCubit cubit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Review Summary",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: myFavColor8, fontSize: 22),
        ),
        mySizedBox(
          size: size,
          myHeight: 12,
        ),
        buildCardForSummaryDetails(
            child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sender name",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 16),
                  ),
                  Text(
                    senderName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phone number",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 16),
                  ),
                  Text(
                    senderPhone,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 16),
                  ),
                  Text(
                    senderEmail,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Postel code",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 16),
                  ),
                  Text(
                    senderPostalCode,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Address",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 16),
                  ),
                  Text(
                    senderAddress,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        )),
        const SizedBox(
          height: 22,
        ),
        buildCardForSummaryDetails(
            child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Receiver name",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 16),
                  ),
                  Text(
                    receiverName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phone number",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 16),
                  ),
                  Text(
                    receiverPhone,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 16),
                  ),
                  Text(
                    receiverEmail,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Postel code",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 16),
                  ),
                  Text(
                    receiverPostalCode,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Address",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 16),
                  ),
                  Text(
                    receiverAddress,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        )),
        const SizedBox(
          height: 22,
        ),
        buildCardForSummaryDetails(
            child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shipping Service",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 16),
                  ),
                  Text(
                    selectedService,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shipping price",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 16),
                  ),
                  Text(
                    cubit.selectedService == "Regular"
                        ? context
                            .read<CheckRateCubit>()
                            .checkRateModel!
                            .regular!
                            .cost
                            .toString()
                        : context
                            .read<CheckRateCubit>()
                            .checkRateModel!
                            .express!
                            .cost
                            .toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment methods",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor4, fontSize: 16),
                  ),
                  Text(
                    "Credit Card",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        )),
        const SizedBox(
          height: 30,
        ),
        myMaterialButton(
          context: context,
          height: 50,
          labelWidget: Text(
            "Confirm Order",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          onPressed: () {
            cubit.makeNewOrder(
              senderName: senderName,
              senderPhone: "0${senderPhone.replaceAll(' ', '')}",
              senderEmail: senderEmail,
              senderPostalCode: senderPostalCode,
              senderAddress: senderAddress,
              receivedName: receiverName,
              receivedPhone: "0${receiverPhone.replaceAll(' ', '')}",
              receivedEmail: receiverEmail,
              receivedPostalCode: receiverPostalCode,
              receivedAddress: receiverAddress,
              category: cubit.selectedPackageCategory.toString(),
              weight: int.parse(cubit.packageWeightController.text),
              dimension: [
                "Length: ${cubit.packageLengthController.text}",
                "Width: ${cubit.packageWidthController.text}",
                "Height: ${cubit.packageHeightController.text}"
              ],
              services: cubit.selectedService == "Regular" ? 1 : 2,
              notes: cubit.packageNotesController.text,
              paymentId: cubit.cardNumberController.text.replaceAll(' ', ''),
              deliverTime: cubit.selectedService == "Regular"
                  ? context
                      .read<CheckRateCubit>()
                      .checkRateModel!
                      .regular!
                      .date
                      .toString()
                  : context
                      .read<CheckRateCubit>()
                      .checkRateModel!
                      .express!
                      .date
                      .toString(),
            );
          },
        ),
      ],
    );
  }

  Widget buildCardForSummaryDetails({
    required Widget child,
  }) =>
      Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: myFavColor7,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: myFavColor8.withAlpha(20),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 0)),
          ],
        ),
        child: child,
      );


}
