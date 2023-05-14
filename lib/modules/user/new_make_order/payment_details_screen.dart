import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/modules/user/new_make_order/cubit/cubit.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

//ignore: must_be_immutable
class PaymentDetailsScreen extends StatelessWidget {
  PaymentDetailsScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<NewMakeOrderCubit>(context);
    Size size = MediaQuery.of(context).size;
    return buildPaymentDetailsContent(
        context: context, size: size, cubit: cubit);
  }

  Widget buildPaymentDetailsContent({
    required Size size,
    required BuildContext context,
    required NewMakeOrderCubit cubit,
  }) =>
      Form(
        key: cubit.paymentFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image.asset("assets/icons/card.png"),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 70),
                      child: Text(
                        cubit.cardNumberController.text,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: myFavColor7, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 45),
                      child: Text(
                        cubit.cardNameController.text,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: myFavColor7, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, bottom: 10),
                      child: Text(
                        cubit.cardExpiryDateController.text,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: myFavColor7, fontSize: 16),
                      ),
                    ),
                  ],
                )),
            mySizedBox(
              size: size,
              myHeight: 16,
            ),
            Text(
              "Card Number",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: myFavColor8, fontSize: 16),
            ),
            mySizedBox(
              size: size,
              myHeight: 6,
            ),
            customTextFormFieldForCardNumber(
              context: context,
              controller: cubit.cardNumberController,
              onChange: (value) {
                cubit.changeCardNumber(cardNumber: value);
              },
              hint: "Card Number",
              validate: (value) {
                if (value!.isEmpty) {
                  return "required";
                }
                return null;
              },
              charSpaceCount: 4,
              maxLength2: 19,
              type: TextInputType.phone,
              radius: 10,
              textColor: myFavColor2,
              prefixIcon: const Icon(
                FontAwesomeIcons.creditCard,
                size: 20,
              ),
            ),
            mySizedBox(
              size: size,
              myHeight: 12,
            ),
            Text(
              "Name on card",
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
              controller: cubit.cardNameController,
              onChange: (value) {
                cubit.changeCardName(cardName: value);
              },
              hint: "Card Name",
              validate: (value) {
                if (value!.isEmpty) {
                  return "required";
                }
                return null;
              },
              type: TextInputType.text,
              radius: 10,
              textColor: myFavColor2,
              prefixIcon: const Icon(
                FluentIcons.credit_card_person_20_regular,
                size: 30,
              ),
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
                    "Expiry date",
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
                    "Security code",
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
                    controller: cubit.cardExpiryDateController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                    type: TextInputType.number,
                    onChange: (value) {
                      cubit.changeCardDate(cardExpiryDate: value);
                    },
                    radius: 10,
                    hint: "06/02",
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: myTextFormField(
                    context: context,
                    controller: cubit.cardCVVController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "required";
                      }
                      return null;
                    },
                    type: TextInputType.phone,
                    isPassword: true,
                    radius: 10,
                    hint: "***",
                  ),
                ),
              ],
            ),
            mySizedBox(
              size: size,
              myHeight: 40,
            ),
            myMaterialButton(
              context: context,
              height: 50,
              labelWidget: Text(
                "Pay",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {
                if(cubit.paymentFormKey.currentState!.validate()){
                  cubit.paymentFormKey.currentState!.save();
                  cubit.plusStepper();
                }
              },
            ),
          ],
        ),
      );
}
