import 'package:flutter/material.dart';

class Regist2_date extends StatelessWidget {
  var email2 = TextEditingController();
  var fname2 = TextEditingController();
  var lname2 = TextEditingController();
  var password2 = TextEditingController();
  var confirm2 = TextEditingController();
  var cname = TextEditingController();
  var cindustry = TextEditingController();
  var phone2 = TextEditingController();
  var cgovernrate = TextEditingController();
  var cpostel = TextEditingController();

  Regist2_date({
    required this.email2,
    required this.fname2,
    required this.lname2,
    required this.password2,
    required this.cname,
    required this.cindustry,
    required this.phone2,
    required this.cgovernrate,
    required this.cpostel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Email : ${email2.text}'),
            Text('Name : ${fname2.text} ${lname2.text}'),
            Text('Password : ${password2.text}'),
            Text('Company Name : ${cname.text}'),
            Text('Industry : ${cindustry.text}'),
            Text('Phone : ${phone2.text}'),
            Text('Governrate : ${cgovernrate.text}'),
            Text('Postel Code : ${cpostel.text}'),
          ],
        ),
      ),
    );
  }
}
