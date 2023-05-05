import 'package:flutter/material.dart';
import 'package:waddy_app/modules/otp/waddy_verify.dart';
import 'package:waddy_app/shared/components/components.dart';

class WaddyForgetPasswordScreen extends StatefulWidget {
  const WaddyForgetPasswordScreen({super.key});

  @override
  State<WaddyForgetPasswordScreen> createState() =>
      _WaddyForgetPasswordScreenState();
}

class _WaddyForgetPasswordScreenState extends State<WaddyForgetPasswordScreen> {
  /*  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );

    /// Configuring the remote server
    //emailAuth!.config(https://student.valuxapps.com/api/);
  }*/

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  /*EmailAuth? emailAuth;

  void sendOTP()async{

    bool result =  await emailAuth!.sendOtp(
        recipientMail: emailController.value.text, otpLength: 5
    );
    if(result)
      {
        print('OTP sent');
      }else
        {
          print('We could not send OTP');
        }
  }
  void verifyOTP()
  {
    bool result = emailAuth!.validateOtp(
      recipientMail: emailController.text,
      userOtp: otpController.text,
    );
    if(result)
    {
      print('OTP Verified');
    }else
    {
      print('Invalid OTP');
    }
  }*/

  @override
  Widget build(BuildContext context) {
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
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  text: 'Email Address',
                  prefix: Icons.email,
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
                defaultButton(
                  function: () {
                    navigateTo(context, WaddyVerifyScreen());
                  },
                  radius: BorderRadius.circular(20.0),
                  text: 'Send Code',
                ),

                const SizedBox(
                  height: 30.0,
                ),
                /*defaultTextForm(
                   controller: otpController,
                   type: TextInputType.phone,
                   text: 'Verify Code',
                   prefix: Icons.verified,
                   valid: (String? value){
                     if(value!.isEmpty) {
                       return 'email must not be empty';
                     } else {
                       return null;
                     }
                   },
                 ),
                 const SizedBox(
                   height: 30.0,
                 ),
                 defaultButton(
                   function: (){
                     verifyOTP();
                     if(formKey.currentState!.validate())
                     {
                       WaddyLoginCubit.get(context).userLogin(otp: otpController.text);
                     }
                   },
                   radius: BorderRadius.circular(20.0),
                   text: 'Send Code',

                 ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
