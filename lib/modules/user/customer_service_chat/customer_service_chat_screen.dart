import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/layout/user/cubit/cubit.dart';
import 'package:waddy_app/layout/user/cubit/states.dart';
import 'package:waddy_app/models/common/message_model.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';
import 'package:intl/intl.dart';

class CustomerServiceChatDetailsScreen extends StatefulWidget {
  const CustomerServiceChatDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CustomerServiceChatDetailsScreen> createState() => _CustomerServiceChatDetailsScreenState();
}

class _CustomerServiceChatDetailsScreenState extends State<CustomerServiceChatDetailsScreen> {
  final TextEditingController messageController = TextEditingController();
  UserLayoutCubit? userLayoutCubit;
  @override
  void initState() {
    super.initState();
    userLayoutCubit = context.read<UserLayoutCubit>();
  }

  @override
  void dispose() {
    userLayoutCubit!.messages = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        UserLayoutCubit.get(context).getMessages(receiverId: "ekkODsmM09YBM8FggBbRw078Qfv1");
        return BlocConsumer<UserLayoutCubit, UserLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            UserLayoutCubit cubit = BlocProvider.of(context);
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 12),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.messages = [];
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_outlined,
                              color: myFavColor8,
                              size: 25,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              "Customer Service",
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: myFavColor8,
                                    fontSize: 22,
                                    height: 1,
                                  ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FluentIcons.call_16_regular,
                                color: myFavColor,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                padding: EdgeInsets.zero,
                                decoration:
                                BoxDecoration(shape: BoxShape.circle, border: Border.all(color: myFavColor2)),
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.ellipsis,
                                    color: myFavColor8,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message = cubit.messages[index];
                            if (cubit.userModelFB!.uId == message.senderId) {
                              return buildMyMessage(context: context, model: message);
                            }
                            return buildReceivedMessage(context: context, model: message);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 15,
                          ),
                          itemCount: cubit.messages.length,
                        ),
                      ),
                      buildTextFieldToSendMessage(
                        context: context,
                        cubit: cubit,
                        messageController: messageController,
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
  }

  Widget buildMyMessage({
    required BuildContext context,
    required MessageModel model,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: myFavColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 16, right: 60),
                  child: Text(
                    model.text!,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: myFavColor7,
                          fontSize: 14,
                          height: 1.3,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                child: Text(
                  DateFormat.jm().format(DateTime.parse(model.dateTime!)),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: myFavColor7,
                        fontSize: 12,
                      ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildReceivedMessage({
    required BuildContext context,
    required MessageModel model,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: myFavColor4.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 16, left: 16, right: 60),
                  child: Text(
                    model.text!,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: myFavColor8,
                          fontSize: 14,
                          height: 1.3,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                child: Text(
                  DateFormat.jm().format(DateTime.parse(model.dateTime!)),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: myFavColor8,
                        fontSize: 12,
                      ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTextFieldToSendMessage({
    required BuildContext context,
    required UserLayoutCubit cubit,
    required TextEditingController messageController,
  }) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        myTextFormField(
          context: context,
          radius: 15,
          fillColor: myFavColor4.withOpacity(0.2),
          hint: "Message..",
          controller: messageController,
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  cubit.sendMessage(
                    receiverId: "ekkODsmM09YBM8FggBbRw078Qfv1",
                    text: messageController.text,
                  );
                  messageController.clear();
                },
                child: Icon(
                  FluentIcons.send_20_regular,
                  color: myFavColor,
                  size: 26,
                ),
              ),
            ],
          ),
          prefixIcon: Icon(
            FluentIcons.image_multiple_20_filled,
            color: myFavColor4,
            size: 26,
          ),
        ),
      ],
    );
  }
}
