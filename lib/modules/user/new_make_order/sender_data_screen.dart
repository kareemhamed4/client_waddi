import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:waddy_app/custom_icons_icons.dart';
import 'package:waddy_app/modules/user/new_make_order/cubit/cubit.dart';
import 'package:waddy_app/modules/user/new_make_order/cubit/states.dart';
import 'package:waddy_app/modules/user/new_make_order/order_details_confirmation_screen.dart';
import 'package:waddy_app/modules/user/new_make_order/package_details_screen.dart';
import 'package:waddy_app/modules/user/new_make_order/payment_details_screen.dart';
import 'package:waddy_app/modules/user/new_make_order/payment_screen.dart';
import 'package:waddy_app/modules/user/new_make_order/receiver_data_screen.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

//ignore: must_be_immutable
class SenderDataScreen extends StatelessWidget {
  SenderDataScreen({Key? key}) : super(key: key);
  final TextEditingController senderNameController = TextEditingController();
  final TextEditingController senderPhoneController = TextEditingController();
  final TextEditingController senderEmailController = TextEditingController();
  final TextEditingController senderPostalCodeController =
      TextEditingController();
  final TextEditingController senderAddressController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<NewMakeOrderCubit, NewMakeOrderStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewMakeOrderCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "Make Order",
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 72,
                          child: Theme(
                            data: ThemeData(
                              canvasColor: myFavColor7,
                              colorScheme:
                                  Theme.of(context).colorScheme.copyWith(
                                        background: myFavColor4,
                                      ),
                            ),
                            child: Stepper(
                              physics: const BouncingScrollPhysics(),
                              elevation: 0,
                              currentStep: cubit.currentStep,
                              type: StepperType.horizontal,
                              controlsBuilder: (context, s) {
                                return const SizedBox.shrink();
                              },
                              onStepTapped: (int index) {
                                cubit.currentStep = index;
                              },
                              steps: <Step>[
                                Step(
                                  title: Text(
                                    cubit.currentStep == 0 ? 'Sender' : "",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  isActive:
                                      cubit.currentStep >= 0 ? true : false,
                                  state: StepState.indexed,
                                  content: Text(
                                    '',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Step(
                                  title: Text(
                                    cubit.currentStep == 1 ? 'Receiver' : "",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  isActive:
                                      cubit.currentStep >= 1 ? true : false,
                                  state: StepState.indexed,
                                  content: Text(
                                    '',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Step(
                                  title: Text(
                                    cubit.currentStep == 2 ? 'Package' : "",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  isActive:
                                      cubit.currentStep >= 2 ? true : false,
                                  state: StepState.indexed,
                                  content: Text(
                                    '',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Step(
                                  title: Text(
                                    cubit.currentStep == 3 ? 'Payment' : "",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  isActive:
                                      cubit.currentStep >= 3 ? true : false,
                                  state: StepState.indexed,
                                  content: Text(
                                    '',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Step(
                                  title: Text(
                                    cubit.currentStep == 4 ? 'Payment' : "",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  isActive:
                                      cubit.currentStep >= 4 ? true : false,
                                  state: StepState.indexed,
                                  content: Text(
                                    '',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Step(
                                  title: Text(
                                    cubit.currentStep == 5 ? 'Finish' : "",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  isActive:
                                      cubit.currentStep >= 5 ? true : false,
                                  state: StepState.indexed,
                                  content: Text(
                                    '',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        myDivider(),
                        mySizedBox(
                          size: size,
                          myHeight: 6,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: cubit.currentStep == 0
                          ? buildSenderDataForm(
                              size: size,
                              context: context,
                              cubit: cubit,
                            )
                          : cubit.currentStep == 1
                              ? ReceiverDataScreen()
                              : cubit.currentStep == 2
                                  ? PackageDetailsScreen()
                                  : cubit.currentStep == 3
                                      ? const ChoosePaymentScreen()
                                      : cubit.currentStep == 4
                                          ? PaymentDetailsScreen()
                                          : ReviewSummaryAndConfirmScreen(
                                              senderName:
                                                  senderNameController.text,
                                              senderPhone:
                                                  senderPhoneController.text,
                                              senderEmail:
                                                  senderEmailController.text,
                                              senderPostalCode:
                                                  senderPostalCodeController
                                                      .text,
                                              senderAddress:
                                                  senderAddressController.text,
                                              receiverName: cubit
                                                  .receiverNameController.text,
                                              receiverPhone: cubit
                                                  .receiverPhoneController.text,
                                              receiverEmail: cubit
                                                  .receiverEmailController.text,
                                              receiverPostalCode: cubit
                                                  .receiverPostalCodeController
                                                  .text,
                                              receiverAddress:
                                                  senderAddressController.text,
                                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          myMaterialButton(
                            context: context,
                            height: 50,
                            labelWidget: Text(
                              cubit.currentStep == 5
                                  ? "Confirm Order"
                                  : cubit.currentStep == 4
                                      ? "Pay"
                                      : "Continue",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            onPressed: () {
                              if (cubit.currentStep < 5) {
                                cubit.plusStepper();
                              }
                            },
                          ),
                          if (cubit.currentStep > 0)
                            Align(
                              alignment: Alignment.center,
                              child: myTextButton(
                                context: context,
                                label: "Back",
                                onPressed: () {
                                  cubit.minusStepper();
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSenderDataForm({
    required Size size,
    required BuildContext context,
    required NewMakeOrderCubit cubit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sender Name",
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
          controller: senderNameController,
          hint: "Sender Name",
          type: TextInputType.text,
          radius: 10,
          textColor: myFavColor2,
          prefixIcon: const Icon(
            Icons.person,
            size: 20,
          ),
        ),
        mySizedBox(
          size: size,
          myHeight: 20,
        ),
        Text(
          "Phone Number",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: myFavColor8, fontSize: 16),
        ),
        mySizedBox(
          size: size,
          myHeight: 6,
        ),
        InternationalPhoneNumberInput(
          selectorTextStyle:
              Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
          initialValue: PhoneNumber(
              isoCode: "EG",
              dialCode: "+20",
              phoneNumber: senderPhoneController.text),
          textStyle:
              Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
          maxLength: 10,
          validator: (value) {
            if (value!.length < 10) {
              return "please enter valid phone number";
            }
            return null;
          },
          hintText: "1X-XXXX-XXXX",
          onInputChanged: (PhoneNumber value) {},
          inputDecoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: "1X-XXXX-XXXX",
            hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 16, color: myFavColor4),
            filled: true,
            fillColor: myFavColor5,
          ),
          selectorConfig: const SelectorConfig(
            setSelectorButtonAsPrefixIcon: true,
            trailingSpace: true,
          ),
          onSaved: (phoneNumber) {},
        ),
        mySizedBox(
          size: size,
          myHeight: 20,
        ),
        Text(
          "Email",
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
          controller: senderEmailController,
          hint: "Email",
          type: TextInputType.text,
          radius: 10,
          textColor: myFavColor2,
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FaIcon(
                FontAwesomeIcons.envelope,
                size: 20,
              ),
            ],
          ),
        ),
        mySizedBox(
          size: size,
          myHeight: 20,
        ),
        Text(
          "Postal Code",
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
          controller: senderPostalCodeController,
          hint: "Postal Code",
          type: TextInputType.text,
          radius: 10,
          textColor: myFavColor2,
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FaIcon(
                Icons.markunread_mailbox_outlined,
                size: 20,
              ),
            ],
          ),
        ),
        mySizedBox(
          size: size,
          myHeight: 20,
        ),
        Text(
          "Address Details",
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
          controller: senderAddressController,
          hint: "Address Details",
          type: TextInputType.text,
          radius: 10,
          textColor: myFavColor2,
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                CustomIcons.map_marked,
                size: 20,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: cubit.isSaveSenderAddress,
              activeColor: myFavColor,
              checkColor: myFavColor7,
              onChanged: (value) {
                cubit.changeSaveSenderAddress(value!);
              },
            ),
            Text('Save This In My Address Book',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: myFavColor2, fontSize: 16)),
          ],
        ),
        mySizedBox(
          size: size,
          myHeight: 10,
        ),
      ],
    );
  }
}
