import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/layout/driver/cubit/cubit.dart';
import 'package:waddy_app/layout/driver/layout_screen.dart';
import 'package:waddy_app/layout/user/cubit/cubit.dart';
import 'package:waddy_app/layout/user/layout_screen.dart';
import 'package:waddy_app/modules/common/forget_password/waddy_forget_pass_screen.dart';
import 'package:waddy_app/modules/common/login/cubit/cubit.dart';
import 'package:waddy_app/modules/common/login/cubit/states.dart';
import 'package:waddy_app/modules/user/new_register/new_register_screen.dart';
import 'package:waddy_app/network/local/cache_helper.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/constants/constants.dart';
import 'package:waddy_app/shared/styles/colors.dart';

//ignore: must_be_immutable
class WaddyLoginScreen extends StatelessWidget {
  WaddyLoginScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => WaddyLoginCubit(),
      child: BlocConsumer<WaddyLoginCubit, WaddyLoginStates>(
        listener: (context, state) {
          if (state is UserLoginSuccessState) {
            if (state.clientModel.user != null) {
              if (state.clientModel.user!.role == 1000) {
                CacheHelper.saveData(
                  key: "userToken",
                  value: state.clientModel.token,
                ).then((value) {
                  userToken = state.clientModel.token;
                });
              } else if (state.clientModel.user!.role == 2000) {
                CacheHelper.saveData(
                  key: "driverToken",
                  value: state.clientModel.token,
                ).then((value) {
                  driverToken = state.clientModel.token;
                });
              }
            }
          } else if (state is UserLoginErrorState) {
            buildErrorToast(
              title: "Oops!",
              context: context,
              description: state.error,
            );
          } else if (state is LoginWithFBSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              uId = state.uId;
            }).then((value) {
              if (userToken != null) {
                context.read<UserLayoutCubit>().getUserData().then((value) {
                  UserLayoutCubit.get(context).startLocationUpdates();
                  navigateToAndFinish(context, const UserLayoutScreen());
                });
              } else if (driverToken != null) {
                context.read<DriverLayoutCubit>().getDelegateData().then((value) {
                  DriverLayoutCubit.get(context).startLocationUpdates();
                  navigateToAndFinish(context, const DriverLayoutScreen());
                });
              }
            });
          } else if (state is LoginWithFBErrorState) {
            buildErrorToast(
              title: "Oops!",
              context: context,
              description: state.error,
            );
          }
        },
        builder: (context, state) {
          WaddyLoginCubit cubit = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Login to your Account', style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(
                          height: 30.0,
                        ),
                        myTextFormField(
                          context: context,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          hint: 'Email or user name',
                          prefixIcon: Icon(
                            Icons.email,
                            color: myFavColor4,
                          ),
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Email must not be empty';
                            }
                            return null;
                          },
                        ),
                        mySizedBox(size: size, myHeight: 38),
                        myTextFormField(
                          context: context,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          hint: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: myFavColor4,
                          ),
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Password must not be empty';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changeLoginSuffixIcon();
                            },
                            icon: Icon(
                              cubit.suffixIcon,
                              color: myFavColor4,
                            ),
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                          isPassword: cubit.isPassword,
                        ),
                        mySizedBox(size: size, myHeight: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: cubit.isRememberMe,
                              activeColor: myFavColor,
                              checkColor: myFavColor7,
                              onChanged: (value) {
                                cubit.changeRememberMe(value!);
                              },
                            ),
                            Text('Remember me',
                                style:
                                    Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor2, fontSize: 16)),
                          ],
                        ),
                        mySizedBox(size: size, myHeight: 16),
                        ConditionalBuilder(
                          condition: state is! UserLoginLoadingState && state is! LoginWithFBLoadingState,
                          builder: (context) => myMaterialButton(
                            context: context,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  context: context,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            labelWidget: Text(
                              "LOGIN",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                          fallback: (context) => myMaterialButton(
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
                        mySizedBox(size: size, myHeight: 22),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              navigateTo(context, const WaddyForgetPasswordScreen());
                            },
                            child: Text(
                              'Forget the password ?',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor, fontSize: 16),
                            ),
                          ),
                        ),
                        mySizedBox(size: size, myHeight: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have account ?',
                                style:
                                    Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor4, fontSize: 16)),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, const NewRegisterScreen());
                              },
                              child: Text(
                                'Register',
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: myFavColor,
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
