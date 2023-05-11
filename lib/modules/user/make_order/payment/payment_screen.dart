import 'package:flutter/material.dart';
import 'package:waddy_app/modules/user/make_order/confirm_order/confirm_order_screen.dart';
import 'package:waddy_app/modules/user/make_order/receiver/receiver_screen.dart';
import 'package:waddy_app/modules/user/make_order/sender/sender_screen.dart';
import 'package:waddy_app/shared/components/components.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

var form_key_payment = GlobalKey<FormState>();

var cardNumber_controller = TextEditingController();
var nameincard_controller = TextEditingController();
var expirydate_controller = TextEditingController();
var securitycode_controller = TextEditingController();



class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 75, 84, 1),
        title: Text(
          'Payment',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: form_key_payment,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                // card number
                myTextFormField(
                  context: context,
                  controller: cardNumber_controller,
                  type: TextInputType.number,
                  hint: 'Card Number',
                  prefixIcon: Icon(Icons.numbers_outlined,),
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'card number is empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                // name in card
                myTextFormField(
                  context: context,
                  controller: nameincard_controller,
                  type: TextInputType.name,
                  hint: 'Name In Card',
                  prefixIcon: Icon(Icons.abc,),
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'name in card is empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                // expiry date
                myTextFormField(
                  context: context,
                  controller: expirydate_controller,
                  hint: 'Expiry date',
                  type: TextInputType.datetime,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'expiry date is empty';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                // security code
                myTextFormField(
                  context: context,
                  controller: securitycode_controller,
                  hint: 'Security Code',
                  type: TextInputType.visiblePassword,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'security code is empty';
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
                    if (form_key_payment.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmedOrder(
                            sender_name: sname_controller,
                            sender_phone: sphone_controller,
                            sender_email: semail_controller,
                            sender_address: saddress_controller,
                            sender_postel: spostelcode_controller,
                            recevier_name: rname_controller,
                            recevier_phone: rphone_controller,
                            recevier_email: remail_controller,
                            recevier_address: raddress_controller,
                            recevier_postel: rpostelcode_controller,
                            card_number: cardNumber_controller,
                            name_card: nameincard_controller,
                          ),
                        ),
                      );
                    }
                  },
                  labelWidget: Text("pay"),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}