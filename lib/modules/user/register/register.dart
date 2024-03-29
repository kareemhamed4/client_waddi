/*
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/common/login/waddy_login_screen.dart';
import 'package:waddy_app/modules/user/register/cubit/cubit.dart';
import 'package:waddy_app/modules/user/register/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isperson = true;
  bool ispasswordshow = true;
  bool isconfirmshow = true;
  // form person
  var formKey = GlobalKey<FormState>();
  var email_controller = TextEditingController();
  var fname_controller = TextEditingController();
  var lname_controller = TextEditingController();
  var password_controller = TextEditingController();
  var confirm_controller = TextEditingController();
  var phone_controller = TextEditingController();
  var address_controller = TextEditingController();

  // form company
  var form2_key = GlobalKey<FormState>();
  var email2_controller = TextEditingController();
  var fname2_controller = TextEditingController();
  var lname2_controller = TextEditingController();
  var password2_controller = TextEditingController();
  var confirm2_controller = TextEditingController();
  var cname_controller = TextEditingController();
  var cindustry_controller = TextEditingController();
  var phone2_controller = TextEditingController();
  var cgovernrate_controller = TextEditingController();
  var cpostel_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpStates>(
      listener: (context, state) {
        if (state is UserSignUpSuccessState) {
          context.read<SignUpCubit>().userRegisterWithFB(
              name: "${fname_controller.text} ${lname_controller.text}",
              email: email_controller.text,
              phone: phone_controller.text,
              image: "https://img.freepik.com/free-photo/pleased-european-woman-with-curly-hair-keeps-hands-cheeks-smiles-pleasantly-keeps-eyes-closed-recalls-pleasant-memories-wears-shirt-isolated-beige-background-happy-feelings-concept_273609-62609.jpg",
              password: password_controller.text,
              context: context);
          Navigator.pop(context);
          buildSuccessToast(
              context: context,
              title: "Account Created",
              description: "Can login now!");
        }
        else if (state is CompanySignUpSuccessState) {
          context.read<SignUpCubit>().companyRegisterWithFB(
              name: "${fname2_controller.text} ${lname2_controller.text}",
              companyName: cname_controller.text,
              email: email2_controller.text,
              phone: phone2_controller.text,
              image: "https://img.freepik.com/free-photo/pleased-european-woman-with-curly-hair-keeps-hands-cheeks-smiles-pleasantly-keeps-eyes-closed-recalls-pleasant-memories-wears-shirt-isolated-beige-background-happy-feelings-concept_273609-62609.jpg",
              password: password2_controller.text,
              context: context);
          Navigator.pop(context);
          buildSuccessToast(
              context: context,
              title: "Account Created",
              description: "Can login now!");
        }
        else if (state is UserSignUpErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
        else if (state is CompanySignUpErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context, state) {
        SignUpCubit cubit = BlocProvider.of(context);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(255, 75, 84, 1),
              title: Text(
                'Create your account',
              ),
              bottom: TabBar(
                labelStyle:
                    TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                indicatorWeight: 3,
                indicatorColor: Colors.white,
                tabs: <Widget>[
                  Tab(
                    text: 'Personal Account',
                  ),
                  Tab(
                    text: 'Company Account',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  // email
                                  myTextFormField(
                                    context: context,
                                    controller: email_controller,
                                    type: TextInputType.emailAddress,
                                    hint: 'Email',
                                    prefixIcon: Icon(Icons.email),
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'email is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // f_name
                                  myTextFormField(
                                    context: context,
                                    controller: fname_controller,
                                    type: TextInputType.name,
                                    hint: 'First Name',
                                    prefixIcon: Icon(Icons.person),
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'first name is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // l_name
                                  myTextFormField(
                                    context: context,
                                    controller: lname_controller,
                                    type: TextInputType.name,
                                    hint: 'Last Name',
                                    prefixIcon: Icon(Icons.person),
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'last name is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // password
                                  myTextFormField(
                                    context: context,
                                    controller: password_controller,
                                    type: TextInputType.visiblePassword,
                                    hint: 'Password',
                                    prefixIcon: Icon(Icons.lock),
                                    isPassword: ispasswordshow,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'password is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // confirm password
                                  myTextFormField(
                                    context: context,
                                    controller: confirm_controller,
                                    type: TextInputType.visiblePassword,
                                    hint: 'Confirm Password',
                                    prefixIcon: Icon(Icons.lock),
                                    isPassword: isconfirmshow,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'confirm password is empty';
                                      } else if (confirm_controller.text !=
                                          password_controller.text) {
                                        return 'the confirm don\'t match password';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // phone
                                  myTextFormField(
                                    context: context,
                                    controller: phone_controller,
                                    type: TextInputType.phone,
                                    hint: 'Phone',
                                    prefixIcon:
                                        Icon(Icons.phone_iphone_outlined),
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'phone is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // address
                                  myTextFormField(
                                    context: context,
                                    controller: address_controller,
                                    type: TextInputType.streetAddress,
                                    hint: 'Address',
                                    prefixIcon: Icon(Icons.location_on),
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'address is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  ConditionalBuilder(
                                    condition:
                                        (state is! UserSignUpLoadingState &&
                                            state is! SignUpWithFBLoadingState),
                                    builder: (context) => myMaterialButton(
                                      context: context,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit
                                              .userRegister(
                                            firstName: fname_controller.text,
                                            lastName: lname_controller.text,
                                            email: email_controller.text,
                                            password: password_controller.text,
                                            confirmPassword:
                                                confirm_controller.text,
                                            phone: phone_controller.text,
                                            address: address_controller.text,
                                          );
                                        }
                                      },
                                      labelWidget: Text(
                                        "Register",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                    fallback: (context) => myMaterialButton(
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account ?',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(158, 158, 158, 1),
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () {},
                                        child: Text(
                                          'sign in',
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(255, 75, 84, 1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Form(
                              key: form2_key,
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      'Personal information',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // email
                                  myTextFormField(
                                    context: context,
                                    controller: email2_controller,
                                    type: TextInputType.emailAddress,
                                    hint: 'Email',
                                    prefixIcon: Icon(Icons.email),
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'email is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // f_name
                                  myTextFormField(
                                    context: context,
                                    controller: fname2_controller,
                                    type: TextInputType.name,
                                    hint: 'First Name',
                                    prefixIcon: Icon(Icons.person),
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'first name is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // l_name
                                  myTextFormField(
                                    context: context,
                                    controller: lname2_controller,
                                    type: TextInputType.name,
                                    hint: 'Last Name',
                                    prefixIcon: Icon(Icons.person),
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'last name is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // password
                                  myTextFormField(
                                    context: context,
                                    controller: password2_controller,
                                    type: TextInputType.visiblePassword,
                                    hint: 'Password',
                                    prefixIcon: Icon(Icons.lock),
                                    isPassword: ispasswordshow,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'password is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // confirm password
                                  myTextFormField(
                                    context: context,
                                    controller: confirm2_controller,
                                    type: TextInputType.visiblePassword,
                                    hint: 'Confirm Password',
                                    prefixIcon: Icon(Icons.lock),
                                    isPassword: isconfirmshow,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'confirm password is empty';
                                      } else if (confirm2_controller.text !=
                                          password2_controller.text) {
                                        return 'the confirm don\'t match password';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                    child: Text(
                                      'Company information',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // company name
                                  myTextFormField(
                                    context: context,
                                    controller: cname_controller,
                                    type: TextInputType.name,
                                    hint: 'Company Name',
                                    prefixIcon: Icon(Icons.badge),
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Company Name is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // industry
                                  myTextFormField(
                                    context: context,
                                    controller: cindustry_controller,
                                    type: TextInputType.name,
                                    hint: 'Industry',
                                    prefixIcon: Icon(Icons.shop_2_rounded),
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'industry is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // phone
                                  myTextFormField(
                                    context: context,
                                    controller: phone2_controller,
                                    type: TextInputType.phone,
                                    hint: 'Phone',
                                    prefixIcon: Icon(Icons.phone),
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Phone is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // governorate
                                  myTextFormField(
                                    context: context,
                                    controller: cgovernrate_controller,
                                    type: TextInputType.name,
                                    hint: 'Governorate',
                                    prefixIcon: Icon(Icons.location_city),
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'governorate is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // postel code
                                  myTextFormField(
                                    context: context,
                                    controller: cpostel_controller,
                                    type: TextInputType.number,
                                    hint: 'Postel Code',
                                    prefixIcon:
                                        Icon(Icons.contact_mail_rounded),
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Postel Code is empty';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  ConditionalBuilder(
                                    condition:
                                        (state is! CompanySignUpLoadingState &&
                                            state is! SignUpWithFBLoadingState),
                                    builder: (context) => myMaterialButton(
                                      context: context,
                                      onPressed: () {
                                        if (form2_key.currentState!
                                            .validate()) {
                                          cubit
                                              .companyRegister(
                                            firstName: fname2_controller.text,
                                            lastName: lname2_controller.text,
                                            email: email2_controller.text,
                                            password: password2_controller.text,
                                            confirmPassword:
                                                confirm2_controller.text,
                                            phone: phone2_controller.text,
                                            companyName: cname_controller.text,
                                            industry: cindustry_controller.text,
                                            governorate:
                                                cgovernrate_controller.text,
                                            postalcode: cpostel_controller.text,
                                          );
                                        }
                                      },
                                      labelWidget: Text(
                                        "Register",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                    fallback: (context) => myMaterialButton(
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account ?',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(158, 158, 158, 1),
                                        ),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          navigateTo(
                                              context, WaddyLoginScreen());
                                        },
                                        child: Text(
                                          'sign in',
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(255, 75, 84, 1),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
*/
