import 'package:flutter/material.dart';
import 'package:waddy_app/modules/user/make_order/receiver/receiver_screen.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/components.dart';

class FillSenderDateScreen extends StatefulWidget {
  const FillSenderDateScreen({super.key});

  @override
  State<FillSenderDateScreen> createState() => _FillSenderDateScreenState();
}

var form_key_sender = GlobalKey<FormState>();

var sname_controller = TextEditingController();
var sphone_controller = TextEditingController();
var semail_controller = TextEditingController();
var spostelcode_controller = TextEditingController();
var saddress_controller = TextEditingController();



class _FillSenderDateScreenState extends State<FillSenderDateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 75, 84, 1),
        title: Text(
          'Sender Date',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: form_key_sender,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),

                // sender name
                myTextFormField(
                  context: context,
                  controller: sname_controller,
                  type: TextInputType.name,
                  hint: 'Sender Name',
                  prefixIcon:Icon( Icons.person),
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'name is empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                // sender phone
                myTextFormField(
                  context: context,
                  controller: sphone_controller,
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
                // sender email
                myTextFormField(
                  context: context,
                  controller: semail_controller,
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
                // postel code
                myTextFormField(
                  context: context,
                  controller: spostelcode_controller,
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
                  height: 15,
                ),
                // sender address
                myTextFormField(
                  context: context,
                  controller: saddress_controller,
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
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                ),

                myMaterialButton(
                  context: context,
                  onPressed: () {
                    if (form_key_sender.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FillReceiverDataScreen(),
                        ),
                      );
                    }
                  },
                  labelWidget: Text("next"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
