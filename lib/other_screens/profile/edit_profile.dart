import 'package:flutter/material.dart';
import 'package:waddy_app/other_screens/component.dart';


class Edit_Profile extends StatefulWidget {
  const Edit_Profile({super.key});

  @override
  State<Edit_Profile> createState() => _Edit_ProfileState();
}

class _Edit_ProfileState extends State<Edit_Profile> {

var new_full_name_controller = TextEditingController();
var new_mail_controller = TextEditingController();
var new_gender_controller = TextEditingController();
var new_phone_controller = TextEditingController();
var new_address_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Color.fromRGBO(255, 75, 84, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              defaultFormField(
                controller: new_full_name_controller, 
                label: 'Full Name',
                suffix: Icons.person,
                ),
              SizedBox(height: 20,),
              defaultFormField(
                controller: new_mail_controller, 
                label: 'Mail',
                suffix: Icons.mail,
                ),
              SizedBox(height: 20,),
              defaultFormField(
                controller: new_gender_controller, 
                label: 'Gender',
                ),
              SizedBox(height: 20,),
              defaultFormField(
                controller: new_phone_controller, 
                label: 'Phone',
                suffix: Icons.phone_android,
                ),
              SizedBox(height: 20,),
              defaultFormField(
                controller: new_address_controller, 
                label: 'Address',
                suffix: Icons.location_pin,
                ),
              SizedBox(height:40 ,),
              defaultButton(
                function: (){
                  
                }, 
                text: 'update'
                ),
            ],
          ),
        ),
      ),
    );
  }
}