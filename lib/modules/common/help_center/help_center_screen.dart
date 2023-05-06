import 'package:flutter/material.dart';
import 'package:waddy_app/modules/common/help_center/tab_bar/first_tab_screen.dart';
import 'package:waddy_app/modules/common/help_center/tab_bar/second_tab_screen.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Help Center'),
          ),
          body: Column(
            children: const [
              TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      'FAQ',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Contact Us',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: TabBarView(children: [
                  FirstTab(),
                  SecondTab(),
                ]),
              ),
            ],
          ),
        ));
  }
}
