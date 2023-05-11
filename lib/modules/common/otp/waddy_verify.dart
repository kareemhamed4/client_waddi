import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/modules/common/new_password/reset_password.dart';
import 'package:waddy_app/modules/common/otp/cubit/cubit.dart';
import 'package:waddy_app/modules/common/otp/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';

//ignore: must_be_immutable
class WaddyVerifyScreen extends StatelessWidget {
  final String emailAddress;
  WaddyVerifyScreen({super.key,required this.emailAddress});

  var formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyOTPCubit,VerifyOTPStates>(
      listener: (context,state){
        if (state is VerifyOTPSuccessState) {
          navigateToAndFinish(context, const ResetPassword());
        }
        else if (state is VerifyOTPErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context,state){
        VerifyOTPCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Forget Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage('assets/images/forget-pass.png'),
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const Text(
                      'We will send a code in message to reset your password',
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    //Text Form Field Component For Email Address
                    defaultTextForm(
                      controller: otpController,
                      type: TextInputType.phone,
                      text: 'Verify Code',
                      prefix: Icons.verified,
                      valid: (String? value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    // Button Component ---------------------
                    ConditionalBuilder(
                      condition: state is! VerifyOTPLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.verifyOTP(
                              email: emailAddress,
                              otp: otpController.text,
                            );
                          }
                        },
                        labelWidget: Text(
                          "Verify",
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
