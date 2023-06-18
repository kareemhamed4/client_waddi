import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';
import 'package:waddy_app/tsp.dart';

class UserNotificationScreen extends StatelessWidget {
  const UserNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "Notification",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  tspNearestNeighbor(
                    [
                      Location(0, 30.7883, 30.9995), //tanta
                      Location(1, 31.0122, 31.3752), //mansora
                      Location(2, 30.0232, 31.2433), //cairo
                      Location(3, 31.2285, 32.3584), //portsaeid
                    ],
                  );
                },
                child: Text(
                  "Today",
                  style:
                  Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
                ),
              ),
              const SizedBox(height: 20,),
              buildNotificationItem(
                context: context,
                size: size,
                shapePath: "assets/images/redShape.png",
                iconWidget: Icon(FluentIcons.wallet_credit_card_16_regular,color: myFavColor7,size: 30,),
                title: "Payment Successful !",
                subTitle: "You have made shipping Payment ",
              ),
              const SizedBox(height: 30,),
              Text(
                "Yesterday",
                style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 20,),
              buildNotificationItem(
                context: context,
                size: size,
                shapePath: "assets/images/yellowShape.png",
                iconWidget: Icon(FluentIcons.shopping_bag_percent_20_regular,color: myFavColor7,size: 30,),
                title: "Today’s Special Offers !",
                subTitle: "You get a special promo today! ",
              ),
              const SizedBox(height: 16,),
              buildNotificationItem(
                context: context,
                size: size,
                shapePath: "assets/images/roseShape.png",
                iconWidget: Icon(FluentIcons.form_new_20_filled,color: myFavColor7,size: 30,),
                title: "New Services Available !",
                subTitle: "Now you can search the nearby drop",
              ),
              const SizedBox(height: 30,),
              Text(
                "December 20, 2023",
                style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 20,),
              buildNotificationItem(
                context: context,
                size: size,
                shapePath: "assets/images/tentShape.png",
                iconWidget: Icon(FluentIcons.credit_card_person_20_regular,color: myFavColor7,size: 30,),
                title: "Credit Card Connected !",
                subTitle: "Credit card has been linked!",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildNotificationItem({
    required BuildContext context,
    required String shapePath,
    required Widget iconWidget,
    required String title,
    required String subTitle,
    required Size size,
  }) {
    return Container(
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
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(shapePath),
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: iconWidget,
                  ),
                ],
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 192.w,
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 192.w,
                    child: Text(
                      subTitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: myFavColor4,fontSize: 12),
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
