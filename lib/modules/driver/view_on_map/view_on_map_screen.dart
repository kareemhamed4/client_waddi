import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/modules/driver/chat_details/chat_details_screen.dart';
import 'package:waddy_app/modules/driver/orders/cubit/cubit.dart';
import 'package:waddy_app/modules/driver/orders/cubit/states.dart';
import 'package:waddy_app/network/local/cache_helper.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/constants/constants.dart';
import 'package:waddy_app/shared/components/my_google_map.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class DriverViewOnMapScreen extends StatefulWidget {
  final String chatUserName;
  final String? uId;
  const DriverViewOnMapScreen({Key? key, required this.chatUserName, required this.uId}) : super(key: key);

  @override
  State<DriverViewOnMapScreen> createState() => _DriverViewOnMapScreenState();
}

class _DriverViewOnMapScreenState extends State<DriverViewOnMapScreen> {
  TextEditingController messageController = TextEditingController();
  double sheetHeight = 146.0;
  bool isSheetExpanded = false;
  double startPos = 0.0;
  double startHeight = 0.0;

  @override
  void initState() {
    currentLocationAsString = CacheHelper.getData(key: 'currentLocation');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<DriverOrdersCubit, DriverOrdersStates>(
      listener: (context, state) {},
      builder: (context, state) {
        DriverOrdersCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: buildAppBarForOnlyStatusBar(),
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Visibility(
                  visible: currentLocation != null,
                  replacement: const Center(
                    child: Text("Loading"),
                  ),
                  child: const MyGoogleMap(
                    isGoToMyLocationEnabled: false,
                    isTracking: false,
                    zoom: 11,
                    isPlaces: false,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onVerticalDragStart: (DragStartDetails details) {
                      startPos = details.globalPosition.dy;
                      startHeight = sheetHeight;
                    },
                    onVerticalDragUpdate: (DragUpdateDetails details) {
                      setState(() {
                        double delta = details.globalPosition.dy - startPos;
                        sheetHeight = startHeight - delta;
                        if (sheetHeight < 146) {
                          sheetHeight = 146;
                          isSheetExpanded = false;
                        } else if (sheetHeight > 450) {
                          sheetHeight = 450;
                          isSheetExpanded = true;
                        }
                      });
                    },
                    onVerticalDragEnd: (_) {
                      setState(() {
                        if (sheetHeight > 180) {
                          sheetHeight = 450;
                          isSheetExpanded = true;
                        } else {
                          sheetHeight = 146;
                          isSheetExpanded = false;
                        }
                      });
                    },
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                          height: sheetHeight,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  mySizedBox(size: size, myHeight: 25),
                                  Text(
                                    "Delivery",
                                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: myFavColor2),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "Scheduled at : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(fontSize: 14, color: myFavColor2),
                                      ),
                                      Text(
                                        "08:30 pm ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(fontSize: 14, color: myFavColor),
                                      ),
                                      FaIcon(
                                        FontAwesomeIcons.clock,
                                        color: myFavColor4,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                  if (sheetHeight == 450 && isSheetExpanded)
                                    const SizedBox(
                                      height: 40,
                                    ),
                                  if (sheetHeight == 450 && isSheetExpanded)
                                    Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Divider(
                                              height: 0,
                                              thickness: 1,
                                              color: myFavColor4.withOpacity(0.5),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "Postal Code",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(color: myFavColor4, fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              cubit.delegateOrderDetails!.order!.receivedPostalCode!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(color: myFavColor2, fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Divider(
                                              height: 0,
                                              thickness: 1,
                                              color: myFavColor4.withOpacity(0.2),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "LOCATION NAME",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(color: myFavColor4, fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              cubit.delegateOrderDetails!.order!.receivedAddress!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(color: myFavColor2, fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Divider(
                                              height: 0,
                                              thickness: 1,
                                              color: myFavColor4.withOpacity(0.2),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "ORDER ID",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(color: myFavColor4, fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              cubit.delegateOrderDetails!.order!.trackId!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(color: myFavColor2, fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Divider(
                                              height: 0,
                                              thickness: 1,
                                              color: myFavColor4.withOpacity(0.2),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "WEIGHT OF BOXES",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(color: myFavColor4, fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              "${cubit.delegateOrderDetails!.order!.weight.toString()} KG",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(color: myFavColor2, fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            width: 35,
                            height: 4,
                            decoration: BoxDecoration(
                              color: myFavColor4,
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: myFavColor8.withAlpha(20),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: const Offset(0, 0),
                              ),
                            ]),
                            child: CircleAvatar(
                              backgroundColor: myFavColor7,
                              radius: 18,
                              child: Icon(
                                Icons.arrow_back_outlined,
                                color: myFavColor,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (widget.uId != null) {
                              navigateTo(
                                  context, DriverChatDetailsScreen(uId: widget.uId, chatUserName: widget.chatUserName));
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  icon: Icon(Icons.info, color: myFavColor),
                                  title: Text(
                                      "User Doesn't Register in our APP\n leave your message and we will send it across mail",
                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14)),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      myTextFormField(
                                        context: context,
                                        hint: "Type your message here",
                                        controller: messageController,
                                      ),
                                      const SizedBox(height: 12,),
                                      myMaterialButton(
                                        context: context,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        height: 40,
                                        labelWidget: Text("Send",style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16,color: myFavColor7)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: myFavColor8.withAlpha(20),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: const Offset(0, 0),
                              ),
                            ]),
                            child: CircleAvatar(
                              backgroundColor: myFavColor7,
                              radius: 18,
                              child: Icon(
                                FontAwesomeIcons.rocketchat,
                                color: myFavColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
