import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/cubit/common/cubit.dart';
import 'package:waddy_app/custom_icons_icons.dart';
import 'package:waddy_app/layout/driver/cubit/cubit.dart';
import 'package:waddy_app/layout/driver/cubit/states.dart';
import 'package:waddy_app/modules/driver/orders/cubit/cubit.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class DriverLayoutScreen extends StatelessWidget {
  const DriverLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = DriverLayoutCubit.get(context);
    return BlocConsumer<DriverLayoutCubit, DriverLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomAppBar(
            color: myFavColor5,
            shape: const CircularNotchedRectangle(),
            notchMargin: 10,
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cubit.changeBottom(0);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CustomIcons.home,
                            color: cubit.currentIndex == 0
                                ? myFavColor
                                : myFavColor4,
                          ),
                          Text(
                            "Home",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontSize: 12,
                                  color: cubit.currentIndex == 0
                                      ? myFavColor
                                      : myFavColor4,
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cubit.changeBottom(1);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CustomIcons.doc_text_inv,
                            color: cubit.currentIndex == 1
                                ? myFavColor
                                : myFavColor4,
                          ),
                          Text(
                            "Orders",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                              fontSize: 12,
                              color: cubit.currentIndex == 1
                                  ? myFavColor
                                  : myFavColor4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cubit.changeBottom(3);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CustomIcons.chat,
                            color: cubit.currentIndex == 3
                                ? myFavColor
                                : myFavColor4,
                          ),
                          Text(
                            "Inbox",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                              fontSize: 12,
                              color: cubit.currentIndex == 3
                                  ? myFavColor
                                  : myFavColor4,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cubit.changeBottom(4);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CustomIcons.user_alt,
                            color: cubit.currentIndex == 4
                                ? myFavColor
                                : myFavColor4,
                          ),
                          Text(
                            "Profile",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                              fontSize: 12,
                              color: cubit.currentIndex == 4
                                  ? myFavColor
                                  : myFavColor4,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: myFavColor,
            onPressed: () {
             MainCubit.get(context).sendEmail();
            },
            child: Icon(
              Icons.add,
              size: 35,
              color: myFavColor7,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
