import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/modules/driver/view_on_map/view_on_map_screen.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class DriverOrdersScreen extends StatelessWidget {
  const DriverOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "Orders",
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: myTextFormField(
                context: context,
                hint: "Search",
                radius: 10,
                prefixIcon: Icon(
                  Icons.search,
                  color: myFavColor4,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildProcessingOrderItem(context: context, size: size),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: 1,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildFinishedOrderItem(size: size, context: context),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildProcessingOrderItem({
    required Size size,
    required BuildContext context,
  }) {
    return Container(
      height: size.height * 167 / size.height,
      width: size.width * 330 / size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: myFavColor8.withAlpha(20),
              spreadRadius: 4,
              blurRadius: 7,
              offset: const Offset(0, 0)),
        ],
      ),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: myFavColor7,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: myFavColorWithOpacity,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.boxOpen,
                        color: myFavColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "SK26273729",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(fontSize: 18, color: myFavColor8),
                      ),
                      Text(
                        "On the way in delivery",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 14, color: myFavColor4),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              myDivider(),
              myMaterialButton(
                context: context,
                onPressed: () {
                  navigateTo(context, const DriverViewOnMapScreen());
                },
                height: 35,
                radius: 20,
                labelWidget: Text(
                  "View on map",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: myFavColor),
                ),
                bgColor: myFavColor7,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildFinishedOrderItem({
    required Size size,
    required BuildContext context,
  }) {
    return Container(
      height: size.height * 106 / size.height,
      width: size.width * 330 / size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: myFavColor8.withAlpha(20),
              spreadRadius: 4,
              blurRadius: 7,
              offset: const Offset(0, 0)),
        ],
      ),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: myFavColor7,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: myFavColorWithOpacity,
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.truckPickup,
                    color: myFavColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SK26273729",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontSize: 18, color: myFavColor8),
                  ),
                  Text(
                    "On the way in delivery",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 14, color: myFavColor4),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
