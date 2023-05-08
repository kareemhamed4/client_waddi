import 'package:flutter/material.dart';
import 'package:waddy_app/other_screens/component.dart';
import 'package:waddy_app/other_screens/order/package.dart';


class RecevierData extends StatefulWidget {
  const RecevierData({super.key});

  @override
  State<RecevierData> createState() => _RecevierDataState();
}

var form_key_recevier = GlobalKey<FormState>();

var rname_controller = TextEditingController();
var rphone_controller = TextEditingController();
var remail_controller = TextEditingController();
var rpostelcode_controller = TextEditingController();
var raddress_controller = TextEditingController();



class _RecevierDataState extends State<RecevierData> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 75, 84, 1),
        title: Text(
          'Recevier Date',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: form_key_recevier,
            child: Column(
              children: [
                SizedBox(
                    height: 15,
                  ),
                   // recevier name
                    defaultFormField(
                      controller: rname_controller,
                      type: TextInputType.name,
                      label: 'Recevier Name',
                      prefix: Icons.person,
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
                    // recevier phone
                    defaultFormField(
                      controller: rphone_controller,
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
                    // recevier email
                    defaultFormField(
                      controller: remail_controller,
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
                    // postel code
                    defaultFormField(
                      controller: rpostelcode_controller,
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
                      height: 15,
                    ),
                    // recevier address
                    defaultFormField(
                      controller: raddress_controller,
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
                      if (form_key_recevier.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Package(),
                          ),
                        );
                      }
                    },
                    text: 'next',
                  ),
                  
              ],
            ),
          ),
        ),
      ),
    );
  
  }
}