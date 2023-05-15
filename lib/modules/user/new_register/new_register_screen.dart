import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:waddy_app/custom_icons_icons.dart';
import 'package:waddy_app/modules/common/login/waddy_login_screen.dart';
import 'package:waddy_app/modules/user/new_register/cubit/cubit.dart';
import 'package:waddy_app/modules/user/new_register/cubit/states.dart';
import 'package:waddy_app/modules/user/register/cubit/cubit.dart';
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

  final List<ExpansionItem> data = [
    ExpansionItem(
      headerText: "Personal Information",
    ),
    ExpansionItem(
      headerText: "Company Information",
    ),
  ];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<NewRegisterCubit>(context);
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<NewRegisterCubit, NewRegisterStates>(
      listener: (context, state) {
        if (state is UserSignUpSuccessState) {
          context.read<SignUpCubit>().userRegisterWithFB(
              name:
                  "${cubit.personalFirstNameController.text} ${cubit.personalLastNameController.text}",
              email: cubit.personalEmailController.text,
              phone: cubit.personalPhoneController.text,
              image:
                  "https://img.freepik.com/free-photo/pleased-european-woman-with-curly-hair-keeps-hands-cheeks-smiles-pleasantly-keeps-eyes-closed-recalls-pleasant-memories-wears-shirt-isolated-beige-background-happy-feelings-concept_273609-62609.jpg",
              password: cubit.personalPasswordController.text,
              context: context);
          Navigator.pop(context);
          buildSuccessToast(
              context: context,
              title: "Account Created",
              description: "Can login now!");
        } else if (state is CompanySignUpSuccessState) {
          context.read<SignUpCubit>().companyRegisterWithFB(
              name:
                  "${cubit.companyFirstNameController.text} ${cubit.companyLastNameController.text}",
              companyName: cubit.companyNameController.text,
              email: cubit.companyEmailController.text,
              phone: cubit.companyPhoneController.text,
              image:
                  "https://img.freepik.com/free-photo/pleased-european-woman-with-curly-hair-keeps-hands-cheeks-smiles-pleasantly-keeps-eyes-closed-recalls-pleasant-memories-wears-shirt-isolated-beige-background-happy-feelings-concept_273609-62609.jpg",
              password: cubit.companyPasswordController.text,
              context: context);
          Navigator.pop(context);
          buildSuccessToast(
              context: context,
              title: "Account Created",
              description: "Can login now!");
        } else if (state is UserSignUpErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        } else if (state is CompanySignUpErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Text(
                                "Personal Account",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
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
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                              child: Text(
                                "Company Account",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
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
                if (cubit.currentIndexForTabBar == 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        buildPersonalAccountForm(
                          context: context,
                          size: size,
                          cubit: cubit,
                        ),
                        ConditionalBuilder(
                          condition: (state is! UserSignUpLoadingState &&
                              state is! SignUpWithFBLoadingState),
                          builder: (context) => myMaterialButton(
                            context: context,
                            height: 50,
                            onPressed: () {
                              if (cubit.personalAccountFormKey.currentState!
                                  .validate()) {
                                cubit.personalAccountFormKey.currentState!
                                    .save();
                                cubit.userRegister(
                                  firstName:
                                      cubit.personalFirstNameController.text,
                                  lastName:
                                      cubit.personalLastNameController.text,
                                  email: cubit.personalEmailController.text,
                                  password:
                                      cubit.personalPasswordController.text,
                                  confirmPassword: cubit
                                      .personalConfirmPasswordController.text,
                                  phone: cubit.personalPhoneController.text,
                                  address: cubit.personalAddressController.text,
                                );
                              }
                            },
                            labelWidget: Text(
                              "Register",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                          fallback: (context) => myMaterialButton(
                            height: 50,
                            context: context,
                            onPressed: () {
                              null;
                            },
                            labelWidget: const Center(
                              child: SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: myFavColor4, fontSize: 16)),
                            myTextButton(
                                context: context,
                                textColor: myFavColor,
                                label: "sign in",
                                onPressed: () {
                                  navigateTo(context, WaddyLoginScreen());
                                }),
                          ],
                        ),
                        mySizedBox(
                          size: size,
                          myHeight: 20,
                        ),
                      ],
                    ),
                  ),
                if (cubit.currentIndexForTabBar == 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      children: [
                        buildCompanyAccountForm(
                            context: context,
                            size: size,
                            data: data,
                            cubit: cubit),
                        mySizedBox(size: size, myHeight: size.height / 2 - 100),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ConditionalBuilder(
                            condition: (state is! CompanySignUpLoadingState &&
                                state is! SignUpWithFBLoadingState),
                            builder: (context) => myMaterialButton(
                              context: context,
                              height: 50,
                              onPressed: () {
                                if (cubit.companyPersonalInformationFormKey.currentState!
                                    .validate() && cubit.companyInformationFormKey.currentState!
                                    .validate()) {
                                  cubit.companyPersonalInformationFormKey.currentState!
                                      .save();
                                  cubit.companyInformationFormKey.currentState!
                                      .save();
                                  cubit.companyRegister(
                                    firstName: cubit.companyFirstNameController.text,
                                    lastName: cubit.companyLastNameController.text,
                                    email: cubit.companyEmailController.text,
                                    password: cubit.companyPasswordController.text,
                                    confirmPassword: cubit.companyConfirmPasswordController.text,
                                    phone: "0${(cubit.companyPhoneController.text).replaceAll(" ", "")}",
                                    companyName: cubit.companyNameController.text,
                                    industry: cubit.selectedIndustry.toString(),
                                    governorate: cubit.companyGovernorateController.text,
                                    postalcode: cubit.companyPostalCodeController.text,
                                  );
                                }
                              },
                              labelWidget: Text(
                                "Register",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            fallback: (context) => myMaterialButton(
                              context: context,
                              height: 50,
                              onPressed: () {
                                null;
                              },
                              labelWidget: const Center(
                                child: SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: myFavColor4, fontSize: 16)),
                            myTextButton(
                                context: context,
                                textColor: myFavColor,
                                label: "sign in",
                                onPressed: () {
                                  navigateTo(context, WaddyLoginScreen());
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
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
            controller: cubit.personalEmailController,
            hint: "Enter Your Email",
            validate: (value) {
              if (value!.isEmpty) {
                return "Please enter valid email";
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
              const SizedBox(
                width: 28,
              ),
              Expanded(
                child: Text(
                  "Last Name",
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
                  controller: cubit.personalFirstNameController,
                  hint: "First Name",
                  type: TextInputType.text,
                  radius: 10,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your first name";
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
              const SizedBox(
                width: 28,
              ),
              Expanded(
                child: myTextFormField(
                  context: context,
                  controller: cubit.personalLastNameController,
                  hint: "Last Name",
                  type: TextInputType.text,
                  radius: 10,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your last name";
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
            controller: cubit.personalPasswordController,
            hint: "Enter Your Password",
            type: TextInputType.text,
            radius: 10,
            validate: (value) {
              if (value!.length < 8) {
                return "Please enter valid password";
              }
              return null;
            },
            textColor: myFavColor2,
            isPassword: cubit.isPassword,
            prefixIcon: const Icon(
              CustomIcons.lock_filled,
              size: 20,
            ),
            suffixIcon: IconButton(
              onPressed: (){
                cubit.changePasswordSuffixIcon();
              },
              icon: Icon(
                cubit.suffixIcon,
                size: 20,
              ),
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
            controller: cubit.personalConfirmPasswordController,
            hint: "Enter Your Password",
            type: TextInputType.text,
            radius: 10,
            validate: (value) {
              if (value != cubit.personalPasswordController.text) {
                return "password must be matched";
              }
              return null;
            },
            textColor: myFavColor2,
            isPassword: cubit.isConfirmPassword,
            prefixIcon: const Icon(
              CustomIcons.lock_filled,
              size: 20,
            ),
            suffixIcon: IconButton(
              onPressed: (){
                cubit.changeConfirmPasswordSuffixIcon();
              },
              icon: Icon(
                cubit.suffixConfirmIcon,
                size: 20,
              ),
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
              cubit.personalPhoneController.text ==
                  "0${phoneNumber.phoneNumber.toString()}";
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
        ],
      ),
    );
  }

  Widget buildCompanyAccountForm({
    required Size size,
    required BuildContext context,
    required List<ExpansionItem> data,
    required NewRegisterCubit cubit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mySizedBox(
          size: size,
          myHeight: 60,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 1,
              shape: const RoundedRectangleBorder(
                side: BorderSide.none,
              ),
              child: ExpansionPanelList(
                elevation: 0,
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int panelIndex, bool isExpanded) {
                  setState(() {
                    data[index].isExpanded = !isExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Container(
                        color:
                            data[index].isExpanded ? myFavColor5 : myFavColor7,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 10,
                            backgroundColor: myFavColor,
                            child: FaIcon(
                              index == 0
                                  ? cubit.companyPersonalInformationIcon
                                  : cubit.companyInformationIcon,
                              color: myFavColor7,
                              size: 10,
                            ),
                          ),
                          title: Text(
                            data[index].headerText,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    fontSize: 20,
                                    color: myFavColor8,
                                    height: 1.8),
                          ),
                        ),
                      );
                    },
                    body: index == 0
                        ? buildBodyOfCompanyPersonalInformation(
                            size: size, context: context, cubit: cubit)
                        : buildBodyOfCompanyInformation(
                            size: size, context: context, cubit: cubit),
                    isExpanded: data[index].isExpanded,
                    canTapOnHeader: true,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildBodyOfCompanyPersonalInformation({
    required Size size,
    required BuildContext context,
    required NewRegisterCubit cubit,
  }) =>
      Form(
        key: cubit.companyPersonalInformationFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                controller: cubit.companyEmailController,
                hint: "Enter Your Email",
                validate: (value) {
                  if (value!.isEmpty) {
                    return "Please enter valid email";
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
                  const SizedBox(
                    width: 28,
                  ),
                  Expanded(
                    child: Text(
                      "Last Name",
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
                      controller: cubit.companyFirstNameController,
                      hint: "First Name",
                      type: TextInputType.text,
                      radius: 10,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your first name";
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
                  const SizedBox(
                    width: 28,
                  ),
                  Expanded(
                    child: myTextFormField(
                      context: context,
                      controller: cubit.companyLastNameController,
                      hint: "Last Name",
                      type: TextInputType.text,
                      radius: 10,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your last name";
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
                controller: cubit.companyPasswordController,
                hint: "Enter Your Password",
                type: TextInputType.text,
                radius: 10,
                validate: (value) {
                  if (value!.length < 8) {
                    return "Please enter valid password";
                  }
                  return null;
                },
                textColor: myFavColor2,
                isPassword: cubit.isPasswordCompany,
                prefixIcon: const Icon(
                  CustomIcons.lock_filled,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  onPressed: (){
                    cubit.changePasswordSuffixIconCompany();
                  },
                  icon: Icon(
                    cubit.suffixIconCompany,
                    size: 20,
                  ),
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
                controller: cubit.companyConfirmPasswordController,
                hint: "Enter Your Password",
                type: TextInputType.text,
                radius: 10,
                validate: (value) {
                  if (value != cubit.companyPasswordController.text) {
                    return "password must be matched";
                  }
                  return null;
                },
                textColor: myFavColor2,
                isPassword: cubit.isConfirmPasswordCompany,
                prefixIcon: const Icon(
                  CustomIcons.lock_filled,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  onPressed: (){
                    cubit.changeConfirmPasswordSuffixIconCompany();
                  },
                  icon: Icon(
                    cubit.suffixConfirmIconCompany,
                    size: 20,
                  ),
                ),
              ),
              mySizedBox(
                size: size,
                myHeight: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 150,
                  child: myMaterialButton(
                    context: context,
                    height: 50,
                    labelWidget: Text(
                      "Next",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    onPressed: () {
                      if (cubit.companyPersonalInformationFormKey.currentState!
                          .validate()) {
                        cubit.companyPersonalInformationFormKey.currentState!
                            .save();
                        setState(() {
                          data[0].isExpanded = false;
                          data[1].isExpanded = true;
                        });
                        cubit.changeCompanyPersonalInformationIcon();
                      }
                    },
                  ),
                ),
              ),
              mySizedBox(
                size: size,
                myHeight: 20,
              ),
            ],
          ),
        ),
      );

  Widget buildBodyOfCompanyInformation({
    required Size size,
    required BuildContext context,
    required NewRegisterCubit cubit,
  }) =>
      Form(
        key: cubit.companyInformationFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mySizedBox(
                size: size,
                myHeight: 20,
              ),
              Text(
                "Company Name",
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
                controller: cubit.companyNameController,
                hint: "Enter Company Name",
                validate: (value) {
                  if (value!.isEmpty) {
                    return "Please enter company name";
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
                      FontAwesomeIcons.buildingColumns,
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
                "Industry",
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
                    FontAwesomeIcons.industry,
                    color: myFavColor4,
                    size: 20,
                  ),
                  validateText: "Please select",
                  dropMenuItems: cubit.industry,
                  selectedValue: cubit.selectedIndustry ?? "",
                  hintText: cubit.selectedIndustry ?? "Technology",
                  onChange: (value) {
                    cubit.selectedIndustry = value.toString();
                  }),
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
                selectorTextStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 18),
                initialValue: PhoneNumber(
                    isoCode: "EG",
                    dialCode: "+20",
                    phoneNumber: cubit.companyPhoneController.text),
                textFieldController: cubit.companyPhoneController,
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 18),
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
                  cubit.companyPhoneController.text ==
                      "0${phoneNumber.phoneNumber.toString()}";
                },
              ),
              mySizedBox(
                size: size,
                myHeight: 20,
              ),
              Text(
                "Governorate",
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
                controller: cubit.companyGovernorateController,
                hint: "Enter Company Governorate",
                validate: (value) {
                  if (value!.isEmpty) {
                    return "Please enter company governorate";
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
                controller: cubit.companyPostalCodeController,
                hint: "Enter Postal Code",
                validate: (value) {
                  if (value!.length < 5) {
                    return "Please enter valid postal code";
                  }
                  return null;
                },
                type: TextInputType.phone,
                radius: 10,
                textColor: myFavColor2,
                prefixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
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
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 150,
                  child: myMaterialButton(
                    context: context,
                    height: 50,
                    labelWidget: Text(
                      "Finish",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    onPressed: () {
                      if (cubit.companyInformationFormKey.currentState!
                          .validate()) {
                        cubit.companyInformationFormKey.currentState!.save();
                        setState(() {
                          data[0].isExpanded = false;
                          data[1].isExpanded = false;
                        });
                        cubit.changeCompanyInformationIcon();
                      }
                    },
                  ),
                ),
              ),
              mySizedBox(
                size: size,
                myHeight: 20,
              ),
            ],
          ),
        ),
      );
}

class ExpansionItem {
  String headerText;
  bool isExpanded;

  ExpansionItem({
    required this.headerText,
    this.isExpanded = false,
  });
}
