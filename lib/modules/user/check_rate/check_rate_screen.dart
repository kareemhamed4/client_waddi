import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class CheckRateScreen extends StatelessWidget {
  const CheckRateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              myMaterialButton(
                context: context,
                onPressed: () {
                  showMyBottomSheet(
                    size: size,
                    context: context,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: 35,
                              height: 4,
                              decoration: BoxDecoration(
                                color: myFavColor4,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            mySizedBox(size: size, myHeight: 20),
                            Text(
                              "Rates",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontSize: 28),
                            ),
                            mySizedBox(size: size, myHeight: 12),
                            myDivider(),
                            const SizedBox(height: 8,),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Benha train station street",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(fontSize: 16,height: 1),
                                      ),
                                      const SizedBox(height: 8,),
                                      Text(
                                        "Pick up location",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 14,color: myFavColor4),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FaIcon(FontAwesomeIcons.arrowRightArrowLeft,color: myFavColor,),
                                  ],
                                )),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Shebeen El-Koum, Menoufia",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(fontSize: 16,height: 1),
                                      ),
                                      const SizedBox(height: 8,),
                                      Text(
                                        "Package Destination",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 14,color: myFavColor4),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8,),
                            myDivider(),
                            mySizedBox(size: size, myHeight: 20),
                            Container(
                              height: 100,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: myFavColor8.withAlpha(20),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(0, 0),
                                ),
                              ]),
                              child: Card(
                                margin: EdgeInsets.zero,
                                elevation: 2,
                                color: myFavColor7,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset("assets/images/yellowShape.png"),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 9),
                                                child: FaIcon(FontAwesomeIcons.boxOpen,color: myFavColor7,),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 24,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Regular",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(fontSize: 20),
                                              ),
                                              Text(
                                                "3 - 4 days",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(color: myFavColor4),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "25 EGP",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: myFavColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            mySizedBox(size: size, myHeight: 26),
                            Container(
                              height: 100,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: myFavColor8.withAlpha(20),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(0, 0),
                                ),
                              ]),
                              child: Card(
                                margin: EdgeInsets.zero,
                                elevation: 0,
                                color: myFavColor7,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset("assets/images/roseShape.png"),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 6),
                                                child: FaIcon(FontAwesomeIcons.cartShopping,color: myFavColor7,),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 24,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Express",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(fontSize: 20),
                                              ),
                                              Text(
                                                "1 - 2 days",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(color: myFavColor4),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "48 EGP",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: myFavColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            mySizedBox(size: size, myHeight: 35),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                height: 50,
                labelWidget: Text(
                  "Check",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
