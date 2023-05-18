import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/custom_icons_icons.dart';
import 'package:waddy_app/modules/common/forget_password/waddy_forget_pass_screen.dart';
import 'package:waddy_app/modules/user/edit_password/cubit/cubit.dart';
import 'package:waddy_app/modules/user/edit_password/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

//ignore: must_be_immutable
class UserEditPasswordScreen extends StatelessWidget {
  UserEditPasswordScreen({Key? key}) : super(key: key);
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<EditPasswordForAuthUserCubit,EditPasswordForAuthUserStates>(
      listener: (context,state){
        if(state is EditPasswordSuccessState){
          Navigator.pop(context);
          buildSuccessToast(
            title: "OK",
            context: context,
            description: "Password Changed Successfully",
          );
        }
        if(state is EditPasswordErrorState){
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context,state){
        EditPasswordForAuthUserCubit cubit = BlocProvider.of(context);
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
              "Security",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: myFavColor2, fontSize: 28),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
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
                    ConditionalBuilder(
                      condition: state is! EditPasswordLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        height: 50,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.editPasswordForAuthUser(
                              oldPassword: oldPasswordController.text,
                              newPassword: newPasswordController.text,
                              newConfirmPassword: confirmNewPasswordController.text,
                            );
                          }
                        },
                        labelWidget: Text(
                          "Change password",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge,
                        ),
                      ),
                      fallback: (context) => myMaterialButton(
                        height: 50,
                        context: context,
                        onPressed: () {
                          null;
                        },
                        labelWidget: const Center(
                          child: SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    mySizedBox(
                      size: size,
                      myHeight: 12,
                    ),
                    Center(
                      child: myTextButton(
                          context: context,
                          label: "Forgot Password?",
                          onPressed: (){
                            navigateTo(context, const WaddyForgetPasswordScreen());
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
