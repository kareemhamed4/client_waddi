import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class DriverPrivacyScreen extends StatefulWidget {
  const DriverPrivacyScreen({Key? key}) : super(key: key);

  @override
  State<DriverPrivacyScreen> createState() => _DriverPrivacyScreenState();
}

class _DriverPrivacyScreenState extends State<DriverPrivacyScreen> {
  final List<ExpansionItem> data = [
    ExpansionItem(
      headerText: "What is privacy policy?",
      expandedText: "bla bla bla",
      icon: FontAwesomeIcons.fileSignature,
    ),
    ExpansionItem(
      headerText: "What information do we collect?",
      expandedText: "bla bla bla",
      icon: FontAwesomeIcons.locationDot,
    ),
    ExpansionItem(
      headerText: "How do we use your information?",
      expandedText: "bla bla bla",
      icon: FontAwesomeIcons.envelope,
    ),
    ExpansionItem(
      headerText: "How long do we keep your information?",
      expandedText: "bla bla bla",
      icon: FontAwesomeIcons.circleInfo,
    ),
    ExpansionItem(
      headerText: "How can you manage or delete your information?",
      expandedText: "bla bla bla",
      icon: FontAwesomeIcons.fileSignature,
    ),
    ExpansionItem(
      headerText: "What information do we collect?",
      expandedText: "bla bla bla",
      icon: FontAwesomeIcons.locationDot,
    ),
    ExpansionItem(
      headerText: "How do we transfer information?",
      expandedText: "bla bla bla",
      icon: FontAwesomeIcons.envelope,
    ),
    ExpansionItem(
      headerText: "How will you know the policy has changed?",
      expandedText: "bla bla bla",
      icon: FontAwesomeIcons.circleInfo,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "Privacy Policy",
        titleColor: myFavColor2,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 1,
                  shape: const RoundedRectangleBorder(
                      side: BorderSide.none,
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
                            title: Text(data[index].headerText,style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 16,color: myFavColor2,height: 1.8),),
                          );
                        },
                        body: ListTile(
                          title: Text(data[index].expandedText,style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 14,color: myFavColor8),),
                        ),
                        isExpanded: data[index].isExpanded,
                        canTapOnHeader: true,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
