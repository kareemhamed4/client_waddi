import 'package:flutter/material.dart';
import 'package:waddy_app/modules/user/make_order/payment/payment_screen.dart';
import 'package:waddy_app/shared/components/components.dart';


class OrderPackageScreen extends StatefulWidget {
  const OrderPackageScreen({super.key});

  @override
  State<OrderPackageScreen> createState() => _OrderPackageScreenState();
}

var form_key_package = GlobalKey<FormState>();

String selectedCategory = 'Name 1';
var weight_controller = TextEditingController();
var length_controller = TextEditingController();
var width_controller = TextEditingController();
var height_controller = TextEditingController();
String selectedService = 'Name 1';
var notes_controller = TextEditingController();

List<String> categorysList = [
  'Name 1',
  'Name 2',
  'Name 3',
  'Name 4',
  'Name 5',
];
List<String> servicesList = [
  'Name 1',
  'Name 2',
];

class _OrderPackageScreenState extends State<OrderPackageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 75, 84, 1),
        title: Text(
          'Package Date',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: form_key_package,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                // package
                Container(
                  child: DropdownButtonFormField(
                    value: selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                    items: categorysList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            // Icon(Icons.shopify,color: Color.fromRGBO(255, 75, 84, 1),),
                            Text(value),
                          ],
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    menuMaxHeight: 150,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.shopify,
                          color: Color.fromRGBO(255, 75, 84, 1)),
                      border: OutlineInputBorder(),
                      label: Text('Package Category'),
                    ),
                    icon: Icon(Icons.arrow_drop_down,
                        color: Color.fromRGBO(255, 75, 84, 1)),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Package is empty';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                // weight
                Row(
                  children: [
                    Expanded(
                      child: myTextFormField(
                        context: context,
                        controller: weight_controller,
                        type: TextInputType.number,
                        hint: 'Weight',
                        prefixIcon: Icon(Icons.monitor_weight_rounded),
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'weight is empty';
                          }
                          return null;
                        },
                        // suffixText: 'KG'
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 75, 84, 1),
                      ),
                      child: Center(
                        child: Text(
                          'KG',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                // length
                Row(
                  children: [
                    Expanded(
                      child: myTextFormField(
                        context: context,
                        controller: length_controller,
                        type: TextInputType.number,
                        hint: 'Length',
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
                        color: Color.fromRGBO(255, 75, 84, 1),
                      ),
                      child: Center(
                        child: Text(
                          'CM',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
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
                      child: myTextFormField(
                        context: context,
                        controller: width_controller,
                        type: TextInputType.number,
                        hint: 'Width',
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
                        color: Color.fromRGBO(255, 75, 84, 1),
                      ),
                      child: Center(
                        child: Text(
                          'CM',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
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
                      child: myTextFormField(
                        context: context,
                        controller: height_controller,
                        type: TextInputType.number,
                        hint: 'Height',
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
                        color: Color.fromRGBO(255, 75, 84, 1),
                      ),
                      child: Center(
                        child: Text(
                          'CM',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                // select serviece
                Container(
                  child: DropdownButtonFormField(
                    value: selectedService,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedService = newValue!;
                      });
                    },
                    items: servicesList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            // Icon(Icons.shopify,color: Color.fromRGBO(255, 75, 84, 1),),
                            Text(value),
                          ],
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    menuMaxHeight: 150,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.spatial_tracking,
                          color: Color.fromRGBO(255, 75, 84, 1)),
                      border: OutlineInputBorder(),
                      label: Text('Select Service'),
                    ),
                    icon: Icon(Icons.arrow_drop_down,
                        color: Color.fromRGBO(255, 75, 84, 1)),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'service is empty';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                // notes
                myTextFormField(
                  context: context,
                  controller: notes_controller,
                  type: TextInputType.name,
                  hint: 'Notes',
                ),
                SizedBox(
                  height: 30,
                ),

                myMaterialButton(
                  context: context,
                  onPressed: () {
                    if (form_key_package.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PaymentScreen(),
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
