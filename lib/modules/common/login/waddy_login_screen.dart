import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/layout/driver/layout_screen.dart';
import 'package:waddy_app/layout/user/layout_screen.dart';
import 'package:waddy_app/modules/common/forget_password/waddy_forget_pass_screen.dart';
import 'package:waddy_app/modules/common/login/cubit/cubit.dart';
import 'package:waddy_app/modules/common/login/cubit/states.dart';
import 'package:waddy_app/modules/user/profile/cubit/cubit.dart';
import 'package:waddy_app/modules/user/register/register.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/constants.dart';
import 'package:waddy_app/shared/network/local/cache_helper.dart';

//ignore: must_be_immutable
class WaddyLoginScreen extends StatelessWidget {
  WaddyLoginScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WaddyLoginCubit(),
      child: BlocConsumer<WaddyLoginCubit, WaddyLoginStates>(
        listener: (context, state) {
          if (state is UserLoginSuccessState) {
            if (state.clientModel.user != null) {
              if (state.clientModel.user!.role == 1000) {
                CacheHelper.saveData(
                  key: "token",
                  value: state.clientModel.token,
                ).then((value) {
                  userToken = state.clientModel.token;
                }).then((value){
                    context.read<UserProfileCubit>().getUserData().then((value){
                    navigateToAndFinish(context, const UserLayoutScreen());
                  });
                });
              }
              else if(state.clientModel.user!.role == 2000){
                CacheHelper.saveData(
                  key: "token",
                  value: state.clientModel.token,
                ).then((value) {
                  driverToken = state.clientModel.token;
                }).then((value) {
                  navigateToAndFinish(context, const DriverLayoutScreen());
                });
              }
            }
          } else if (state is UserLoginErrorState) {
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
                        Text('Login to your Account',
                            style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextForm(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          text: 'Email',
                          prefix: Icons.email,
                          valid: (String? value) {
                            if (value!.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextForm(
                            controller: passwordController,
                            type: TextInputType.number,
                            text: 'Password',
                            prefix: Icons.lock,
                            valid: (String? value) {
                              if (value!.isEmpty) {
                                return 'Password is too short';
                              }
                              return null;
                            },
                            suffix: WaddyLoginCubit.get(context).suffix,
                            isSecure: WaddyLoginCubit.get(context).isPassword,
                            suffixAction: () {
                              WaddyLoginCubit.get(context)
                                  .changePasswordVisibility();
                            }),
                        const SizedBox(
                          height: 40.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! UserLoginLoadingState,
                          builder: (context) => myMaterialButton(
                            context: context,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
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
                        const SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              navigateTo(
                                  context, const WaddyForgetPasswordScreen());
                            },
                            child: const Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have account ?'),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, const RegisterScreen());
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.redAccent,
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
