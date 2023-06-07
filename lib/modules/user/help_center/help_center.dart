import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/modules/user/customer_service_chat/customer_service_chat_screen.dart';
import 'package:waddy_app/modules/user/help_center/cubit/cubit.dart';
import 'package:waddy_app/modules/user/help_center/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class ExpansionItem {
  String headerText;
  String expandedText;
  bool isExpanded;
  IconData icon;

  ExpansionItem({
    required this.headerText,
    required this.expandedText,
    required this.icon,
    this.isExpanded = false,
  });
}

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  late TabController secondTabController;
  TextEditingController searchController  = TextEditingController();

  final List<ExpansionItem> data = [
    ExpansionItem(
      headerText: "What is WADDI ?",
      expandedText: "An application for shipping goods that makes it easier for the user to complete the shipping process by providing a simple user interface .",
      icon: FontAwesomeIcons.fileSignature,
    ),
    ExpansionItem(
      headerText: "How can I calculate shipping rate ?",
      expandedText: "bla bla bla",
      icon: FontAwesomeIcons.locationDot,
    ),
    ExpansionItem(
      headerText: "How to use WADDI?",
      expandedText: "bla bla bla",
      icon: FontAwesomeIcons.envelope,
    ),
    ExpansionItem(
      headerText: "Can I create my own Shipping?",
      expandedText: "bla bla bla",
      icon: FontAwesomeIcons.circleInfo,
    ),
    ExpansionItem(
      headerText: "Is WADDI free to use ",
      expandedText: "bla bla bla",
      icon: FontAwesomeIcons.fileSignature,
    ),
    ExpansionItem(
      headerText: "How to make offer on WADDI",
      expandedText: "bla bla bla",
      icon: FontAwesomeIcons.locationDot,
    ),
  ];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    secondTabController = TabController(vsync: this, length: 4);
    secondTabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    secondTabController.removeListener(_handleTabSelection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<HelpCenterCubit, HelpCenterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HelpCenterCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                SystemChannels.textInput
                    .invokeMethod('TextInput.hide')
                    .then((value) {
                  Timer(const Duration(milliseconds: 250), () {
                    Navigator.pop(context);
                  });
                });
              },
              child: const Icon(
                Icons.arrow_back_outlined,
              ),
            ),
            title: Text(
              "Help Center",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: myFavColor8, fontSize: 28),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                TabBar(
                  controller: tabController,
                  onTap: (index){
                    cubit.changeFirstTabBarIndex(index);
                    cubit.currentIndexForFirstTabBar = index;
                  },
                  indicatorWeight: 3,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 16),
                  tabs: [
                    Tab(
                      height: 40,
                      child: Text("FAQ",style: Theme.of(context).textTheme.labelLarge!.copyWith(color: cubit.currentIndexForFirstTabBar == 0 ? myFavColor : myFavColor8),),
                    ),
                    Tab(
                      height: 40,
                      child: Text("Contact Us",style: Theme.of(context).textTheme.labelLarge!.copyWith(color: cubit.currentIndexForFirstTabBar == 1 ? myFavColor : myFavColor8),),
                    ),
                  ],
                ),
                if(cubit.currentIndexForFirstTabBar == 0)
                  buildFAQScreen(size: size),
                if(cubit.currentIndexForFirstTabBar == 1)
                  buildContactUsScreen(
                    size: size,
                    textList: [
                      "Customer Service",
                      "WhatsApp",
                      "Facebook",
                      "Twitter",
                      "Instagram",
                      "Website",
                    ],
                    imageList: [
                      "assets/icons/customer-service.png",
                      "assets/icons/whatsapp.png",
                      "assets/icons/facebook.png",
                      "assets/icons/twitter.png",
                      "assets/icons/instagram.png",
                      "assets/icons/internet.png",
                    ],
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildFAQScreen({
    required Size size,
}) => Column(
    children: [
      mySizedBox(size: size,myHeight: 20),
      defaultTabBar(
        context: context,
        tabController: secondTabController,
        size: size,
        itemsName: ["Sender","Receiver","Package","Payment"],
      ),
      Padding(
        padding: const EdgeInsets.all(16),
        child: myTextFormField(
          context: context,
          controller: searchController,
          textInputAction: TextInputAction.search,
          radius: 10,
          hint: "Search",
          prefixIcon: Icon(
            Icons.search,
            color: myFavColor4,
          ),
        ),
      ),
      mySizedBox(size: size,myHeight: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: myFavColor8.withAlpha(20),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 0)),
                ],
              ),
              child: ExpansionPanelList(
                elevation: 0,
                dividerColor: myFavColor4,
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int panelIndex, bool isExpanded) {
                  setState(() {
                    data[index].isExpanded = !isExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(data[index].headerText,style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20,color: myFavColor2,height: 1.8),),
                      );
                    },
                    body: ListTile(
                      title: Text(data[index].expandedText,style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16,color: myFavColor8),),
                    ),
                    isExpanded: data[index].isExpanded,
                    canTapOnHeader: true,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context,index)=> const SizedBox(height: 12,),
        ),
      ),
    ],
  );

  Widget buildContactUsScreen({
    required Size size,
    required List<String> imageList,
    required List<String> textList,
}) => Column(
    children: [
      mySizedBox(size: size,myHeight: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: imageList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: myFavColor7,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: myFavColor8.withAlpha(20),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 0)),
                ],
              ),
              child: ListTile(
                onTap: (){
                  if(index == 0){
                    navigateTo(context, const CustomerServiceChatDetailsScreen());
                  }
                },
                leading: Image.asset(imageList[index]),
                title: Text(textList[index],style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor8,fontSize: 18),),
              ),
            );
          },
          separatorBuilder: (context,index)=> const SizedBox(height: 12,),
        ),
      ),
    ],
  );
}
