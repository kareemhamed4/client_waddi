import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/modules/user/new_make_order/cubit/cubit.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class ChoosePaymentScreen extends StatelessWidget {
  const ChoosePaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<NewMakeOrderCubit>(context);
    Size size = MediaQuery.of(context).size;
    return buildChoosePaymentContent(
      context: context,
      size: size,
      cubit: cubit,
      paymentTitlesList: [
        "Credit card",
        "Pay Pal",
        "O Pay",
        "Paymob",
      ],
      paymentImagesList: [
        "assets/icons/mastercard.png",
        "assets/icons/paypal.png",
        "assets/icons/opay.png",
        "assets/icons/paymob.png",
      ],
    );
  }

  Widget buildChoosePaymentContent({
    required Size size,
    required BuildContext context,
    required NewMakeOrderCubit cubit,
    required List<String> paymentImagesList,
    required List<String> paymentTitlesList,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select the payment method you want to use",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 18,
                  color: myFavColor8,
                ),
          ),
          mySizedBox(size: size,myHeight: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: paymentImagesList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 70,
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
                  child: Center(
                    child: ListTile(
                      onTap: () {},
                      leading: Image.asset(paymentImagesList[index],width: 60,height: 60,),
                      title: Text(
                        paymentTitlesList[index],
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: myFavColor8, fontSize: 18),
                      ),
                      trailing: index == 1 ? FaIcon(
                        FontAwesomeIcons.circleDot,
                        color: myFavColor,
                        size: 20,
                      ) : FaIcon(
                        FontAwesomeIcons.circle,
                        color: myFavColor,
                        size: 20,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 24,
              ),
            ),
          ),
          mySizedBox(size: size,myHeight: 60),
          myMaterialButton(
            context: context,
            height: 50,
            labelWidget: Text(
              "Continue",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: () {
              cubit.plusStepper();
            },
          ),
        ],
      );
}
