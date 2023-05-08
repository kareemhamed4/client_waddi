import 'package:flutter/material.dart';
import 'package:waddy_app/other_screens/component.dart';
import 'package:waddy_app/other_screens/order/confirm_order.dart';
import 'package:waddy_app/other_screens/order/recevier_data.dart';
import 'package:waddy_app/other_screens/order/senderdata.dart';


class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

var form_key_payment = GlobalKey<FormState>();

var cardNumber_controller = TextEditingController();
var nameincard_controller = TextEditingController();
var expirydate_controller = TextEditingController();
var securitycode_controller = TextEditingController();



class _PaymentState extends State<Payment> {
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
                    defaultFormField(
                        controller: cardNumber_controller,
                        type: TextInputType.number,
                        label: 'Card Number',
                        prefix: Icons.numbers_outlined,
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
                    defaultFormField(
                        controller: nameincard_controller,
                        type: TextInputType.name,
                        label: 'Name In Card',
                        prefix: Icons.abc,
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
                    defaultFormField(
                            controller: expirydate_controller, 
                            label: 'Expiry date',
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
                    defaultFormField(
                          controller: securitycode_controller, 
                          label: 'Security Code',
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
                  
                  defaultButton(
                    function: () {
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
                    text: 'pay',
                  ),
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
}