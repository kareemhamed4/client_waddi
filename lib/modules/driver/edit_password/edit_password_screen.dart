import 'package:flutter/material.dart';
import 'package:waddy_app/custom_icons_icons.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class DriverEditPasswordScreen extends StatelessWidget {
  const DriverEditPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmNewPasswordController = TextEditingController();
    return Scaffold(
      appBar: defaultAppBar(
        context: context,
        title: "Security",
        titleColor: myFavColor2
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Change Password",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: myFavColor2,fontSize: 20
                  ),
                ),
              ),
              mySizedBox(
                size: size,
                myHeight: 16,
              ),
              Text(
                "Old Password",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: myFavColor2,fontSize: 16
                ),
              ),
              mySizedBox(
                size: size,
                myHeight: 6,
              ),
              myTextFormField(
                context: context,
                controller: oldPasswordController,
                type: TextInputType.visiblePassword,
                isPassword: true,
                radius: 10,
                textColor: myFavColor2,
                prefixIcon: const Icon(
                  CustomIcons.lock_filled,
                  size: 20,
                ),
                suffixIcon: const Icon(
                  Icons.visibility_off_outlined,
                  size: 20,
                ),
              ),
              mySizedBox(
                size: size,
                myHeight: 17,
              ),
              Text(
                "New Password",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: myFavColor2,fontSize: 16
                ),
              ),
              mySizedBox(
                size: size,
                myHeight: 6,
              ),
              myTextFormField(
                context: context,
                controller: newPasswordController,
                type: TextInputType.visiblePassword,
                isPassword: true,
                radius: 10,
                textColor: myFavColor2,
                prefixIcon: const Icon(
                  CustomIcons.lock_filled,
                  size: 20,
                ),
                suffixIcon: const Icon(
                  Icons.visibility_off_outlined,
                  size: 20,
                ),
              ),
              mySizedBox(
                size: size,
                myHeight: 17,
              ),
              Text(
                "Confirm Password",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: myFavColor2,fontSize: 16
                ),
              ),
              mySizedBox(
                size: size,
                myHeight: 6,
              ),
              myTextFormField(
                context: context,
                controller: confirmNewPasswordController,
                type: TextInputType.visiblePassword,
                isPassword: true,
                radius: 10,
                textColor: myFavColor2,
                prefixIcon: const Icon(
                  CustomIcons.lock_filled,
                  size: 20,
                ),
                suffixIcon: const Icon(
                  Icons.visibility_off_outlined,
                  size: 20,
                ),
              ),
              mySizedBox(
                size: size,
                myHeight: 42,
              ),
              myMaterialButton(
                context: context,
                onPressed: () {},
                height: 50,
                labelWidget: Text("Save",style: Theme.of(context).textTheme.labelLarge,),
              ),
              mySizedBox(
                size: size,
                myHeight: 12,
              ),
              Center(
                child: myTextButton(
                    context: context,
                    label: "Forgot Password?",
                    onPressed: (){}
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
