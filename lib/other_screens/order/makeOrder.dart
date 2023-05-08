import 'package:flutter/material.dart';
import 'package:waddy_app/other_screens/component.dart';
import 'package:waddy_app/other_screens/order/confirm_order.dart';


class ordertest extends StatefulWidget {
  const ordertest({super.key});

  @override
  State<ordertest> createState() => _ordertestState();
}

var form_key = GlobalKey<FormState>();
var sname_controller = TextEditingController();
var sphone_controller = TextEditingController();
var semail_controller = TextEditingController();
var spostelcode_controller = TextEditingController();
var saddress_controller = TextEditingController();

var rname_controller = TextEditingController();
var rphone_controller = TextEditingController();
var remail_controller = TextEditingController();
var rpostelcode_controller = TextEditingController();
var raddress_controller = TextEditingController();

var package_controller = TextEditingController();
var weight_controller = TextEditingController();
var length_controller = TextEditingController();
var width_controller = TextEditingController();
var height_controller = TextEditingController();
var service_controller = TextEditingController();
var notes_controller = TextEditingController();

var cardNumber_controller = TextEditingController();
var nameincard_controller = TextEditingController();
var expirydate_controller = TextEditingController();
var securitycode_controller = TextEditingController();


class _ordertestState extends State<ordertest> {
  @override
  Widget build(BuildContext context) {
    var key2;
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
// ----------------------------sender data---------------------------------

                              Center(
                                child: Text(
                                  'Sender Data ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              // sender name
                              defaultFormField(
                                controller: sname_controller,
                                type: TextInputType.name,
                                label: 'Sender Name',
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
                              // sender phone
                              defaultFormField(
                                controller: sphone_controller,
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
                              // sender email
                              defaultFormField(
                                controller: semail_controller,
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
                                controller: spostelcode_controller,
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
                              // sender address
                              defaultFormField(
                                controller: saddress_controller,
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
                              SizedBox(height: 20,),
                              
// --------------------------recevier data ------------------------------

                              Center(
                                child: Text(
                                  'Recevier Data ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.black,
                              ),
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
                              SizedBox(height: 20,),
                              
// --------------------------package ------------------------------

                            Center(
                                child: Text(
                                  'Package Category ',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            SizedBox(height: 10,),
                            Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.black,
                              ),
                            SizedBox(
                                height: 15,
                              ),
                            // package
                            defaultFormField(
                                controller: package_controller,
                                type: TextInputType.name,
                                label: 'Package Category',
                                prefix: Icons.playlist_add_check,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Package is empty';
                                  }
                                  return null;
                                },
                              ),
                            SizedBox(
                                height: 15,
                              ),
                            // weight
                            Row(
                                children: [
                                  Expanded(
                                    child: defaultFormField(
                                        controller: weight_controller,
                                        type: TextInputType.number,
                                        label: 'Weight',
                                        prefix: Icons.monitor_weight_rounded,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'weight is empty';
                                          }
                                          return null;
                                        },
                                      ),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color:Color.fromRGBO(255, 75, 84, 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'KG',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(
                                height: 15,
                              ),
                            // dimension
                            Text(
                              'Dimension',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(
                                height: 15,
                              ),
                            // length
                            Row(
                                children: [
                                  Expanded(
                                    child: defaultFormField(
                                        controller: length_controller,
                                        type: TextInputType.number,
                                        label: 'Length',
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'length is empty';
                                          }
                                          return null;
                                        },
                                      ),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color:Color.fromRGBO(255, 75, 84, 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'CM',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(
                                height: 15,
                              ),
                            // width
                            Row(
                                children: [
                                  Expanded(
                                    child: defaultFormField(
                                        controller: width_controller,
                                        type: TextInputType.number,
                                        label: 'Width',
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'width is empty';
                                          }
                                          return null;
                                        },
                                      ),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color:Color.fromRGBO(255, 75, 84, 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'CM',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(
                                height: 15,
                              ),
                            // height
                            Row(
                                children: [
                                  Expanded(
                                    child: defaultFormField(
                                        controller: height_controller,
                                        type: TextInputType.number,
                                        label: 'Height',
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'height is empty';
                                          }
                                          return null;
                                        },
                                      ),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color:Color.fromRGBO(255, 75, 84, 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'CM',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(
                                height: 25,
                              ),
                            // select serviece
                            defaultFormField(
                                controller: service_controller,
                                type: TextInputType.name,
                                label: 'Select Service',
                                prefix: Icons.spatial_tracking,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'service is empty';
                                  }
                                  return null;
                                },
                              ),
                            SizedBox(
                                height: 15,
                              ),
                            // notes
                            defaultFormField(
                                controller: notes_controller,
                                type: TextInputType.name,
                                label: 'Notes',
                                
                              ),
                            SizedBox(
                                height: 15,
                              ),
                            
                                               
// --------------------------payment ------------------------------

                            Center(
                                child: Text(
                                  'Payment',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            SizedBox(height: 10,),
                            Container(
                                width: double.infinity,
                                height: 1,
                                color: Colors.black,
                              ),
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
                                if (form_key.currentState!.validate()) {
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
                          SizedBox(
                              height: 30,
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
              key: key2,
              child: Column(
                children: [
                  Text('2'),
                  defaultButton(
                      function: () {
                        print('object2');
                      },
                      text: 'test2'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
