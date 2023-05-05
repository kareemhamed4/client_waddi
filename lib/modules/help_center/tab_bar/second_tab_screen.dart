import 'package:flutter/material.dart';

class SecondTab extends StatelessWidget {
  const SecondTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: (){},
            child: Card(
              color: Colors.white,
              elevation: 7.0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: const [
                    Icon(Icons.question_answer, color: Colors.redAccent,),
                    SizedBox(width: 10.0,),
                    Text('Customer Services'),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: (){},
            child: Card(
              color: Colors.white,
              elevation: 7.0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: const [
                    Icon(Icons.call, color: Colors.redAccent,),
                    SizedBox(width: 10.0,),
                    Text('Call'),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: (){},
            child: Card(
              color: Colors.white,
              elevation: 7.0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: const [
                    Icon(Icons.facebook,color: Colors.redAccent,),
                    SizedBox(width: 10.0,),
                    Text('FaceBook'),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: (){},
            child: Card(
              color: Colors.white,
              elevation: 7.0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: const [
                    Icon(Icons.question_answer,color: Colors.redAccent,),
                    SizedBox(width: 10.0,),
                    Text('Customer Services'),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: (){},
            child: Card(
              color: Colors.white,
              elevation: 7.0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: const [
                    Image(image: AssetImage('assets/images/icons8-twitter-30 1.png')),
                    SizedBox(width: 10.0,),
                    Text('Customer Services'),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: (){},
            child: Card(
              color: Colors.white,
              elevation: 7.0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: const [
                    Icon(Icons.camera_alt, color: Colors.redAccent,),
                    SizedBox(width: 10.0,),
                    Text('Instagram'),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: (){},
            child: Card(
              color: Colors.white,
              elevation: 7.0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: const [
                    Image(image: AssetImage('assets/images/icons8-internet-50 1.png')),
                    SizedBox(width: 10.0,),
                    Text('Website'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
