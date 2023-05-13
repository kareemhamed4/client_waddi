import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:waddy_app/modules/common/new_password/reset_password.dart';
import 'package:waddy_app/shared/components/components.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  TextEditingController email = TextEditingController();
  TextEditingController otp = TextEditingController();
  EmailOTP myAuth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forget Password',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
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
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                          labelText: "Email Address",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.all(20.0),
                      child: Container(
                        height: 40.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.redAccent,
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            myAuth.setConfig(
                                appEmail: "me@rohitchouhan.com",
                                appName: "Email OTP",
                                userEmail: email.text,
                                otpLength: 6,
                                otpType: OTPType.digitsOnly);
                            if (await myAuth.sendOTP() == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("OTP has been sent"),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Oops, OTP send failed"),
                                ),
                              );
                            }
                          },
                          child: const Text("Send Code"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: otp,
                        decoration: const InputDecoration(
                          labelText: "Enter Code",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 40.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (await myAuth.verifyOTP(otp: otp.text) == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("OTP is verified"),
                                ),
                              );
                              navigateTo(context, ResetPassword(emailAddress: email.text,));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Invalid OTP"),
                                ),
                              );
                            }
                          },
                          child: const Text("Verify"),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
