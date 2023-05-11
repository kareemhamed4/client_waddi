import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/models/user/get_user_orders.dart';
import 'package:waddy_app/modules/user/my_orders/cubit/cubit.dart';
import 'package:waddy_app/modules/user/my_orders/cubit/states.dart';
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
  TextEditingController searchController = TextEditingController();

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
    return BlocConsumer<GetUserOrdersCubit, GetUserOrdersStates>(
      listener: (context, state) {},
      builder: (context, state) {
        GetUserOrdersCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "My Order",
            titleColor: myFavColor2,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                    controller: searchController,
                    onChange: (value) {
                      setState(() {
                        if (searchController.text != value) {
                          searchController.text = value;
                        }
                      });
                    },
                    radius: 10,
                    hint: "Enter Track ID Number",
                    prefixIcon: Icon(
                      Icons.search,
                      color: myFavColor4,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/icons/scan_red.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (searchController.text.isEmpty)
                  Column(
                    children: [
                      defaultTabBar(
                        context: context,
                        tabController: tabController,
                        size: size,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (tabController.index == 0)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              buildOrderSection(
                                  size: size,
                                  status: "Pending",
                                  ordersList: cubit.ordersList),
                              buildOrderSection(
                                  size: size,
                                  status: "On process",
                                  ordersList: cubit.ordersList),
                              buildOrderSection(
                                  size: size,
                                  status: "Completed",
                                  ordersList: cubit.ordersList),
                            ],
                          ),
                        ),
                      if (tabController.index == 1)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              buildOrderSection(
                                  size: size,
                                  status: "Pending",
                                  ordersList: cubit.ordersList),
                            ],
                          ),
                        ),
                      if (tabController.index == 2)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              buildOrderSection(
                                  size: size,
                                  status: "On process",
                                  ordersList: cubit.ordersList),
                            ],
                          ),
                        ),
                      if (tabController.index == 3)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              buildOrderSection(
                                  size: size,
                                  status: "Completed",
                                  ordersList: cubit.ordersList),
                            ],
                          ),
                        ),
                    ],
                  ),
                /*Padding(
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
                ),*/
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildOrderSection({
    required List<UserOrders> ordersList,
    required String status,
    required Size size,
  }) {
    List<UserOrders> filteredOrders =
        ordersList.where((order) => order.status == status).toList();

    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredOrders.length,
          itemBuilder: (context, index) {
            UserOrders order = filteredOrders[index];
            return buildOrdersItem(context: context, size: size, orders: order);
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 12,
          ),
        ),
      ],
    );
  }

  Widget buildOnProcessItem(Size size, BuildContext context) {
    return Container(
      height: size.height * 167 / 780,
      width: size.width * 330 / 360,
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

  Widget buildOrdersItem({
    required Size size,
    required BuildContext context,
    required UserOrders orders,
  }) {
    return Slidable(
      startActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: ((context) {
            context.read<GetUserOrdersCubit>().deleteOrder(orderId: orders.sId!);
          }),
          backgroundColor: myFavColor,
          icon: Icons.delete_outline,
        ),
      ]),
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: ((context) {}),
          backgroundColor: myFavColor4.withOpacity(0.4),
          icon: Icons.edit_outlined,
        ),
      ]),
      enabled: orders.status == "Pending" ? true : false,
      child: Container(
        height: size.height * 167 / 780,
        width: double.infinity,
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
                              orders.status == "Pending"
                                  ? FontAwesomeIcons.moneyCheck
                                  : orders.status == "Completed"
                                      ? FontAwesomeIcons.boxOpen
                                      : FontAwesomeIcons.truckFast,
                              color: myFavColor,
                            ),
                          ),
                        ),
                        mySizedBox(size: size, myWidth: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              orders.trackId ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(fontSize: 18, color: myFavColor8),
                            ),
                            Text(
                              orders.status == "Pending"
                                  ? "Your request is under\nreview,please wait"
                                  : orders.status == "Completed"
                                      ? "Package Received"
                                      : "On the way in delivery",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 13,
                                      color: myFavColor4,
                                      height: 1),
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
                          orders.status == "Pending"
                              ? "Pending"
                              : orders.status == "Completed"
                                  ? "Completed"
                                  : "On process",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                    if (orders.status == "On process")
                      const SizedBox(
                        width: 34,
                      ),
                    if (orders.status == "On process")
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
            height: size.height * (24 / 780),
            width: size.width * (64 / 360),
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
            height: size.height * (24 / 780),
            width: size.width * (64 / 360),
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
            height: size.height * (24 / 780),
            width: size.width * (64 / 360),
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
            height: size.height * (24 / 780),
            width: size.width * (64 / 360),
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
