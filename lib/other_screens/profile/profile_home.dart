import 'package:flutter/material.dart';
import 'package:waddy_app/other_screens/profile/edit_profile.dart';
import 'package:waddy_app/other_screens/profile/security.dart';

class Profile_Home extends StatefulWidget {
  const Profile_Home({super.key});

  @override
  State<Profile_Home> createState() => _Profile_HomeState();
}

class _Profile_HomeState extends State<Profile_Home> {
  String name = 'name';
  String gmail = 'gmail@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color.fromRGBO(255, 75, 84, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: const [
                      CircleAvatar(
                        radius: 40,
                        // backgroundImage: AssetImage('images/Picsart_22-10-19_19-44-32-361.jpg'),
                        backgroundColor: Colors.blue,
                      ),
                      CircleAvatar(
                        radius: 10,
                        // ignore: sort_child_properties_last
                        child: Icon(
                          Icons.edit,
                          size: 12,
                          color: Colors.white,
                        ),
                        backgroundColor: Color.fromRGBO(255, 75, 84, 1),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '$gmail',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 1,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 40,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Edit_Profile(),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Icon(Icons.arrow_forward_ios_sharp),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              height: 40,
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.notifications),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Notification',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Icon(Icons.arrow_forward_ios_sharp),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              height: 40,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Security(),
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(Icons.security),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Security',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Icon(Icons.arrow_forward_ios_sharp),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              height: 40,
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.policy),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Icon(Icons.arrow_forward_ios_sharp),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              height: 40,
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Color.fromRGBO(255, 75, 84, 1),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(255, 75, 84, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
