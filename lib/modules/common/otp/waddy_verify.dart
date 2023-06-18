import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:waddy_app/modules/common/new_password/reset_password.dart';
import 'package:waddy_app/modules/common/otp/cubit/cubit.dart';
import 'package:waddy_app/modules/common/otp/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

//ignore: must_be_immutable
class WaddyVerifyScreen extends StatelessWidget {
  final String emailAddress;
  WaddyVerifyScreen({super.key, required this.emailAddress});

  var formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<VerifyOTPCubit, VerifyOTPStates>(
      listener: (context, state) {
        if (state is VerifyOTPSuccessState) {
          navigateTo(context, ResetPassword(emailAddress: emailAddress,));
        } else if (state is VerifyOTPErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context, state) {
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
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Image(
                        image: AssetImage('assets/images/forget-pass.png'),
                        fit: BoxFit.cover,
                      ),
                      mySizedBox(size: size, myHeight: 45),
                      Text(
                        'Enter Verification Code',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: myFavColor8, fontSize: 24),
                      ),
                      mySizedBox(size: size, myHeight: 8),
                      Text(
                        'A 6-digit code has been sent to your\nemail address ${emailAddress.substring(0,2)}************@gmail.com',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: myFavColor4, fontSize: 18,height: 1),
                      ),
                      mySizedBox(size: size, myHeight: 30),
                      PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor,fontSize: 16),
                        autoFocus: true,
                        cursorColor: myFavColor2,
                        keyboardType: TextInputType.phone,
                        cursorHeight: 28,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        ],
                        length: 6,
                        obscureText: true,
                        obscuringCharacter: "●",
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                                color: myFavColor2, fontSize: 35, height: 1),
                        animationType: AnimationType.scale,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: size.height * 48/812,
                          fieldWidth: size.width * 48/375,
                          borderWidth: 0.5,
                          activeColor: myFavColor4,
                          disabledColor: myFavColor4,
                          inactiveColor: myFavColor4.withOpacity(0.5),
                          inactiveFillColor: Colors.white,
                          activeFillColor: myFavColor4.withOpacity(0.1),
                          selectedColor: myFavColor,
                          selectedFillColor: myFavColor.withOpacity(0.2),
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        enableActiveFill: true,
                        onCompleted: (value) {
                          otpController.text = value;
                          debugPrint("Completed");
                        },
                        onChanged: (value) {
                          debugPrint(value);
                        },
                      ),
                      mySizedBox(size: size, myHeight: 30),
                      ConditionalBuilder(
                        condition: state is! VerifyOTPLoadingState,
                        builder: (context) => myMaterialButton(
                          height: 50,
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
                            style: Theme.of(context).textTheme.labelLarge,
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
