import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/common/forget_password/cubit/cubit.dart';
import 'package:waddy_app/modules/common/forget_password/cubit/states.dart';
import 'package:waddy_app/modules/common/otp/waddy_verify.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class WaddyForgetPasswordScreen extends StatefulWidget {
  const WaddyForgetPasswordScreen({super.key});

  @override
  State<WaddyForgetPasswordScreen> createState() =>
      _WaddyForgetPasswordScreenState();
}

class _WaddyForgetPasswordScreenState extends State<WaddyForgetPasswordScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<ForgetPasswordCubit,ForgetPasswordStates>(
      listener: (context,state){
        if (state is ForgetPasswordSuccessState) {
          navigateTo(context, WaddyVerifyScreen(emailAddress: emailController.text));
        }
        else if (state is ForgetPasswordErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context,state){
        ForgetPasswordCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Forget Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
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
                    children: [
                      const Image(
                        image: AssetImage('assets/images/forget-pass.png'),
                      ),
                      mySizedBox(size: size,myHeight: 30),
                      Text(
                        'We will send a code in message to reset your password',
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: myFavColor2,fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      mySizedBox(size: size,myHeight: 60),
                      myTextFormField(
                        context: context,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        hint: 'Email',
                        prefixIcon: Icon(Icons.email,color: myFavColor4,),
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email must not be empty';
                          }
                          return null;
                        },
                      ),
                      mySizedBox(size: size,myHeight: 60),
                      ConditionalBuilder(
                        condition: state is! ForgetPasswordLoadingState,
                        builder: (context) => myMaterialButton(
                          height: 50,
                          context: context,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.forgetPassword(
                                email: emailController.text,
                              );
                            }
                          },
                          labelWidget: Text(
                            "Send Code",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge,
                          ),
                        ),
                        fallback: (context) => myMaterialButton(
                          context: context,
                          height: 50,
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
                        height: 30.0,
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
}
