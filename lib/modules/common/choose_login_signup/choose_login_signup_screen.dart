import 'package:flutter/material.dart';
import 'package:waddy_app/modules/common/login/waddy_login_screen.dart';
import 'package:waddy_app/modules/user/new_register/new_register_screen.dart';
import 'package:waddy_app/shared/components/components.dart';

class ChooseLoginOrSignupScreen extends StatelessWidget {
  const ChooseLoginOrSignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/chooseLoginSignup.png",
            ),
            mySizedBox(size: size, myHeight: 66),
            Text(
              "Let’s You In",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            mySizedBox(size: size, myHeight: 62),
            myMaterialButton(
              context: context,
              onPressed: () {
                navigateTo(context, WaddyLoginScreen());
              },
              labelWidget: Text(
                "Login",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            mySizedBox(size: size, myHeight: 31),
            myMaterialButton(
              context: context,
              onPressed: () {
                navigateTo(context, const NewRegisterScreen());
              },
              labelWidget: Text(
                "Sign up",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
