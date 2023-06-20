import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/models/driver/delegate_get_all_orders.dart';
import 'package:waddy_app/models/driver/delegate_get_his_orders_model.dart';
import 'package:waddy_app/modules/driver/order_details/order_details_secreen.dart';
import 'package:waddy_app/modules/driver/orders/cubit/cubit.dart';
import 'package:waddy_app/modules/driver/orders/cubit/states.dart';
import 'package:waddy_app/modules/driver/view_on_map/view_on_map_screen.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class DriverOrdersScreen extends StatefulWidget {
  const DriverOrdersScreen({Key? key}) : super(key: key);

  @override
  State<DriverOrdersScreen> createState() => _DriverOrdersScreenState();
}

class _DriverOrdersScreenState extends State<DriverOrdersScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    context.read<DriverOrdersCubit>().tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverOrdersCubit, DriverOrdersStates>(
      listener: (context, state) {
        if (state is GetDriverOrderLoadingState) {
          showProgressIndicator(context);
        }
        if (state is GetDriverOrderErrorState) {
          Navigator.pop(context);
          buildErrorToast(context: context, title: "Oops", description: state.error);
        }
      },
      builder: (context, state) {
        DriverOrdersCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "Orders",
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
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
                SizedBox(height: 12.h),
                TabBar(
                  controller: cubit.tabController,
                  onTap: (index) {
                    cubit.changeFirstTabBarIndex(index);
                    cubit.currentIndexForTabBar = index;
                  },
                  indicatorWeight: 3,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 16),
                  tabs: [
                    Tab(
                      height: 40,
                      child: Text(
                        "My Orders",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: cubit.currentIndexForTabBar == 0 ? myFavColor : myFavColor8),
                      ),
                    ),
                    Tab(
                      height: 40,
                      child: Text(
                        "All Orders",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: cubit.currentIndexForTabBar == 1 ? myFavColor : myFavColor8),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 26.h),
                if (cubit.currentIndexForTabBar == 0 &&
                    cubit.delegateGetHisOrders != null &&
                    cubit.delegateGetHisOrders!.orders!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildOrderRelatedToDelegateItem(
                        context: context,
                        index: index,
                        model: cubit.delegateGetHisOrders!,
                        cubit: cubit,
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                      itemCount: cubit.delegateGetHisOrders!.orders!.length,
                    ),
                  ),
                if (cubit.currentIndexForTabBar == 0 &&
                    cubit.delegateGetHisOrders != null &&
                    cubit.delegateGetHisOrders!.orders!.isEmpty)
                  Center(
                    child: Text(
                      "You don't have any orders yet!",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13.sp, color: myFavColor4),
                    ),
                  ),
                if (cubit.currentIndexForTabBar == 0 && cubit.delegateGetHisOrders == null)
                  const Center(child: CircularProgressIndicator()),
                if (cubit.currentIndexForTabBar == 1 &&
                    cubit.delegateOrders != null &&
                    cubit.delegateOrders!.orders!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: buildDelegateOrderItem(context: context, index: index, model: cubit.delegateOrders!),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: cubit.delegateOrders!.orders!.length,
                    ),
                  ),
                if (cubit.currentIndexForTabBar == 1 &&
                    cubit.delegateOrders != null &&
                    cubit.delegateOrders!.orders!.isEmpty)
                  Center(
                    child: Text(
                      "No Orders available now",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13.sp, color: myFavColor4),
                    ),
                  ),
                if (cubit.currentIndexForTabBar == 1 && cubit.delegateOrders == null)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        );
      },
    );
  }

  Container buildOrderRelatedToDelegateItem({
    required BuildContext context,
    required DriverOrdersCubit cubit,
    required DelegateGetHisOrders model,
    required int index,
  }) {
    return Container(
      width: 330.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: myFavColor8.withAlpha(20), spreadRadius: 4, blurRadius: 7, offset: const Offset(0, 0)),
        ],
      ),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: myFavColor7,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
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
                      width: 27,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          model.orders![index].trackId!,
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 18.sp, color: myFavColor8),
                        ),
                        Text(
                          model.orders![index].notes!,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13.sp, color: myFavColor4),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 17.h),
              myDivider(),
              SizedBox(height: 13.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: myMaterialButton(
                  context: context,
                  onPressed: () {
                    cubit
                        .delegateGetOrderById(
                      orderId: model.orders![index].sId!,
                    )
                        .then((value) {
                      Navigator.pop(context);
                      navigateTo(
                        context,
                        DriverViewOnMapScreen(
                          uId: cubit.emailToUidMap[model.orders![index].receivedEmail!],
                          chatUserName: cubit.delegateOrderDetails!.order!.receivedName!,
                        ),
                      );
                    });
                  },
                  height: 35.h,
                  radius: 20,
                  labelWidget: Text(
                    "View on map",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor),
                  ),
                  bgColor: myFavColor7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDelegateOrderItem({
    required BuildContext context,
    required DelegateOrders model,
    required int index,
  }) {
    return Container(
      width: 330.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: myFavColor8.withAlpha(20), spreadRadius: 4, blurRadius: 7, offset: const Offset(0, 0)),
        ],
      ),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: myFavColor7,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 142.w,
                              child: Text(
                                model.orders![index].senderName!,
                                style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 18, color: myFavColor8),
                              ),
                            ),
                            SizedBox(
                              width: 142.w,
                              child: Text(
                                "${model.orders![index].category} - ${model.orders![index].weight} KG",
                                style:
                                    Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14, color: myFavColor4),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.circleDot,
                                          color: myFavColor,
                                          size: 15,
                                        ),
                                        Container(
                                          width: 1,
                                          height: 20,
                                          color: myFavColor4,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      model.orders![index].senderAddress!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 12, color: myFavColor4),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.locationPin,
                                        color: myFavColor,
                                        size: 15,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        model.orders![index].receivedAddress!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 12, color: myFavColor4),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: myMaterialButton(
                      context: context,
                      height: 30,
                      radius: 5,
                      bgColor: rose,
                      labelWidget: Text("Details",
                          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 15.sp, color: myFavColor)),
                      onPressed: () {
                        navigateTo(context, OrderDetailsScreen(index: index, orderId: model.orders![index].sId!));
                      },
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
}
