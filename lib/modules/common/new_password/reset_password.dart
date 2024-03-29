import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/common/login/waddy_login_screen.dart';
import 'package:waddy_app/modules/common/new_password/cubit/cubit.dart';
import 'package:waddy_app/modules/common/new_password/cubit/states.dart';
import 'package:waddy_app/modules/common/otp/cubit/cubit.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class ResetPassword extends StatefulWidget {
  final String emailAddress;
  const ResetPassword({super.key,required this.emailAddress});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isPassword = true;
  bool isChecked = false;

  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UpdatePasswordCubit,UpdatePasswordStates>(
      listener: (context,state){
        if (state is UpdatePasswordSuccessState) {
          buildPasswordChangedSuccessfulDialog(
            context: context,
            size: size,
          );
          Timer(const Duration(seconds: 3), () {
            navigateToAndFinish(context, WaddyLoginScreen());
          });
        }
        else if (state is UpdatePasswordErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context,state){
        UpdatePasswordCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Create new password',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage('assets/images/reset-pass.png'),
                        ),
                      ),
                      mySizedBox(size: size, myHeight: 50),
                      Text(
                        'Create Your New Password',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: myFavColor2, fontSize: 18,
                        ),
                      ),
                      mySizedBox(size: size, myHeight: 16),
                      myTextFormField(
                        context: context,
                        controller: passController,
                        type: TextInputType.visiblePassword,
                        hint: 'New password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubit.changeNewPasswordSuffixIcon();
                          },
                          icon: Icon(
                            cubit.suffixIcon,
                            color: myFavColor4,
                          ),
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                        ),
                        isPassword: cubit.isPassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Password must not be empty';
                          }
                          return null;
                        },
                      ),
                      mySizedBox(size: size, myHeight: 30),
                      myTextFormField(
                        context: context,
                        controller: confirmPassController,
                        type: TextInputType.visiblePassword,
                        hint: 'Confirm new password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubit.changeConfirmNewPasswordSuffixIcon();
                          },
                          icon: Icon(
                            cubit.suffixConfirmIcon,
                            color: myFavColor4,
                          ),
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                        ),
                        isPassword: cubit.isConfirmPassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Password must be matched';
                          }
                          return null;
                        },
                      ),
                      mySizedBox(size: size, myHeight: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: cubit.isRememberMe,
                            activeColor: myFavColor,
                            checkColor: myFavColor7,
                            onChanged: (value){
                              cubit.changeRememberMe(value!);
                            },
                          ),
                          Text('Remember me', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor2,fontSize: 16)),
                        ],
                      ),
                      mySizedBox(size: size, myHeight: 30),
                      ConditionalBuilder(
                        condition: state is! UpdatePasswordLoadingState,
                        builder: (context) => myMaterialButton(
                          context: context,
                          height: 50,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.updatePassword(
                                userId: context.read<VerifyOTPCubit>().userId!,
                                password: passController.text,
                                confirmPassword: confirmPassController.text,
                              );
                            }
                          },
                          labelWidget: Text(
                            "Reset password",
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  void buildPasswordChangedSuccessfulDialog({
    required BuildContext context,
    required Size size,
  }) {
    showDialog<String>(
      context: context,
      builder: (dialogContext) => Center(
        child: SingleChildScrollView(
          child: Container(
            width: size.width * 305 / 375,
            height: size.height * 450 / 812,
            decoration: BoxDecoration(
                color: myFavColor7,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mySizedBox(size: size, myHeight: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/images/redShape.png",
                      width: 130,
                      height: 130,
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 9, bottom: 3),
                      child: Icon(
                        FluentIcons.shield_checkmark_48_regular,
                        size: 40,
                        color: myFavColor7,
                      ),
                    ),
                  ],
                ),
                mySizedBox(size: size, myHeight: 20),
                Text(
                  "Congratulations !",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: myFavColor, fontSize: 20),
                ),
                mySizedBox(size: size, myHeight: 12),
                Text(
                  "Your account is ready to use You will\nBe redirected to the Login page in\nA few seconds...",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: myFavColor2, fontSize: 18),
                ),
                mySizedBox(size: size, myHeight: 20),
                CircularProgressIndicator(
                  color: myFavColor,
                ),
                mySizedBox(size: size, myHeight: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
