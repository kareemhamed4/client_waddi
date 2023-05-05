import 'package:flutter/material.dart';
import 'package:waddy_app/modules/notification/notification_screen.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/constants.dart';

class ShippingHomeScreen extends StatelessWidget {
  const ShippingHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        titleSpacing: 20.0,
        title: Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
          child: Row(
            children: const [
              CircleAvatar(
                radius: 35.0,
                backgroundImage: AssetImage('assets/images/user.png'),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Text(
                  'Ahmed Hossam',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: const EdgeInsetsDirectional.all(1.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(250.0),
                border: Border.all(
                  color: Colors.grey,
                  style: BorderStyle.solid,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  navigateTo(context, const NotificationScreen());
                },
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20.0, 40.0, 20.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.grey[100],
                child: defaultTextForm(
                  controller: searchController,
                  type: TextInputType.text,
                  text: 'track ID',
                  prefix: Icons.search,
                  onTap: () {
                    showSearch(context: context, delegate: searchData());
                  },
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 40.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        navigateTo(context, const NotificationScreen());
                      },
                      child: Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.note_add),
                              iconSize: 50.0,
                              color: Colors.redAccent,
                              onPressed: () {
                                navigateTo(context, const NotificationScreen());
                              },
                            ),
                            const Text(
                              'Make Order',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 17.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, const NotificationScreen());
                      },
                      child: Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.check_box),
                              iconSize: 50.0,
                              color: Colors.redAccent,
                              onPressed: () {
                                navigateTo(context, const NotificationScreen());
                              },
                            ),
                            const Text(
                              'Check Rate',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 17.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(vertical: 40.0),
                    child: InkWell(
                      onTap: () {
                        navigateTo(context, const NotificationScreen());
                      },
                      child: Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delivery_dining_outlined),
                              iconSize: 50.0,
                              color: Colors.redAccent,
                              onPressed: () {
                                navigateTo(context, const NotificationScreen());
                              },
                            ),
                            const Text(
                              'Our Services',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 17.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(vertical: 40.0),
                    child: InkWell(
                      onTap: () {
                        navigateTo(context, const NotificationScreen());
                      },
                      child: Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            color: Colors.grey,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.help_center),
                              iconSize: 50.0,
                              color: Colors.redAccent,
                              onPressed: () {
                                navigateTo(context, const NotificationScreen());
                              },
                            ),
                            const Text(
                              'Help Center',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
