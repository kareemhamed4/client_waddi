import 'package:flutter/material.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{

  bool isperson = true;
  bool ispasswordshow = true;
  bool isconfirmshow = true;
  // form person
  var form_key = GlobalKey<FormState>();
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 75, 84, 1),
          title: Text(
            'Create your account',
          ),
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
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
                          key: form_key,
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
                                prefixIcon:Icon( Icons.email),
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
                                prefixIcon:Icon( Icons.person),
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
                                prefixIcon:Icon( Icons.person),
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
                                prefixIcon:Icon( Icons.lock),
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
                                prefixIcon:Icon( Icons.lock),
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
                                prefixIcon:Icon( Icons.phone_iphone_outlined),
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
                                prefixIcon:Icon( Icons.location_on),
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
                              myMaterialButton(
                                context: context,
                                onPressed: () {
                                  if (form_key.currentState!.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SizedBox()
                                      ),
                                    );

                                    print(email_controller.text);
                                    print(fname_controller.text);
                                    print(lname_controller.text);
                                    print(password_controller.text);
                                    print(confirm_controller.text);
                                    print(phone_controller.text);
                                    print(address_controller.text);
                                  }
                                },
                                labelWidget: Text("regist"),
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
                                      color: Color.fromRGBO(158, 158, 158, 1),
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () {},
                                    child: Text(
                                      'sign in',
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 75, 84, 1),
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
                                prefixIcon:Icon( Icons.email),
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
                                prefixIcon:Icon( Icons.person),
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
                                prefixIcon:Icon( Icons.person),
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
                                prefixIcon:Icon( Icons.lock),
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
                                prefixIcon:Icon( Icons.lock),
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
                                prefixIcon:Icon( Icons.badge),
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
                                prefixIcon:Icon( Icons.shop_2_rounded),
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
                                prefixIcon:Icon( Icons.phone),
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
                                prefixIcon:Icon( Icons.location_city),
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
                                prefixIcon:Icon( Icons.contact_mail_rounded),
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
                              myMaterialButton(
                                context: context,
                                onPressed: () {
                                  if (form2_key.currentState!.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SizedBox()
                                      ),
                                    );
                                  }
                                },
                                labelWidget: Text("regist"),
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
                                      color: Color.fromRGBO(158, 158, 158, 1),
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () {},
                                    child: Text(
                                      'sign in',
                                      style: TextStyle(
                                        color: Color.fromRGBO(255, 75, 84, 1),
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
  }
}