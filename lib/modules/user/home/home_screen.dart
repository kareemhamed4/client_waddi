import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/layout/user/cubit/cubit.dart';
import 'package:waddy_app/layout/user/cubit/states.dart';
import 'package:waddy_app/modules/user/check_rate/check_rate_screen.dart';
import 'package:waddy_app/modules/user/help_center/help_center.dart';
import 'package:waddy_app/modules/user/new_make_order/sender_data_screen.dart';
import 'package:waddy_app/modules/user/notification/notification_screen.dart';
import 'package:waddy_app/modules/user/search/search_page.dart';
import 'package:waddy_app/modules/user/transaction_history/transaction_history_screen.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String fName;
    String lName;
    return BlocConsumer<UserLayoutCubit, UserLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = UserLayoutCubit.get(context).userInfo;
        fName = model != null ? model.firstName! : " ";
        lName = model != null ? model.lastName! : " ";
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  mySizedBox(size: size, myHeight: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if(UserLayoutCubit.get(context).userModelFB != null)
                            CircleAvatar(
                            radius: 30,
                            backgroundImage:
                            NetworkImage(UserLayoutCubit.get(context).userModelFB!.image!),
                          ),
                          if(UserLayoutCubit.get(context).userModelFB == null)
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: rose
                            ),
                          const SizedBox(
                            width: 14,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Good Morning",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: myFavColor4,
                                          fontSize: 20,
                                        ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: FaIcon(
                                      FontAwesomeIcons.handHoldingHeart,
                                      color: myFavColor,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "$fName $lName",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: myFavColor2,
                                      fontSize: 20,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          navigateTo(context, const UserNotificationScreen());
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: myFavColor4.withOpacity(0.4)),
                          ),
                          child: Center(
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Icon(
                                  Icons.notifications_none_outlined,
                                  color: myFavColor8.withOpacity(0.7),
                                  size: 20,
                                ),
                                CircleAvatar(
                                  radius: 3,
                                  backgroundColor: myFavColor,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  mySizedBox(size: size, myHeight: 38),
                  GestureDetector(
                    onTap: () {
                      navigateTo(
                        context,
                        const SearchScreen(),
                      );
                    },
                    child: myTextFormField(
                      context: context,
                      isEnabled: false,
                      radius: 10,
                      hint: "Enter Track Number",
                      prefixIcon: Icon(
                        Icons.search,
                        color: myFavColor4,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/icons/scan_grey.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 57),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            navigateTo(
                              context,
                              const SenderDataScreen(),
                            );
                          },
                          child: Container(
                            width: size.width * 150 / size.width,
                            height: size.height * 100 / size.height,
                            decoration: BoxDecoration(
                              color: myFavColor7,
                              border: Border.all(
                                color: myFavColor,
                              ),
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: myFavColorWithOpacity,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: myFavColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Center(
                                        child: FaIcon(
                                      FontAwesomeIcons.pen,
                                      color: myFavColor7,
                                      size: 10,
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "Make Order",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        fontSize: 20,
                                        color: myFavColor8,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      mySizedBox(size: size, myWidth: 30),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            navigateTo(context, CheckRateScreen());
                          },
                          child: Container(
                            width: size.width * 150 / size.width,
                            height: size.height * 100 / size.height,
                            decoration: BoxDecoration(
                              color: myFavColor7,
                              border: Border.all(
                                color: myFavColor,
                              ),
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: myFavColorWithOpacity,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: myFavColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Center(
                                        child: FaIcon(
                                      FontAwesomeIcons.dollarSign,
                                      color: myFavColor7,
                                      size: 10,
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "Check Rate",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        fontSize: 20,
                                        color: myFavColor8,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  mySizedBox(size: size, myHeight: 35),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            navigateTo(context, const SizedBox());
                          },
                          child: Container(
                            width: size.width * 150 / size.width,
                            height: size.height * 100 / size.height,
                            decoration: BoxDecoration(
                              color: myFavColor7,
                              border: Border.all(
                                color: myFavColor,
                              ),
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: myFavColorWithOpacity,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: myFavColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Image.asset(
                                          "assets/icons/delivery.png",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "Our Services",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        fontSize: 20,
                                        color: myFavColor8,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      mySizedBox(size: size, myWidth: 30),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            navigateTo(context, const HelpCenterScreen());
                          },
                          child: Container(
                            width: size.width * 150 / size.width,
                            height: size.height * 100 / size.height,
                            decoration: BoxDecoration(
                              color: myFavColor7,
                              border: Border.all(
                                color: myFavColor,
                              ),
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: myFavColorWithOpacity,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: myFavColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: Center(
                                        child: FaIcon(
                                      FontAwesomeIcons.info,
                                      color: myFavColor7,
                                      size: 12,
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "Help Center",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontSize: 20, color: myFavColor8),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  mySizedBox(size: size, myHeight: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transaction History",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: myFavColor8, fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          navigateTo(context, const TransactionHistory());
                        },
                        child: Text(
                          "See All",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: myFavColor, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  mySizedBox(size: size, myHeight: 10),
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildTransactionHistoryItem(context: context),
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: myDivider(),
                      ),
                      itemCount: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
