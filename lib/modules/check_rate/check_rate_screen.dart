import 'package:flutter/material.dart';
import 'package:waddy_app/shared/components/components.dart';

class CheckRateScreen extends StatelessWidget {
  const CheckRateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController pickUp = TextEditingController();
    TextEditingController destination = TextEditingController();
    TextEditingController dimension = TextEditingController();
    TextEditingController noPackage = TextEditingController();
    TextEditingController shipDate = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Rate'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.my_location_outlined,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: defaultTextForm(
                      controller: pickUp,
                      type: TextInputType.text,
                      text: 'Pick up location',
                      suffix: Icons.my_location,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: defaultTextForm(
                      controller: destination,
                      type: TextInputType.text,
                      text: 'Pick up location',
                      suffix: Icons.my_location,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              myDivider(),
              const Text(
                'Tell us more about your shipment',
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                'Dimension : Kg',
                style: TextStyle(color: Colors.grey),
              ),
              defaultTextForm(
                controller: dimension,
                type: TextInputType.number,
                text: 'weight',
                prefix: Icons.pages,
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                'No.of Package',
                style: TextStyle(color: Colors.grey),
              ),
              defaultTextForm(
                controller: noPackage,
                type: TextInputType.number,
                text: 'Number of package',
                prefix: Icons.pages,
              ),
              const SizedBox(
                height: 15.0,
              ),
              const Text(
                'Ship Date',
                style: TextStyle(color: Colors.grey),
              ),
              defaultTextForm(
                controller: shipDate,
                type: TextInputType.text,
                text: 'date',
                prefix: Icons.calendar_month,
              ),
              const SizedBox(
                height: 30.0,
              ),
              defaultButton(
                function: () {},
                radius: BorderRadius.circular(20.0),
                text: 'Check',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
