import 'package:flutter/material.dart';
import 'package:waddy_app/other_screens/component.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override

  bool ispasswordshow = true;
  bool ispasswordshow2 = true;
  bool isconfirmshow = true;
  var old_password_controller = TextEditingController();
  var new_password_controller = TextEditingController();
  var confirm_controller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security'),
        backgroundColor: Color.fromRGBO(255, 75, 84, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Change Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:23,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              defaultFormField(
                controller: old_password_controller,
                type: TextInputType.visiblePassword,
                label: 'Old Password',
                prefix: Icons.lock,
                suffix: ispasswordshow
                    ? Icons.remove_red_eye
                    : Icons.visibility_off,
                suffix_pressed: () {
                  setState(() {
                    ispasswordshow = !ispasswordshow;
                  });
                },
                ispassword: ispasswordshow,
              ),
              SizedBox(height: 20,),
              defaultFormField(
                controller: new_password_controller,
                type: TextInputType.visiblePassword,
                label: 'New Password',
                prefix: Icons.lock,
                suffix: ispasswordshow2
                    ? Icons.remove_red_eye
                    : Icons.visibility_off,
                suffix_pressed: () {
                  setState(() {
                    ispasswordshow2 = !ispasswordshow2;
                  });
                },
                ispassword: ispasswordshow2,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'password is empty';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              // confirm password
              defaultFormField(
                controller: confirm_controller,
                type: TextInputType.visiblePassword,
                label: 'Confirm Password',
                prefix: Icons.lock,
                suffix: isconfirmshow
                    ? Icons.remove_red_eye
                    : Icons.visibility_off,
                suffix_pressed: () {
                  setState(() {
                    isconfirmshow = !isconfirmshow;
                  });
                },
                ispassword: isconfirmshow,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'confirm password is empty';
                  } else if (confirm_controller.text !=
                      new_password_controller.text) {
                    return 'the confirm don\'t match password';
                  }
                  return null;
                },
              ),
              SizedBox(height:40 ,),

              defaultButton(
                  function: (){

                  },
                  text: 'save'
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forget Password?',
                    style: TextStyle(
                        fontWeight: FontWeight.w500
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );

  }
}