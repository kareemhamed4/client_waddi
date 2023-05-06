import 'package:flutter/material.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "Transaction History",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildTransactionHistoryItem(context: context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTransactionHistoryItem({
    required BuildContext context,
  }) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          CircleAvatar(
            backgroundColor: myFavColorWithOpacity,
            radius: 25,
            child: Center(
                child: Image.asset(
                  "assets/icons/wallet.png",
                  height: 20,
                  width: 20,
                )),
          ),
          const SizedBox(width: 12,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Order Made !",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "You have created a new\nshipping order",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(height: 1.2),
              ),
            ],
          ),
        ],
      ),
      Text(
        "2 hours ago",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: myFavColor),
      ),
    ],
  );
}
