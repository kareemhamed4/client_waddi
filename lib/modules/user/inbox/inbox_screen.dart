import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:waddy_app/layout/user/cubit/cubit.dart';
import 'package:waddy_app/layout/user/cubit/states.dart';
import 'package:waddy_app/modules/user/inbox/cubit/cubit.dart';
import 'package:waddy_app/modules/user/inbox/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/handle_refresh.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class UserInboxScreen extends StatefulWidget {
  const UserInboxScreen({Key? key}) : super(key: key);

  @override
  State<UserInboxScreen> createState() => _UserInboxScreenState();
}

class _UserInboxScreenState extends State<UserInboxScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();
  @override
  void initState(){

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> icons = [
      Row(
        children: [
          const Icon(
            FluentIcons.call_outbound_16_regular,
            color: Colors.green,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "Outgoing | Dec 25, 2023",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: myFavColor4, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      Row(
        children: [
          const Icon(
            FluentIcons.call_dismiss_16_filled,
            color: Colors.red,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "Missed | Feb 08, 2023",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: myFavColor4, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      Row(
        children: [
          Icon(
            FluentIcons.call_inbound_16_regular,
            color: HexColor("#4200f6"),
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "Incoming | Dec 20, 2023",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: myFavColor4, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      Row(
        children: [
          const Icon(
            FluentIcons.call_outbound_16_regular,
            color: Colors.green,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "Outgoing | Dec 25, 2023",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: myFavColor4, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      Row(
        children: [
          const Icon(
            FluentIcons.call_dismiss_16_filled,
            color: Colors.red,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "Missed | Feb 08, 2023",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: myFavColor4, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      Row(
        children: [
          Icon(
            FluentIcons.call_inbound_16_regular,
            color: HexColor("#4200f6"),
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "Incoming | Dec 20, 2023",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: myFavColor4, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      Row(
        children: [
          const Icon(
            FluentIcons.call_outbound_16_regular,
            color: Colors.green,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "Outgoing | Dec 25, 2023",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: myFavColor4, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      Row(
        children: [
          const Icon(
            FluentIcons.call_dismiss_16_filled,
            color: Colors.red,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "Missed | Feb 08, 2023",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: myFavColor4, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      Row(
        children: [
          Icon(
            FluentIcons.call_inbound_16_regular,
            color: HexColor("#4200f6"),
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "Incoming | Dec 20, 2023",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: myFavColor4, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      Row(
        children: [
          const Icon(
            FluentIcons.call_outbound_16_regular,
            color: Colors.green,
            size: 20,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "Outgoing | Dec 25, 2023",
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: myFavColor4, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ];
    return Builder(
      builder: (BuildContext context) {
        UserLayoutCubit.get(context).getDelegatesWithChat();
        return BlocConsumer<UserInboxCubit, UserInboxStates>(
          listener: (context, state) {},
          builder: (context, state) {
            UserInboxCubit cubit = BlocProvider.of(context);
            return BlocConsumer<UserLayoutCubit, UserLayoutStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return Scaffold(
                  key: _scaffoldKey,
                  appBar: defaultAppBar(
                    context: context,
                    title: "Inbox",
                    titleColor: myFavColor2,
                  ),
                  body: LiquidPullToRefresh(
                    key: _refreshIndicatorKey,
                    onRefresh: () {
                      return MyReusableComponent.performTask(
                        context: context,
                        somethingToDo: () async {
                          await UserLayoutCubit.get(context).getDelegatesWithChat();
                        },
                        refreshIndicatorKey: _refreshIndicatorKey,
                      );
                    },
                    color: myFavColor,
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll){
                        overScroll.disallowIndicator();
                        return true;
                      },
                      child: CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                            pinned: false,
                            floating: true,
                            backgroundColor: myFavColor7,
                            expandedHeight: 100.h,
                            flexibleSpace: FlexibleSpaceBar(
                              background: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: myMaterialButton(
                                            context: context,
                                            onPressed: () {
                                              cubit.changeInboxIndex(0);
                                              UserLayoutCubit.get(context).getAllDelegatesFromFB();
                                            },
                                            labelWidget: Text(
                                              "Chats",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: cubit.currentIndex == 0
                                                          ? myFavColor7
                                                          : myFavColor),
                                            ),
                                            height: 35.h,
                                            bgColor: cubit.currentIndex == 0
                                                ? myFavColor
                                                : myFavColor7,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        Expanded(
                                          child: myMaterialButton(
                                            context: context,
                                            onPressed: () {
                                              cubit.changeInboxIndex(1);
                                            },
                                            labelWidget: Text(
                                              "Calls",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: cubit.currentIndex == 1
                                                          ? myFavColor7
                                                          : myFavColor),
                                            ),
                                            height: 35.h,
                                            bgColor: cubit.currentIndex == 1
                                                ? myFavColor
                                                : myFavColor7,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 25.h),
                                    myDivider(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        cubit.currentIndex == 0
                                            ? buildChatItem(
                                                context: context,
                                                modelFB:
                                                    UserLayoutCubit.get(context)
                                                        .delegatesWithChat[index],
                                              )
                                            : buildCallItem(
                                                context: context,
                                                icon: icons[index]),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      height: 30,
                                    ),
                                    itemCount:
                                        UserLayoutCubit.get(context).delegatesWithChat.length,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
