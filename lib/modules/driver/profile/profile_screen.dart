import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/custom_icons_icons.dart';
import 'package:waddy_app/modules/common/choose_login_signup/choose_login_signup_screen.dart';
import 'package:waddy_app/modules/driver/edit_password/edit_password_screen.dart';
import 'package:waddy_app/modules/driver/edit_profile/edit_profile_screen.dart';
import 'package:waddy_app/modules/driver/notification_setting/notification_setting_screen.dart';
import 'package:waddy_app/modules/driver/privacy/privacy_policy_screen.dart';
import 'package:waddy_app/modules/driver/profile/cubit/cubit.dart';
import 'package:waddy_app/modules/driver/profile/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String fName;
    String lName;
    String email;
    return BlocConsumer<DriverProfileCubit, DriverProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = DriverProfileCubit.get(context).userInfo;
        fName = model != null ? model.firstName! : " ";
        lName = model != null ? model.lastName! : " ";
        email = model != null ? model.email! : " ";
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mySizedBox(size: size, myHeight: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      "Profile",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontSize: 28, color: myFavColor2),
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 22),
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        if (model != null)
                          CircleAvatar(
                            radius: 55,
                            backgroundImage: model.userImg == "false"
                                ? const AssetImage("assets/images/ahmed.jpg")
                                : AssetImage(model.userImg!),
                          ),
                        if (model == null)
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: rose,
                            child: Icon(
                              FontAwesomeIcons.spinner,
                              color: myFavColor7,
                            ),
                          ),
                        GestureDetector(
                          onTap: () {
                            DriverProfileCubit.get(context).getProfileImage();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 4.0, bottom: 4.0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: myFavColor7,
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                  ),
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: myFavColor,
                                    shape: BoxShape.rectangle,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                  ),
                                  child: Center(
                                      child: FaIcon(
                                    FontAwesomeIcons.pen,
                                    color: myFavColor7,
                                    size: 10,
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 16),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "$fName $lName",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      email,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16, color: myFavColor2, height: 1),
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 20),
                  myDivider(),
                  mySizedBox(size: size, myHeight: 20),
                  ListTile(
                    onTap: () {
                      navigateTo(
                        context,
                        const DriverEditProfileScreen(),
                      );
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                    leading: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: myFavColor6,
                          )),
                      child: Center(
                        child: Icon(
                          CustomIcons.user,
                          color: myFavColor6,
                          size: 15,
                        ),
                      ),
                    ),
                    title: Text(
                      "Edit Profile",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 20, color: myFavColor2),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: myFavColor2,
                      size: 20,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      navigateTo(
                        context,
                        const DriverNotificationSettingScreen(),
                      );
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(
                        CustomIcons.bell,
                        color: myFavColor6,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      "Notification",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 20, color: myFavColor2),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: myFavColor2,
                      size: 20,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      navigateTo(
                        context,
                        DriverEditPasswordScreen(),
                      );
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(
                        CustomIcons.shield_alt,
                        color: myFavColor6,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      "Security",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 20, color: myFavColor2),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: myFavColor2,
                      size: 20,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      navigateTo(
                        context,
                        const DriverPrivacyScreen(),
                      );
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(
                        CustomIcons.lock_open,
                        color: myFavColor6,
                        size: 25,
                      ),
                    ),
                    title: Text(
                      "Privacy Policy",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 20, color: myFavColor2),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: myFavColor2,
                      size: 20,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showMyBottomSheet(
                        context: context,
                        size: size,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              mySizedBox(size: size, myHeight: 8),
                              Container(
                                width: 35,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: myFavColor4,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                              ),
                              mySizedBox(size: size, myHeight: 30),
                              Text(
                                "Logout",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(fontSize: 28, color: myFavColor),
                              ),
                              mySizedBox(size: size, myHeight: 10),
                              myDivider(),
                              mySizedBox(size: size, myHeight: 10),
                              Text(
                                "Are you sure you want to logout ?",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontSize: 24, color: myFavColor8),
                              ),
                              mySizedBox(size: size, myHeight: 30),
                              Row(
                                children: [
                                  Expanded(
                                    child: myMaterialButton(
                                      context: context,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      height: 50,
                                      bgColor: rose,
                                      labelWidget: Text("Cancel",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(color: myFavColor)),
                                    ),
                                  ),
                                  mySizedBox(size: size, myWidth: 28),
                                  Expanded(
                                    child: myMaterialButton(
                                      context: context,
                                      onPressed: () {
                                        navigateToAndFinish(
                                          context,
                                          const ChooseLoginOrSignupScreen(),
                                        );
                                      },
                                      height: 50,
                                      labelWidget: Text(
                                        "Yes, Logout",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              mySizedBox(size: size, myHeight: 40),
                            ],
                          ),
                        ),
                      );
                    },
                    contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Icon(
                        CustomIcons.logout,
                        color: myFavColor,
                        size: 25,
                      ),
                    ),
                    title: Text(
                      "Logout",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 20, color: myFavColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
