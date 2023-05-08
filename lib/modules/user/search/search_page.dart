import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    Size size = MediaQuery.of(context).size;
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            myTextFormField(
              context: context,
              radius: 10,
              controller: searchController,
              fillColor: myFavColorWithOpacity,
              hint: "Enter Track Number",
              hintColor: myFavColor5,
              prefixIcon: Icon(
                Icons.search,
                color: myFavColor,
              ),
              onTap: () {},
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/icons/scan_red.png",
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
