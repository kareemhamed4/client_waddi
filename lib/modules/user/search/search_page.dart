import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/models/user/get_user_orders.dart';
import 'package:waddy_app/modules/user/my_orders/cubit/cubit.dart';
import 'package:waddy_app/modules/user/my_orders/cubit/states.dart';
import 'package:waddy_app/modules/user/tracking/tracking_screen.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<GetUserOrdersCubit,GetUserOrdersStates>(
      listener: (context,state){},
      builder: (context,state){
        GetUserOrdersCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                SystemChannels.textInput
                    .invokeMethod('TextInput.hide')
                    .then((value) {
                  Timer(const Duration(milliseconds: 250), () {
                    Navigator.pop(context);
                  });
                });
              },
              child: const Icon(
                Icons.arrow_back_outlined,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  myTextFormField(
                    context: context,
                    onChange: (value) {
                      setState(() {
                        cubit.clearSearchedOrderDetails();
                        if (searchController.text != value) {
                          searchController.text = value;
                        }
                      });
                    },
                    onSubmit: (value) {
                      cubit.getOrdersByTrackId(trackId: value);
                    },
                    radius: 10,
                    controller: searchController,
                    fillColor: myFavColorWithOpacity,
                    hint: "Enter Track Number",
                    hintColor: myFavColor5,
                    prefixIcon: Icon(
                      Icons.search,
                      color: myFavColor,
                    ),
                    onTap: () {},
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/icons/scan_red.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                  if (searchController.text.isNotEmpty && cubit.searchedOrderDetails != null)
                    Column(
                      children: [
                        mySizedBox(size: size,myHeight: 32),
                        buildResultsForRow(context:context,trackId: searchController.text),
                        mySizedBox(size: size,myHeight: 24),
                        buildSearchedOrderItem(
                          context: context,
                          size: size,
                          orders: cubit.searchedOrderDetails!,
                        ),
                      ],
                    ),
                  if (searchController.text.isNotEmpty && cubit.searchedOrderDetails == null)
                    Column(
                      children: [
                        mySizedBox(size: size,myHeight: 32),
                        buildResultsForRow(trackId: searchController.text, context: context),
                        buildNoItemFoundScreen(context: context,size: size),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSearchedOrderItem({
    required Size size,
    required BuildContext context,
    required UserOrders orders,
  }) {
    return Slidable(
      startActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: ((context) {
            context
                .read<GetUserOrdersCubit>()
                .deleteOrder(orderId: orders.sId!);
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

  Widget buildNoItemFoundScreen({
    required Size size,
    required BuildContext context,
  })=> Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      mySizedBox(size: size,myHeight: 30),
      Image.asset("assets/images/noItemFound.png"),
      mySizedBox(size: size,myHeight: 27),
      Text("Not Found",style: Theme.of(context).textTheme.labelLarge!.copyWith(color: myFavColor8,fontSize: 24),),
      Text("The code you entered cannot be found\nPlease check the code again or search with\nanother code.",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: myFavColor4,fontSize: 16,height: 1.2),textAlign: TextAlign.center,),
    ],
  );

  Widget buildResultsForRow({
    required String trackId,
    required BuildContext context,
  })=>Row(
    children: [
      Text("Results for \"",style: Theme.of(context).textTheme.labelLarge!.copyWith(color: myFavColor8,fontSize: 20),),
      Text(trackId,style: Theme.of(context).textTheme.labelLarge!.copyWith(color: myFavColor,fontSize: 20),),
      Text("\"",style: Theme.of(context).textTheme.labelLarge!.copyWith(color: myFavColor8,fontSize: 20),),
    ],
  );
}
