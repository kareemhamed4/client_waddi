import 'package:flutter/material.dart';
import 'package:waddy_app/shared/components/components.dart';

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
}
