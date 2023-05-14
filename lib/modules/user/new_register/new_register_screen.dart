import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:waddy_app/custom_icons_icons.dart';
import 'package:waddy_app/modules/user/new_register/cubit/cubit.dart';
import 'package:waddy_app/modules/user/new_register/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class NewRegisterScreen extends StatefulWidget {
  const NewRegisterScreen({Key? key}) : super(key: key);

  @override
  State<NewRegisterScreen> createState() => _NewRegisterScreenState();
}

class _NewRegisterScreenState extends State<NewRegisterScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<NewRegisterCubit, NewRegisterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewRegisterCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: defaultAppBar(context: context),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                  "Create your account",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: myFavColor8, fontSize: 28),
                ),
                mySizedBox(
                  size: size,
                  myHeight: 10,
                ),
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: ColoredBox(
                    color: myFavColor5,
                    child: TabBar(
                      controller: tabController,
                      splashFactory: NoSplash.splashFactory,
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          return states.contains(MaterialState.focused)
                              ? null
                              : Colors.transparent;
                        },
                      ),
                      onTap: (index) {
                        cubit.changeTabBarIndex(index);
                        cubit.currentIndexForTabBar = index;
                      },
                      indicatorPadding: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      indicatorWeight: 0.1,
                      indicatorColor: Colors.transparent,
                      tabs: [
                        Tab(
                          child: Container(
                            width: size.width * 164 / 375,
                            decoration: BoxDecoration(
                              color: cubit.currentIndexForTabBar == 0
                                  ? myFavColor
                                  : myFavColor5,
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Text(
                                "Personal Account",
                                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  color: cubit.currentIndexForTabBar == 0
                                      ? myFavColor7
                                      : myFavColor4,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            width: size.width * 164 / 375,
                            decoration: BoxDecoration(
                              color: cubit.currentIndexForTabBar == 1
                                  ? myFavColor
                                  : myFavColor5,
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Text(
                                "Company Account",
                                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  color: cubit.currentIndexForTabBar == 1
                                      ? myFavColor7
                                      : myFavColor4,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if(cubit.currentIndexForTabBar == 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        buildPersonalAccountForm(context: context,size: size,cubit: cubit),
                      ],
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPersonalAccountForm({
    required Size size,
    required BuildContext context,
    required NewRegisterCubit cubit,
  }) {
    return Form(
      key: cubit.personalAccountFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mySizedBox(
            size: size,
            myHeight: 20,
          ),
          Text(
            "Email",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: myFavColor8, fontSize: 17),
          ),
          mySizedBox(
            size: size,
            myHeight: 6,
          ),
          myTextFormField(
            context: context,
            controller: cubit.personalFirstNameController,
            hint: "Enter Your First Name",
            validate: (value) {
              if (value!.isEmpty) {
                return "Please enter your first name";
              }
              return null;
            },
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
          Row(
            children: [
              Expanded(
                child: Text(
                  "First Name",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: myFavColor8, fontSize: 16),
                ),
              ),
              const SizedBox(width: 28,),
              Expanded(
                child: Text(
                  "Last Name ",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: myFavColor8, fontSize: 16),
                ),
              ),
            ],
          ),
          mySizedBox(
            size: size,
            myHeight: 6,
          ),
          Row(
            children: [
              Expanded(
                child: myTextFormField(
                  context: context,
                  controller: cubit.personalEmailController,
                  hint: "First Name",
                  type: TextInputType.text,
                  radius: 10,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                  textColor: myFavColor2,
                  prefixIcon: const Icon(
                    Icons.person,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 28,),
              Expanded(
                child: myTextFormField(
                  context: context,
                  controller: cubit.personalEmailController,
                  hint: "Last Name",
                  type: TextInputType.text,
                  radius: 10,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                  textColor: myFavColor2,
                  prefixIcon: const Icon(
                    Icons.person,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          mySizedBox(
            size: size,
            myHeight: 20,
          ),
          Text(
            "Password",
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
            controller: cubit.personalEmailController,
            hint: "Enter Your Password",
            type: TextInputType.text,
            radius: 10,
            validate: (value) {
              if (value!.isEmpty) {
                return "Please enter valid email";
              }
              return null;
            },
            textColor: myFavColor2,
            isPassword: true,
            prefixIcon: const Icon(
              CustomIcons.lock_filled,
              size: 20,
            ),
            suffixIcon: const Icon(
              Icons.visibility_off_outlined,
              size: 20,
            ),
          ),
          mySizedBox(
            size: size,
            myHeight: 20,
          ),
          Text(
            "Confirm Password",
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
            controller: cubit.personalEmailController,
            hint: "Enter Your Password",
            type: TextInputType.text,
            radius: 10,
            validate: (value) {
              if (value!.isEmpty) {
                return "Please enter valid email";
              }
              return null;
            },
            textColor: myFavColor2,
            isPassword: true,
            prefixIcon: const Icon(
              CustomIcons.lock_filled,
              size: 20,
            ),
            suffixIcon: const Icon(
              Icons.visibility_off_outlined,
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
                phoneNumber: cubit.personalPhoneController.text),
            textFieldController: cubit.personalPhoneController,
            textStyle:
            Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
            maxLength: 12,
            validator: (value) {
              if (value!.length < 12) {
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
            onSaved: (phoneNumber) {
              cubit.personalPhoneController.text == "0${phoneNumber.phoneNumber.toString()}";
            },

          ),
          mySizedBox(
            size: size,
            myHeight: 20,
          ),
          Text(
            "Address",
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
            controller: cubit.personalAddressController,
            hint: "Enter Your Address",
            validate: (value) {
              if (value!.isEmpty) {
                return "Please enter your address";
              }
              return null;
            },
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
          mySizedBox(
            size: size,
            myHeight: 20,
          ),
          myMaterialButton(
            context: context,
            height: 50,
            labelWidget: Text(
              "Register",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: () {
              if (cubit.personalAccountFormKey.currentState!.validate()) {
                cubit.personalAccountFormKey.currentState!.save();
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account ?',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4,fontSize: 18)
              ),
              myTextButton(
                  context: context,
                  textColor: myFavColor,
                  label: "sign in",
                  onPressed: (){
                    Navigator.pop(context);
                  }
              ),
            ],
          ),
          mySizedBox(
            size: size,
            myHeight: 20,
          ),
        ],
      ),
    );
  }
}
