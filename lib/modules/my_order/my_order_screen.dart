import 'package:flutter/material.dart';

class ShippingMyOrderScreen extends StatelessWidget {
  const ShippingMyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'My Order Screen',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
