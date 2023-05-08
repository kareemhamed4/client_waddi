import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/modules/user/tracking/tracking_screen.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class UserMyOrderScreen extends StatefulWidget {
  const UserMyOrderScreen({Key? key}) : super(key: key);

  @override
  State<UserMyOrderScreen> createState() => _UserMyOrderScreenState();
}

class _UserMyOrderScreenState extends State<UserMyOrderScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 4);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    tabController.removeListener(_handleTabSelection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "My Order",
        titleColor: myFavColor2,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: myTextFormField(
                context: context,
                radius: 10,
                hint: "Enter Track ID Number",
                prefixIcon: Icon(
                  Icons.search,
                  color: myFavColor4,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/icons/scan_red.png",width: 20,height: 20,),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            defaultTabBar(
              context: context,
              tabController: tabController,
              size: size,
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
                    buildOnProcessItem(size, context),
                separatorBuilder: (context, index) =>
                const SizedBox(height: 20),
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
                    buildCompletedOrdersItem(size: size, context: context),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemCount: 7,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnProcessItem(Size size, BuildContext context) {
    return Container(
      height: size.height * 167/780,
      width: size.width * 330/360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: myFavColor8.withAlpha(20),
              spreadRadius: 2,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: myFavColorWithOpacity,
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16))),
                        child: Center(
                            child: FaIcon(
                          FontAwesomeIcons.boxOpen,
                          color: myFavColor,
                        )),
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
                  Container(
                    width: 60,
                    height: 15,
                    decoration: BoxDecoration(
                      color: myFavColorWithOpacity,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "On process",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: myFavColor, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              myDivider(),
              Row(
                children: [
                  Expanded(
                    child: myMaterialButton(
                      context: context,
                      onPressed: () {},
                      height: 35,
                      radius: 20,
                      labelWidget: Text(
                        "View E-Receipt",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: myFavColor),
                      ),
                      bgColor: myFavColor7,
                    ),
                  ),
                  const SizedBox(
                    width: 34,
                  ),
                  Expanded(
                    child: myMaterialButton(
                      context: context,
                      onPressed: () {
                        navigateTo(context, const TrackingScreen());
                      },
                      height: 35,
                      radius: 20,
                      labelWidget: Text(
                        "TracK",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: myFavColor7),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildCompletedOrdersItem({
    required Size size,
    required BuildContext context,
  }) {
    return Container(
      height: size.height * 167 / 780,
      width: size.width * 330 / 360,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            FontAwesomeIcons.truckFast,
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
                            "SK38372957",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(fontSize: 18, color: myFavColor8),
                          ),
                          Text(
                            "Package received",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 14, color: myFavColor4),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 60,
                    height: 15,
                    decoration: BoxDecoration(
                      color: myFavColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Completed",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: myFavColor7,
                              fontSize: 12,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              myDivider(),
              myMaterialButton(
                context: context,
                onPressed: () {},
                height: 35,
                radius: 20,
                labelWidget: Text(
                  "View E-Receipt",
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

  PreferredSizeWidget defaultTabBar({
    required BuildContext context,
    required TabController tabController,
    required Size size,
  }) =>
      TabBar(
        padding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        controller: tabController,
        physics: const BouncingScrollPhysics(),
        indicatorColor: Colors.transparent,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        isScrollable: true,
        tabs: [
          Container(
            height: size.height * (24/780),
            width: size.width * (64/360),
            decoration: BoxDecoration(
              color: tabController.index == 0 ? myFavColor : myFavColor7,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                color: myFavColor,
              ),
            ),
            child: Tab(
              child: Text(
                "All",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: tabController.index == 0 ? myFavColor7 : myFavColor,
                    fontSize: 12),
              ),
            ),
          ),
          Container(
            height: size.height * (24/780),
            width: size.width * (64/360),
            decoration: BoxDecoration(
              color: tabController.index == 1 ? myFavColor : myFavColor7,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                color: myFavColor,
              ),
            ),
            child: Tab(
              child: Text(
                "Pending",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: tabController.index == 1 ? myFavColor7 : myFavColor,
                    fontSize: 12),
              ),
            ),
          ),
          Container(
            height: size.height * (24/780),
            width: size.width * (64/360),
            decoration: BoxDecoration(
              color: tabController.index == 2 ? myFavColor : myFavColor7,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                color: myFavColor,
              ),
            ),
            child: Tab(
              child: Text(
                "On Process",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: tabController.index == 2 ? myFavColor7 : myFavColor,
                    fontSize: 12),
              ),
            ),
          ),
          Container(
            height: size.height * (24/780),
            width: size.width * (64/360),
            decoration: BoxDecoration(
              color: tabController.index == 3 ? myFavColor : myFavColor7,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                color: myFavColor,
              ),
            ),
            child: Tab(
              child: Text(
                "Delivered",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: tabController.index == 3 ? myFavColor7 : myFavColor,
                    fontSize: 12),
              ),
            ),
          ),
        ],
      );
}
