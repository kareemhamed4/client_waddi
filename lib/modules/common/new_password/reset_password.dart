import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/layout/user/layout_screen.dart';
import 'package:waddy_app/modules/common/new_password/cubit/cubit.dart';
import 'package:waddy_app/modules/common/new_password/cubit/states.dart';
import 'package:waddy_app/modules/common/otp/cubit/cubit.dart';
import 'package:waddy_app/shared/components/components.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isPassword = true;

  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdatePasswordCubit,UpdatePasswordStates>(
      listener: (context,state){
        if (state is UpdatePasswordSuccessState) {
          navigateToAndFinish(context, const UserLayoutScreen());
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/reset-pass.png'),
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const Text(
                        'Create your new password',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultTextForm(
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          text: 'new password',
                          prefix: Icons.lock,
                          isSecure: isPassword,
                          suffix:
                          isPassword ? Icons.visibility : Icons.visibility_off,
                          suffixAction: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          valid: (String? value) {
                            if (value!.isEmpty) {
                              return 'must not be empty';
                            } else {
                              return null;
                            }
                          }),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultTextForm(
                          controller: confirmPassController,
                          type: TextInputType.visiblePassword,
                          text: 'confirm password',
                          prefix: Icons.lock,
                          isSecure: isPassword,
                          suffix:
                          isPassword ? Icons.visibility : Icons.visibility_off,
                          suffixAction: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          valid: (String? value) {
                            if (value!.isEmpty) {
                              return 'must not be empty';
                            } else {
                              return null;
                            }
                          }),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! UpdatePasswordLoadingState,
                        builder: (context) => myMaterialButton(
                          context: context,
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
}
