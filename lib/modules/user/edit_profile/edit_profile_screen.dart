import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:waddy_app/custom_icons_icons.dart';
import 'package:waddy_app/modules/user/profile/cubit/cubit.dart';
import 'package:waddy_app/modules/user/profile/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class UserEditProfileScreen extends StatelessWidget {
  const UserEditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController fNameController = TextEditingController();
    TextEditingController lNameController = TextEditingController();
    TextEditingController birthController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    TextEditingController companyNameController = TextEditingController();
    TextEditingController industryController = TextEditingController();
    TextEditingController governorateController = TextEditingController();

    var model = UserProfileCubit.get(context).userInfo;
    fNameController.text = model != null ? model.firstName! : " ";
    lNameController.text = model != null ? model.lastName! : " ";
    birthController.text = "12/27/1999";
    emailController.text = model != null ? model.email! : " ";
    phoneController.text = model != null ? model.phone! : " ";
    addressController.text =
        model != null && model.address != null ? model.address! : " ";

    companyNameController.text =
        model != null && model.companyName != null ? model.companyName! : " ";
    industryController.text =
        model != null && model.industry != null ? model.industry! : " ";
    governorateController.text =
        model != null && model.governorate != null ? model.governorate! : " ";

    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserProfileCubit, UserProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "Edit Profile",
            titleColor: myFavColor2,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mySizedBox(size: size, myHeight: 20),
                  if (model != null && model.companyName != null)
                    Column(
                      children: [
                        Text(
                          "Personal Info",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: myFavColor,
                                    fontSize: 22,
                                  ),
                        ),
                        mySizedBox(size: size, myHeight: 20),
                      ],
                    ),
                  myTextFormField(
                    context: context,
                    controller: fNameController,
                    hint: "First Name",
                    type: TextInputType.text,
                    radius: 10,
                    textColor: myFavColor2,
                    suffixIcon: const Icon(
                      Icons.person,
                      size: 25,
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 20),
                  myTextFormField(
                    context: context,
                    controller: lNameController,
                    hint: "Last Name",
                    type: TextInputType.text,
                    radius: 10,
                    textColor: myFavColor2,
                    suffixIcon: const Icon(
                      Icons.person,
                      size: 25,
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 20),
                  myTextFormField(
                    context: context,
                    controller: birthController,
                    hint: "Date Of Birth",
                    type: TextInputType.text,
                    radius: 10,
                    textColor: myFavColor2,
                    suffixIcon: const Icon(
                      CustomIcons.calendar,
                      size: 25,
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 20),
                  myTextFormField(
                    context: context,
                    controller: emailController,
                    hint: "Email",
                    type: TextInputType.emailAddress,
                    radius: 10,
                    textColor: myFavColor2,
                    suffixIcon: const Icon(
                      Icons.email,
                      size: 25,
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 20),
                  InternationalPhoneNumberInput(
                    selectorTextStyle: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 18),
                    initialValue: PhoneNumber(
                        isoCode: "EG",
                        dialCode: "+20",
                        phoneNumber: phoneController.text),
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 18),
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
                  mySizedBox(size: size, myHeight: 20),
                  if (model != null && model.address != null)
                    myTextFormField(
                      context: context,
                      controller: addressController,
                      hint: "Address",
                      type: TextInputType.text,
                      radius: 10,
                      textColor: myFavColor2,
                      suffixIcon: const Icon(
                        CustomIcons.map_marked,
                        size: 20,
                      ),
                    ),
                  if (model != null && model.companyName != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mySizedBox(size: size, myHeight: 20),
                        Text(
                          "Company Info",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: myFavColor,
                                    fontSize: 22,
                                  ),
                        ),
                        mySizedBox(size: size, myHeight: 20),
                        myTextFormField(
                          context: context,
                          controller: companyNameController,
                          hint: "Company Name",
                          type: TextInputType.text,
                          radius: 10,
                          textColor: myFavColor2,
                          suffixIcon: const Icon(
                            FontAwesomeIcons.buildingColumns,
                            size: 20,
                          ),
                        ),
                        mySizedBox(size: size, myHeight: 20),
                        myTextFormField(
                          context: context,
                          controller: industryController,
                          hint: "Industry",
                          type: TextInputType.text,
                          radius: 10,
                          textColor: myFavColor2,
                          suffixIcon: const Icon(
                            FontAwesomeIcons.industry,
                            size: 20,
                          ),
                        ),
                        mySizedBox(size: size, myHeight: 20),
                        myTextFormField(
                          context: context,
                          controller: governorateController,
                          hint: "Governorate",
                          type: TextInputType.text,
                          radius: 10,
                          textColor: myFavColor2,
                          suffixIcon: const Icon(
                            CustomIcons.map_marked,
                            size: 20,
                          ),
                        ),
                        mySizedBox(size: size, myHeight: 40),
                      ],
                    ),
                  if (model != null && model.companyName == null)
                    mySizedBox(size: size, myHeight: 140),
                  myMaterialButton(
                    context: context,
                    onPressed: () {},
                    height: 50,
                    labelWidget: Text(
                      "Update",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 60),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
