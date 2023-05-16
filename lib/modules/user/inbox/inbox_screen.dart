import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:waddy_app/modules/user/chat_details/chat_details_screen.dart';
import 'package:waddy_app/modules/user/inbox/cubit/cubit.dart';
import 'package:waddy_app/modules/user/inbox/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class UserInboxScreen extends StatelessWidget {
  const UserInboxScreen({Key? key}) : super(key: key);

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
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserInboxCubit, UserInboxStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserInboxCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "Inbox",
            titleColor: myFavColor2,
          ),
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: false,
                floating: true,
                backgroundColor: myFavColor7,
                expandedHeight: size.height * 100 / size.height,
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
                                height: 35,
                                bgColor: cubit.currentIndex == 0
                                    ? myFavColor
                                    : myFavColor7,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 30 / size.width,
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
                                height: 35,
                                bgColor: cubit.currentIndex == 1
                                    ? myFavColor
                                    : myFavColor7,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
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
                        itemBuilder: (context, index) => cubit.currentIndex == 0
                            ? GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  navigateTo(
                                      context, const UserChatDetailsScreen());
                                },
                                child: buildChatItem(context),
                              )
                            : buildCallItem(
                                context: context, icon: icons[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 30,
                        ),
                        itemCount: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
