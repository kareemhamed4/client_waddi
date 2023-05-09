import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/layout/user/layout_screen.dart';
import 'package:waddy_app/modules/common/choose_login_signup/choose_login_signup_screen.dart';
import 'package:waddy_app/modules/user/login/cubit/cubit.dart';
import 'package:waddy_app/modules/user/login/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/components/constants.dart';
import 'package:waddy_app/shared/network/local/cache_helper.dart';
import 'package:waddy_app/test.dart';

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
          listener: (context, state) => {
            if (state is UserLoginSuccessState)
              {
                if (state.loginModel.user != null)
                  {
                    CacheHelper.saveData(
                            key: "token", value: state.loginModel.token)
                        .then((value) {
                      userToken = state.loginModel.token;
                      navigateToAndFinish(
                          context, const UserLayoutScreen());
                    }),
                  }
              }
            else if (state is UserLoginErrorState)
              {
                buildErrorToast(
                    title: "Oops!",
                    context: context,
                    description: state.error,
                )
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
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge,
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
                                navigateTo(context, const Test());
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
                                onPressed: () {},
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
        ));
  }
}
