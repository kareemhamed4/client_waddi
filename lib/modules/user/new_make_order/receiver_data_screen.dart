import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:waddy_app/custom_icons_icons.dart';
import 'package:waddy_app/modules/user/new_make_order/cubit/cubit.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

//ignore: must_be_immutable
class ReceiverDataScreen extends StatelessWidget {
  ReceiverDataScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<NewMakeOrderCubit>(context);
    Size size = MediaQuery.of(context).size;
    return buildReceiverDataForm(context: context,size: size,cubit: cubit);
  }

  Widget buildReceiverDataForm({
    required Size size,
    required BuildContext context,
    required NewMakeOrderCubit cubit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Receiver Name",
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
          controller: cubit.receiverNameController,
          hint: "Receiver Name",
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
            phoneNumber: cubit.receiverPhoneController.text,
          ),
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
          controller: cubit.receiverEmailController,
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
          controller: cubit.receiverPostalCodeController,
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
          controller: cubit.receiverAddressController,
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
              value: cubit.isSaveReceiverAddress,
              activeColor: myFavColor,
              checkColor: myFavColor7,
              onChanged: (value) {
                cubit.changeSaveReceiverAddress(value!);
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
