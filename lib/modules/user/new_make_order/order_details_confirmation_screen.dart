import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/user/new_make_order/cubit/cubit.dart';
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
  ReviewSummaryAndConfirmScreen({Key? key, required this.senderName, required this.senderPhone, required this.senderEmail, required this.senderPostalCode, required this.senderAddress, required this.receiverName, required this.receiverPhone, required this.receiverEmail, required this.receiverPostalCode, required this.receiverAddress}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<NewMakeOrderCubit>(context);
    Size size = MediaQuery.of(context).size;
    return buildConfirmOrderBody(context: context, size: size, cubit: cubit);
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
        buildCardForSummaryDetails(child: Padding(
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
                    "Mohamed Ali",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
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
                    "Mohamed Ali",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
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
                    "Mohamed Ali",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
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
                    "Mohamed Ali",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
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
                    "Mohamed Ali",
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
        const SizedBox(height: 22,),
        buildCardForSummaryDetails(child: Padding(
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
                    "Mohamed Ali",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
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
                    "Mohamed Ali",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
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
                    "Mohamed Ali",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
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
                    "Mohamed Ali",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
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
                    "Mohamed Ali",
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
        const SizedBox(height: 22,),
        buildCardForSummaryDetails(child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
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
                    "25 EGP",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: myFavColor2, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
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
        const SizedBox(height: 30,),
      ],
    );
  }

  Widget buildCardForSummaryDetails({
    required Widget child,
}) => Container(
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
