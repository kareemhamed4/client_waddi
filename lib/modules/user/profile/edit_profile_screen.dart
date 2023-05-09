import 'package:flutter/material.dart';
import 'package:waddy_app/shared/components/components.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

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
              myTextFormField(
                context: context,
                controller: new_full_name_controller,
                hint: 'Full Name',
                suffixIcon:Icon( Icons.person),
              ),
              SizedBox(height: 20,),
              myTextFormField(
                context: context,
                controller: new_mail_controller,
                hint: 'Mail',
                suffixIcon:Icon( Icons.mail),
              ),
              SizedBox(height: 20,),
              myTextFormField(
                context: context,
                controller: new_gender_controller,
                hint: 'Gender',
              ),
              SizedBox(height: 20,),
              myTextFormField(
                context: context,
                controller: new_phone_controller,
                hint: 'Phone',
                suffixIcon:Icon( Icons.phone_android),
              ),
              SizedBox(height: 20,),
              myTextFormField(
                context: context,
                controller: new_address_controller,
                hint: 'Address',
                suffixIcon:Icon( Icons.location_pin),
              ),
              SizedBox(height:40 ,),
              myMaterialButton(
                  onPressed: (){

                  },
                  context: context,
                  labelWidget: Text('update')
              ),
            ],
          ),
        ),
      ),
    );
  }
}