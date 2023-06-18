import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waddy_app/models/driver/delegate_get_all_orders.dart';
import 'package:waddy_app/modules/driver/orders/cubit/cubit.dart';
import 'package:waddy_app/modules/driver/orders/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int index;
  final String orderId;
  const OrderDetailsScreen({Key? key, required this.index, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverOrdersCubit, DriverOrdersStates>(
      listener: (context, state) {
        if (state is GetOrdersRelatedToDelegateSuccessState) {
          Navigator.pop(context);
          buildSuccessToast(
            context: context,
            title: "Done!",
            description: "Order added to your orders Successfully!",
          );
        }
        if (state is DelegateTakeOrderErrorState) {
          Navigator.pop(context);
          buildErrorToast(
            context: context,
            title: "Oops!",
            description: state.error,
          );
        }
      },
      builder: (context, state) {
        DriverOrdersCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Order Details",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(color: myFavColor8, fontSize: 28),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                buildOrderDetailsBody(context: context, model: cubit.delegateOrders!),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Additional info such as phone number for sender and receiver are exist and we will provide you by them only if you accept this order.",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: myFavColor4, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                ConditionalBuilder(
                  condition: state is! DelegateTakeOrderLoadingState,
                  builder: (context) => myMaterialButton(
                    context: context,
                    onPressed: () {
                      cubit.delegateTakeOrder(orderId: orderId);
                    },
                    labelWidget: Text(
                      "Take This Order",
                      style: Theme.of(context).textTheme.labelLarge,
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
                SizedBox(height: 20.h)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildOrderDetailsBody({
    required BuildContext context,
    required DelegateOrders model,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCardForDetails(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sender name",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4, fontSize: 14),
                    ),
                    Text(
                      model.orders![index].senderName!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sender Postel code",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4, fontSize: 14),
                    ),
                    Text(
                      model.orders![index].senderPostalCode!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sender Address",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4, fontSize: 14),
                    ),
                    Text(
                      model.orders![index].senderAddress!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 22,
        ),
        buildCardForDetails(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Receiver name",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4, fontSize: 14),
                    ),
                    Text(
                      model.orders![index].receivedName!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Receiver Postel code",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4, fontSize: 14),
                    ),
                    Text(
                      model.orders![index].receivedPostalCode!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Receiver Address",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4, fontSize: 14),
                    ),
                    Text(
                      model.orders![index].receivedAddress!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 22,
        ),
        buildCardForDetails(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Package Category",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4, fontSize: 14),
                    ),
                    Text(
                      model.orders![index].category!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Package weight",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4, fontSize: 14),
                    ),
                    Text(
                      "${model.orders![index].weight} KG",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Package Dimension",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor4, fontSize: 14),
                    ),
                    Text(
                      "Length: ${model.orders![index].dimension![0]} cm\nWidth: ${model.orders![index].dimension![1]} cm\nHeight: ${model.orders![index].dimension![2]} cm",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget buildCardForDetails({
    required Widget child,
  }) =>
      Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: myFavColor7,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: myFavColor8.withAlpha(20), spreadRadius: 1, blurRadius: 2, offset: const Offset(0, 0)),
          ],
        ),
        child: child,
      );
}
