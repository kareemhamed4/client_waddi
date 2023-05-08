import 'package:flutter/material.dart';

class Regist_date extends StatelessWidget {
  var email = TextEditingController();
  var fname = TextEditingController();
  var lname = TextEditingController();
  var password = TextEditingController();
  var confirm = TextEditingController();
  var phone = TextEditingController();
  var address = TextEditingController();

  Regist_date({
    required this.email,
    required this.fname,
    required this.lname,
    required this.password,
    required this.phone,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Email : ${email.text}'),
            Text('Name : ${fname.text} ${lname.text}'),
            Text('Password : ${password.text}'),
            Text('Phone : ${phone.text}'),
            Text('Address : ${address.text}'),
          ],
        ),
      ),
    );
  }
}
