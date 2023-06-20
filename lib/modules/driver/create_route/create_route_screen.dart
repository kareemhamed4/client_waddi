import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/models/driver/cities_latlang_model.dart';
import 'package:waddy_app/models/driver/delegate_get_his_orders_model.dart';
import 'package:waddy_app/modules/driver/attach_bill/attach_bill_screen.dart';
import 'package:waddy_app/modules/driver/chat_details/chat_details_screen.dart';
import 'package:waddy_app/modules/driver/orders/cubit/cubit.dart';
import 'package:waddy_app/modules/driver/orders/cubit/states.dart';
import 'package:waddy_app/network/local/cache_helper.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/constants/constants.dart';
import 'package:waddy_app/shared/components/my_google_map.dart';
import 'package:waddy_app/shared/styles/colors.dart';
import 'package:waddy_app/tsp.dart';

class DriverCreateRouteScreen extends StatefulWidget {
  const DriverCreateRouteScreen({Key? key}) : super(key: key);

  @override
  State<DriverCreateRouteScreen> createState() => _DriverCreateRouteScreenState();
}

class _DriverCreateRouteScreenState extends State<DriverCreateRouteScreen> {
  TextEditingController messageController = TextEditingController();
  int currentStepRouteIndex = 0;
  double sheetHeight = 360.0;
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
      listener: (context, state) {
        if (state is DriverConfirmOrderByAcceptErrorState) {
          buildSuccessToast(
            context: context,
            title: "Oops!",
            description: state.error,
          );
        }
        if (state is DriverConfirmOrderByRejectErrorState) {
          buildSuccessToast(
            context: context,
            title: "Oops!",
            description: state.error,
          );
        }
        if (state is DriverConfirmOrderByAcceptSuccessState) {
          final stepData = DriverOrdersCubit.get(context).ordersByCity[DriverOrdersCubit.get(context)
              .ordersByCity
              .keys
              .toList()[DriverOrdersCubit.get(context).currentCityIndex]]![currentStepRouteIndex];
          navigateTo(context, DeliveryAttachBillScreen(orderId: stepData.sId));
          buildSuccessToast(
            context: context,
            title: "Done!",
            description: "Please provide confirmation image",
          );
        }
      },
      builder: (context, state) {
        DriverOrdersCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: buildAppBarForOnlyStatusBar(),
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                currentLocation == null
                    ? const Text("Loading")
                    : MyGoogleMap(
                        isGoToMyLocationEnabled: false,
                        isTracking: false,
                        zoom: 11,
                        isPlaces: false,
                        destinations: destinationLatLong,
                      ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onVerticalDragStart: (details) {
                      setState(() {
                        startPos = details.globalPosition.dy;
                        startHeight = sheetHeight;
                      });
                    },
                    onVerticalDragUpdate: (details) {
                      setState(() {
                        double dragDistance = details.globalPosition.dy - startPos;
                        sheetHeight = startHeight - dragDistance;
                        if (sheetHeight < 360) {
                          sheetHeight = 360;
                          currentStepRouteIndex = 0;
                          isSheetExpanded = false;
                        } else if (sheetHeight > 480) {
                          sheetHeight = 480;
                          isSheetExpanded = true;
                        }
                      });
                    },
                    onVerticalDragEnd: (_) {
                      setState(() {
                        if (sheetHeight > 390) {
                          sheetHeight = 480;
                          isSheetExpanded = true;
                        } else {
                          currentStepRouteIndex = 0;
                          sheetHeight = 360;
                          isSheetExpanded = false;
                        }
                      });
                    },
                    child: AnimatedContainer(
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
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: isSheetExpanded
                            ? Column(
                                children: [
                                  buildBottomSheetWithExpanded(
                                    size: size,
                                    currentStepIndex: currentStepRouteIndex,
                                    startPoint: cubit
                                        .ordersByCity[cubit.ordersByCity.keys.toList()[cubit.currentCityIndex]]![
                                            currentStepRouteIndex]
                                        .senderAddress!,
                                    endPoint: cubit
                                        .ordersByCity[cubit.ordersByCity.keys.toList()[cubit.currentCityIndex]]![
                                    currentStepRouteIndex]
                                        .receivedAddress!,
                                  ),
                                  Expanded(
                                    child: Stepper(
                                      physics: const ClampingScrollPhysics(),
                                      currentStep: currentStepRouteIndex,
                                      onStepTapped: (int index) {
                                        setState(() {
                                          currentStepRouteIndex = index;
                                        });
                                      },
                                      controlsBuilder: (context, s) {
                                        return const SizedBox.shrink();
                                      },
                                      steps: List.generate(
                                        cubit.ordersByCity[cubit.ordersByCity.keys.toList()[cubit.currentCityIndex]]!
                                            .length,
                                        (index) {
                                          final stepData = cubit.ordersByCity[
                                              cubit.ordersByCity.keys.toList()[cubit.currentCityIndex]]![index];

                                          return Step(
                                            title: Text(
                                              stepData.receivedAddress!.split(" ").first,
                                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
                                            ),
                                            isActive: true,
                                            content: (stepData.status != "Delivered" && stepData.status != "Rejected")
                                                ? Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          '3:00 PM - 3:15 PM',
                                                          style: Theme.of(context).textTheme.bodySmall,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: myMaterialButton(
                                                                context: context,
                                                                onPressed: () {},
                                                                height: 40,
                                                                radius: 9,
                                                                labelWidget: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      "Start",
                                                                      style: Theme.of(context)
                                                                          .textTheme
                                                                          .labelLarge!
                                                                          .copyWith(fontSize: 12),
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    FaIcon(
                                                                      FontAwesomeIcons.paperPlane,
                                                                      size: 16,
                                                                      color: myFavColor7,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                                flex: 4,
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: ConditionalBuilder(
                                                                        condition: state
                                                                            is! DriverConfirmOrderByAcceptLoadingState,
                                                                        builder: (context) =>
                                                                            myCustomMaterialButtonLeft(
                                                                          context: context,
                                                                          onPressed: () {
                                                                            cubit.driverDoneOrder(
                                                                              orderId: stepData.sId!,
                                                                              confirmType: "Deliverd",
                                                                            );
                                                                          },
                                                                          height: 40,
                                                                          radius: 5,
                                                                          labelWidget: Text(
                                                                            "DELIVERED",
                                                                            style: Theme.of(context)
                                                                                .textTheme
                                                                                .labelLarge!
                                                                                .copyWith(fontSize: 10),
                                                                          ),
                                                                        ),
                                                                        fallback: (context) =>
                                                                            myCustomMaterialButtonLeft(
                                                                          context: context,
                                                                          onPressed: () {
                                                                            null;
                                                                          },
                                                                          height: 40,
                                                                          radius: 5,
                                                                          labelWidget: const Center(
                                                                            child: SizedBox(
                                                                              width: 15,
                                                                              height: 15,
                                                                              child: CircularProgressIndicator(
                                                                                color: Colors.white,
                                                                                strokeWidth: 3,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: ConditionalBuilder(
                                                                        condition: state
                                                                            is! DriverConfirmOrderByRejectLoadingState,
                                                                        builder: (context) =>
                                                                            myCustomMaterialButtonRight(
                                                                          context: context,
                                                                          bgColor: myFavColorWithOpacity,
                                                                          onPressed: () {
                                                                            cubit.driverDoneOrder(
                                                                              orderId: stepData.sId!,
                                                                              confirmType: "Rejected",
                                                                            );
                                                                          },
                                                                          height: 40,
                                                                          radius: 5,
                                                                          labelWidget: Text(
                                                                            "FAILED",
                                                                            style: Theme.of(context)
                                                                                .textTheme
                                                                                .labelLarge!
                                                                                .copyWith(
                                                                                    fontSize: 10, color: myFavColor),
                                                                          ),
                                                                        ),
                                                                        fallback: (context) =>
                                                                            myCustomMaterialButtonRight(
                                                                          context: context,
                                                                          bgColor: myFavColorWithOpacity,
                                                                          onPressed: () {
                                                                            null;
                                                                          },
                                                                          height: 40,
                                                                          radius: 5,
                                                                          labelWidget: const Center(
                                                                            child: SizedBox(
                                                                              width: 15,
                                                                              height: 15,
                                                                              child: CircularProgressIndicator(
                                                                                color: Colors.white,
                                                                                strokeWidth: 3,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: myMaterialButton(
                                                                  context: context,
                                                                  onPressed: () {
                                                                    if (cubit.emailToUidMap[stepData.receivedEmail!] !=
                                                                        null) {
                                                                      navigateTo(
                                                                          context,
                                                                          DriverChatDetailsScreen(
                                                                              uId: cubit.emailToUidMap[
                                                                                  stepData.receivedEmail!],
                                                                              chatUserName: stepData.receivedName));
                                                                    } else {
                                                                      showDialog(
                                                                        context: context,
                                                                        builder: (context) => AlertDialog(
                                                                          shape: const OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(20)),
                                                                          ),
                                                                          icon: Icon(Icons.info, color: myFavColor),
                                                                          title: Text(
                                                                              "User Doesn't Register in our APP\n leave your message and we will send it across mail",
                                                                              style: Theme.of(context)
                                                                                  .textTheme
                                                                                  .titleMedium!
                                                                                  .copyWith(fontSize: 14)),
                                                                          content: Column(
                                                                            mainAxisSize: MainAxisSize.min,
                                                                            children: [
                                                                              myTextFormField(
                                                                                context: context,
                                                                                hint: "Type your message here",
                                                                                controller: messageController,
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 12,
                                                                              ),
                                                                              myMaterialButton(
                                                                                context: context,
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                height: 40,
                                                                                labelWidget: Text(
                                                                                  "Send",
                                                                                  style: Theme.of(context)
                                                                                      .textTheme
                                                                                      .bodyLarge!
                                                                                      .copyWith(
                                                                                        fontSize: 16,
                                                                                        color: myFavColor7,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                  height: 40,
                                                                  radius: 9,
                                                                  labelWidget: FaIcon(
                                                                    FontAwesomeIcons.pen,
                                                                    size: 14,
                                                                    color: myFavColor7,
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Row(
                                                    children: const [
                                                      SizedBox.shrink(),
                                                    ],
                                                  ),
                                            subtitle: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  stepData.receivedAddress!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(color: myFavColor4),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios_outlined,
                                                  color: currentStepRouteIndex == index ? myFavColor2 : myFavColor4,
                                                  size: 20,
                                                )
                                              ],
                                            ),
                                            state: stepData.status == "Delivered"
                                                ? StepState.complete
                                                : stepData.status == "Rejected"
                                                    ? StepState.error
                                                    : StepState.indexed,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : buildBottomSheetWithoutExpanded(
                                size: size, ordersByCity: cubit.ordersByCity, cubit: cubit),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          color: myFavColor7,
                          boxShadow: [
                            BoxShadow(
                              color: myFavColor8.withAlpha(20),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        width: size.width * 192 / size.width,
                        height: 36,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.pen,
                              color: myFavColor,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Route 1 - Feb 11 2023",
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14, color: myFavColor2),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
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
                              Icons.settings,
                              color: myFavColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildBottomSheetWithExpanded({
    required Size size,
    required int currentStepIndex,
    required String startPoint,
    required String endPoint,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            width: 35,
            height: 4,
            decoration: BoxDecoration(
              color: myFavColor4,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
          mySizedBox(size: size, myHeight: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: size.width,
              ),
              Text(
                "Stop.",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: myFavColor2),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Start 03:00 pm, End 03:30 pm",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14, color: myFavColor2),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  FaIcon(
                    FontAwesomeIcons.clock,
                    color: myFavColor4.withOpacity(0.5),
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Start from $startPoint to $endPoint",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14, color: myFavColor2, height: 1),
              ),
              const SizedBox(
                width: 6,
              ),
              FaIcon(
                FontAwesomeIcons.house,
                color: myFavColor4.withOpacity(0.5),
                size: 16,
              ),
            ],
          ),
          const SizedBox(
            height: 27,
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: myFavColor4.withOpacity(0.3),
          ),
        ],
      );

  Widget buildBottomSheetWithoutExpanded({
    required Size size,
    required Map<String, List<Orders>> ordersByCity,
    required DriverOrdersCubit cubit,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 8,
          ),
          Container(
            width: 35,
            height: 4,
            decoration: BoxDecoration(
              color: myFavColor4,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
          mySizedBox(size: size, myHeight: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: size.width,
              ),
              Text(
                "Stop.",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: myFavColor2),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Start 03:00 pm, End 03:30 pm",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14, color: myFavColor2),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  FaIcon(
                    FontAwesomeIcons.clock,
                    color: myFavColor4.withOpacity(0.5),
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      isSheetExpanded = true;
                      sheetHeight = 480;
                      cubit.currentCityIndex = index;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          ordersByCity.keys.toList()[index],
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: myFavColor2),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: myFavColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Home",
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: myFavColor7, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                height: 12,
                thickness: 1,
                color: myFavColor4.withOpacity(0.3),
              ),
              itemCount: ordersByCity.length,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: myMaterialButton(
                      context: context,
                      onPressed: () {},
                      height: 47,
                      radius: 9,
                      labelWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Start Route",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 18),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          FaIcon(
                            FontAwesomeIcons.paperPlane,
                            size: 16,
                            color: myFavColor7,
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: myMaterialButton(
                      context: context,
                      onPressed: () async {
                        cubit.tspRouteResult.clear();
                        await tspNearestNeighbor(citiesLatLong);
                        if(tspRoute.isNotEmpty){
                          buildOptimizationDialog(context: context, ordersByCity: ordersByCity, cubit: cubit);
                        }
                      },
                      height: 47,
                      radius: 9,
                      labelWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Optimize",
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 18),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          FaIcon(
                            FontAwesomeIcons.route,
                            size: 16,
                            color: myFavColor7,
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );

  void buildOptimizationDialog({
    required BuildContext context,
    required Map<String, List<Orders>> ordersByCity,
    required DriverOrdersCubit cubit,
  }) {
    showDialog<String>(
      context: context,
      builder: (dialogContext) => Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(color: myFavColor7, borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: myFavColor,
                    child: FaIcon(
                      FontAwesomeIcons.route,
                      size: 22,
                      color: myFavColor7,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Optimization Result",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor, fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        index == 0
                            ? "${index + 1}st City: ${ordersByCity.keys.toList()[tspRoute[index]]}"
                            : index == 1
                                ? "${index + 1}nd City: ${ordersByCity.keys.toList()[tspRoute[index]]}"
                                : index == 2
                                    ? "${index + 1}rd City: ${ordersByCity.keys.toList()[tspRoute[index]]}"
                                    : "${index + 1}th City: ${ordersByCity.keys.toList()[tspRoute[index]]}",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2, fontSize: 18),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemCount: /*ordersByCity.keys.toList().length*/ 8,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
