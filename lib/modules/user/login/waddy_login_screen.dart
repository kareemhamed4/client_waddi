import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/user/home/home_screen.dart';
import 'package:waddy_app/modules/user/login/cubit/cubit.dart';
import 'package:waddy_app/modules/user/login/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';
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
          listener: (context, state) {
            if (state is LoginLoadingState) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      content: AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        curve: Curves.easeIn,
                        child: Row(
                          children: const [
                            CupertinoActivityIndicator(
                              color: Colors.redAccent,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'wait',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else if (state is LoginSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: const Text('Valid email'),
                  ),
                ),
              );
              Navigator.pop(context);
              navigateToAndFinish(context, const ShippingHomeScreen());
            } else if (state is FailedToLoginState) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.red,
                    content: Text(state.message),
                  );
                },
              );
            }
          },
          builder: (context, state) {
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
                          Text(
                            'Login to your Account',
                            style: Theme.of(context).textTheme.titleLarge
                          ),
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
                            condition: state is! WaddyLoadingState,
                            builder: (context) => myMaterialButton(
                              context: context,
                              labelWidget: Text(
                                "Sign in",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  WaddyLoginCubit.get(context).login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
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
