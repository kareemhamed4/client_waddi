import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class DriverChatDetailsScreen extends StatelessWidget {
  const DriverChatDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top:37,left:16,right:16,bottom: 8),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
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
                          Text(
                            "Ali Mohamed",
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: myFavColor8, fontSize: 28, height: 1),
                          ),
                        ],
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
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: myFavColor2)),
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
                  mySizedBox(size: size, myHeight: 30),
                  Container(
                    width: 75,
                    height: 30,
                    decoration: BoxDecoration(
                      color: myFavColor4.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Today",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: myFavColor8,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 20),
                  buildMyMessage(
                    context: context,
                    message: "😊 اهلاً ، صباح الخير يافندم",
                  ),
                  mySizedBox(size: size, myHeight: 15),
                  buildReceivedMessage(
                    context: context,
                    message: "😊 صباح النور ياغالي",
                  ),
                ],
              ),
              buildTextFieldToSendMessage(
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMyMessage({
    required BuildContext context,
    required String message,
  }) {
    return Flexible(
      child: SizedBox(
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
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 16, left: 16, right: 60),
                    child: Text(
                      message,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: myFavColor7,
                            fontSize: 16,
                            height: 1.3,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                  child: Text(
                    "10.00",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: myFavColor7,
                          fontSize: 14,
                        ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReceivedMessage({
    required BuildContext context,
    required String message,
  }) {
    return Flexible(
      child: SizedBox(
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
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 16, left: 16, right: 60),
                    child: Text(
                      message,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: myFavColor8,
                            fontSize: 16,
                            height: 1.3,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, bottom: 8),
                  child: Text(
                    "10.00",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: myFavColor8,
                          fontSize: 14,
                        ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextFieldToSendMessage({
    required BuildContext context,
  }) {
    return myTextFormField(
      context: context,
      radius: 15,
      fillColor: myFavColor4.withOpacity(0.3),
      hint: "Message..",
      suffixIcon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FluentIcons.send_20_regular,color: myFavColor,size: 26,),
        ],
      ),
      prefixIcon: Icon(FluentIcons.image_multiple_20_filled,color: myFavColor4,size: 26,),
    );
  }
}
