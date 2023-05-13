import 'package:flutter/material.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/constants/constants.dart';

class FirstTab extends StatefulWidget {
  const FirstTab({Key? key}) : super(key: key);

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  var searchController = TextEditingController();
  bool isVisible_1 = false;
  bool isVisible_2 = false;
  bool isVisible_3 = false;
  bool isVisible_4 = false;
  bool isVisible_5 = false;
  bool isVisible_6 = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              color: Colors.grey[100],
              child: defaultTextForm(
                controller: searchController,
                type: TextInputType.text,
                text: 'Search',
                prefix: Icons.search,
                onTap: () {
                  showSearch(context: context, delegate: searchData());
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(15.0),
            ),
            child: Card(
              //margin: EdgeInsets.all(10.0),
              color: Colors.white,
              elevation: 7.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isVisible_1 = !isVisible_1;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('What is Waddy'),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isVisible_1)
                    Column(
                      children: [
                        myDivider(),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'An application for shipping goods that makes it easier for the user to complete the shipping process by providing a simple user interface .',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(15.0),
            ),
            child: Card(
              //margin: EdgeInsets.all(10.0),
              color: Colors.white,
              elevation: 7.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isVisible_2 = !isVisible_2;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('How can I calculate shipping rate ?'),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isVisible_2)
                    Column(
                      children: [
                        myDivider(),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'An application for shipping goods that makes it easier for the user to complete the shipping process by providing a simple user interface .',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(15.0),
            ),
            child: Card(
              //margin: EdgeInsets.all(10.0),
              color: Colors.white,
              elevation: 7.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isVisible_3 = !isVisible_3;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('How to use WADDI ?'),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isVisible_3)
                    Column(
                      children: [
                        myDivider(),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'An application for shipping goods that makes it easier for the user to complete the shipping process by providing a simple user interface .',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(15.0),
            ),
            child: Card(
              //margin: EdgeInsets.all(10.0),
              color: Colors.white,
              elevation: 7.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isVisible_4 = !isVisible_4;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Can I create my own Shipping ?'),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isVisible_4)
                    Column(
                      children: [
                        myDivider(),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'An application for shipping goods that makes it easier for the user to complete the shipping process by providing a simple user interface .',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(15.0),
            ),
            child: Card(
              //margin: EdgeInsets.all(10.0),
              color: Colors.white,
              elevation: 7.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isVisible_5 = !isVisible_5;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Is WADDI free to use ?'),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isVisible_5)
                    Column(
                      children: [
                        myDivider(),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'An application for shipping goods that makes it easier for the user to complete the shipping process by providing a simple user interface .',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(15.0),
            ),
            child: Card(
              //margin: EdgeInsets.all(10.0),
              color: Colors.white,
              elevation: 7.0,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isVisible_6 = !isVisible_6;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('How to make offer on WADDI ?'),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isVisible_6)
                    Column(
                      children: [
                        myDivider(),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'An application for shipping goods that makes it easier for the user to complete the shipping process by providing a simple user interface .',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
