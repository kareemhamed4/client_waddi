import 'package:flutter/material.dart';
import 'package:waddy_app/modules/user/make_order/order_pack/order_pack_screen.dart';
import 'package:waddy_app/shared/components/components.dart';


class FillReceiverDataScreen extends StatefulWidget {
  const FillReceiverDataScreen({super.key});

  @override
  State<FillReceiverDataScreen> createState() => _FillReceiverDataScreenState();
}

var form_key_recevier = GlobalKey<FormState>();

var rname_controller = TextEditingController();
var rphone_controller = TextEditingController();
var remail_controller = TextEditingController();
var rpostelcode_controller = TextEditingController();
var raddress_controller = TextEditingController();



class _FillReceiverDataScreenState extends State<FillReceiverDataScreen> {
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
                myTextFormField(
                  context: context,
                  controller: rname_controller,
                  type: TextInputType.name,
                  hint: 'Recevier Name',
                  prefixIcon: Icon(Icons.person),
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
                myTextFormField(
                  context: context,
                  controller: rphone_controller,
                  type: TextInputType.phone,
                  hint: 'Phone',
                  prefixIcon: Icon(Icons.phone_iphone_outlined),
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
                myTextFormField(
                  context: context,
                  controller: remail_controller,
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
                // postel code
                myTextFormField(
                  context: context,
                  controller: rpostelcode_controller,
                  type: TextInputType.number,
                  hint: 'Postel Code',
                  prefixIcon: Icon(Icons.contact_mail_rounded),
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
                myTextFormField(
                  context: context,
                  controller: raddress_controller,
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

                myMaterialButton(
                  context: context,
                  onPressed: () {
                    if (form_key_recevier.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderPackageScreen(),
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