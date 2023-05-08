import 'package:flutter/material.dart';
import 'package:waddy_app/other_screens/component.dart';
import 'package:waddy_app/other_screens/regist/data_company.dart';
import 'package:waddy_app/other_screens/regist/data_person.dart';

// import '../../shared/components/component.dart';

class Regist_layout extends StatefulWidget {
  const Regist_layout({super.key});

  @override
  State<Regist_layout> createState() => _Regist_layoutState();
}

class _Regist_layoutState extends State<Regist_layout>{

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
                              defaultFormField(
                                controller: email_controller,
                                type: TextInputType.emailAddress,
                                label: 'Email',
                                prefix: Icons.email,
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
                              defaultFormField(
                                controller: fname_controller,
                                type: TextInputType.name,
                                label: 'First Name',
                                prefix: Icons.person,
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
                              defaultFormField(
                                controller: lname_controller,
                                type: TextInputType.name,
                                label: 'Last Name',
                                prefix: Icons.person,
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
                              defaultFormField(
                                controller: password_controller,
                                type: TextInputType.visiblePassword,
                                label: 'Password',
                                prefix: Icons.lock,
                                suffix: ispasswordshow
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off,
                                suffix_pressed: () {
                                  setState(() {
                                    ispasswordshow = !ispasswordshow;
                                  });
                                },
                                ispassword: ispasswordshow,
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
                              defaultFormField(
                                controller: confirm_controller,
                                type: TextInputType.visiblePassword,
                                label: 'Confirm Password',
                                prefix: Icons.lock,
                                suffix: isconfirmshow
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off,
                                suffix_pressed: () {
                                  setState(() {
                                    isconfirmshow = !isconfirmshow;
                                  });
                                },
                                ispassword: isconfirmshow,
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
                              defaultFormField(
                                controller: phone_controller,
                                type: TextInputType.phone,
                                label: 'Phone',
                                prefix: Icons.phone_iphone_outlined,
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
                              defaultFormField(
                                controller: address_controller,
                                type: TextInputType.streetAddress,
                                label: 'Address',
                                prefix: Icons.location_on,
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
                              defaultButton(
                                function: () {
                                  if (form_key.currentState!.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Regist_date(
                                          email: email_controller,
                                          fname: fname_controller,
                                          lname: lname_controller,
                                          password: password_controller,
                                          phone: phone_controller,
                                          address: address_controller,
                                        ),
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
                                text: 'regist',
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
                              defaultFormField(
                                controller: email2_controller,
                                type: TextInputType.emailAddress,
                                label: 'Email',
                                prefix: Icons.email,
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
                              defaultFormField(
                                controller: fname2_controller,
                                type: TextInputType.name,
                                label: 'First Name',
                                prefix: Icons.person,
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
                              defaultFormField(
                                controller: lname2_controller,
                                type: TextInputType.name,
                                label: 'Last Name',
                                prefix: Icons.person,
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
                              defaultFormField(
                                controller: password2_controller,
                                type: TextInputType.visiblePassword,
                                label: 'Password',
                                prefix: Icons.lock,
                                suffix: ispasswordshow
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off,
                                suffix_pressed: () {
                                  setState(() {
                                    ispasswordshow = !ispasswordshow;
                                  });
                                },
                                ispassword: ispasswordshow,
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
                              defaultFormField(
                                controller: confirm2_controller,
                                type: TextInputType.visiblePassword,
                                label: 'Confirm Password',
                                prefix: Icons.lock,
                                suffix: isconfirmshow
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off,
                                suffix_pressed: () {
                                  setState(() {
                                    isconfirmshow = !isconfirmshow;
                                  });
                                },
                                ispassword: isconfirmshow,
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
                              defaultFormField(
                                controller: cname_controller,
                                type: TextInputType.name,
                                label: 'Company Name',
                                prefix: Icons.badge,
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
                              defaultFormField(
                                controller: cindustry_controller,
                                type: TextInputType.name,
                                label: 'Industry',
                                prefix: Icons.shop_2_rounded,
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
                              defaultFormField(
                                controller: phone2_controller,
                                type: TextInputType.phone,
                                label: 'Phone',
                                prefix: Icons.phone,
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
                              defaultFormField(
                                controller: cgovernrate_controller,
                                type: TextInputType.name,
                                label: 'Governorate',
                                prefix: Icons.location_city,
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
                              defaultFormField(
                                controller: cpostel_controller,
                                type: TextInputType.number,
                                label: 'Postel Code',
                                prefix: Icons.contact_mail_rounded,
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
                              defaultButton(
                                function: () {
                                  if (form2_key.currentState!.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Regist2_date(
                                          email2: email2_controller,
                                          fname2: fname2_controller,
                                          lname2: lname2_controller,
                                          password2: password2_controller,
                                          cname: cname_controller,
                                          cindustry: cindustry_controller,
                                          phone2: phone2_controller,
                                          cgovernrate: cgovernrate_controller,
                                          cpostel: cpostel_controller,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                text: 'regist',
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