import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/layout/user/cubit/cubit.dart';
import 'package:waddy_app/layout/user/layout_screen.dart';
import 'package:waddy_app/modules/user/make_order/cubit/cubit.dart';
import 'package:waddy_app/modules/user/make_order/cubit/states.dart';
import 'package:waddy_app/modules/user/make_order/payment/payment_screen.dart';
import 'package:waddy_app/modules/user/make_order/receiver/receiver_screen.dart';
import 'package:waddy_app/modules/user/make_order/sender/sender_screen.dart';
import 'package:waddy_app/shared/components/components.dart';

class ConfirmedOrder extends StatelessWidget {
  final bool isOrderEdit;
  final String? orderId;
  var sender_name = TextEditingController();
  var sender_phone = TextEditingController();
  var sender_email = TextEditingController();
  var sender_postel = TextEditingController();
  var sender_address = TextEditingController();

  var recevier_name = TextEditingController();
  var recevier_phone = TextEditingController();
  var recevier_email = TextEditingController();
  var recevier_postel = TextEditingController();
  var recevier_address = TextEditingController();

  var name_card = TextEditingController();
  var card_number = TextEditingController();

  ConfirmedOrder({
    required this.sender_name,
    required this.sender_phone,
    required this.sender_email,
    required this.sender_postel,
    required this.sender_address,
    required this.recevier_name,
    required this.recevier_phone,
    required this.recevier_email,
    required this.recevier_postel,
    required this.recevier_address,
    required this.name_card,
    required this.card_number,
    required this.isOrderEdit,
    this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MakeOrderCubit,MakeOrderStates>(
      listener: (context,state){
        if(state is MakeOrderSuccessState || state is UpdateOrderSuccessState){
          navigateToAndFinish(context, const UserLayoutScreen()).then((value){
            context.read<UserLayoutCubit>().changeBottom(1, context);
          });
        }
      },
      builder: (context,state){
        MakeOrderCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Review Summary'),
            backgroundColor: Color.fromRGBO(255, 75, 84, 1),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sender Name',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(255, 75, 84, 1),
                              ),
                            ),
                            Text(
                              '${sender_name.text}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(255, 75, 84, 1),
                              ),
                            ),
                            Text(
                              '${sender_phone.text}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(255, 75, 84, 1),
                              ),
                            ),
                            Text(
                              '${sender_email.text}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Postel Code',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(255, 75, 84, 1),
                              ),
                            ),
                            Text(
                              '${sender_postel.text}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Address',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(255, 75, 84, 1),
                              ),
                            ),
                            Text(
                              '${sender_address.text}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(16),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recevier Name',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(255, 75, 84, 1),
                              ),
                            ),
                            Text(
                              '${recevier_name.text}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(255, 75, 84, 1),
                              ),
                            ),
                            Text(
                              '${recevier_phone.text}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(255, 75, 84, 1),
                              ),
                            ),
                            Text(
                              '${recevier_email.text}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Postel Code',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(255, 75, 84, 1),
                              ),
                            ),
                            Text(
                              '${recevier_postel.text}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Address',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(255, 75, 84, 1),
                              ),
                            ),
                            Text(
                              '${recevier_address.text}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Name In Card',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(255, 75, 84, 1),
                            ),
                          ),
                          Text(
                            '${name_card.text}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Card Number',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(255, 75, 84, 1),
                            ),
                          ),
                          Text(
                            '${card_number.text}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(255, 75, 84, 1),
                            ),
                          ),
                          Text(
                            '150 EGP',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ConditionalBuilder(
                  condition: state is! MakeOrderLoadingState,
                  builder: (context) => myMaterialButton(
                    context: context,
                    onPressed: () {
                      !isOrderEdit ? cubit.makeOrder(
                        senderName: sname_controller.text,
                        senderPhone: sphone_controller.text,
                        senderEmail: semail_controller.text,
                        senderPostalCode: spostelcode_controller.text,
                        senderAddress: saddress_controller.text,
                        receivedName: rname_controller.text,
                        receivedPhone: rphone_controller.text,
                        receivedEmail: remail_controller.text,
                        receivedPostalCode: rpostelcode_controller.text,
                        receivedAddress: raddress_controller.text,
                        category: "kareem",
                        weight: 25,
                        dimension: ["25","50"],
                        services: 1,
                        paymentId: cardNumber_controller.text,
                        deliverTime: "12/12/2025",
                        notes: 'kareem hamed',
                      ) : cubit.updateOrder(
                        orderId: orderId!,
                        senderName: sname_controller.text,
                        senderPhone: sphone_controller.text,
                        senderEmail: semail_controller.text,
                        senderPostalCode: spostelcode_controller.text,
                        senderAddress: saddress_controller.text,
                        receivedName: rname_controller.text,
                        receivedPhone: rphone_controller.text,
                        receivedEmail: remail_controller.text,
                        receivedPostalCode: rpostelcode_controller.text,
                        receivedAddress: raddress_controller.text,
                        category: "kareem",
                        weight: 25,
                        dimension: ["25","50"],
                        services: 1,
                        paymentId: cardNumber_controller.text,
                        deliverTime: "12/12/2025",
                        notes: 'kareem hamed',
                      );
                    },
                    labelWidget: Text(
                      "Confirm Order",
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
              ],
            ),
          ),
        );
      },
    );
  }
}
