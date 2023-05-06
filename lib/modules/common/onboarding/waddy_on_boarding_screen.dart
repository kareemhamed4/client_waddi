import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:waddy_app/modules/user/login/waddy_login_screen.dart';
import 'package:waddy_app/shared/components/components.dart';

class BoardingModel {
  final String image;
  final String title;
  BoardingModel({
    required this.image,
    required this.title,
  });
}

class WaddyOnBoardingScreen extends StatefulWidget {
  const WaddyOnBoardingScreen({super.key});

  @override
  State<WaddyOnBoardingScreen> createState() => _WaddyOnBoardingScreen();
}

class _WaddyOnBoardingScreen extends State<WaddyOnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/on-boarding-1.png',
      title: 'The Best App ForShipping & Delivery In Egypt',
    ),
    BoardingModel(
      image: 'assets/images/on-boarding-2.png',
      title: 'You are our Priority, shipping fast, easy and safe',
    ),
    BoardingModel(
      image: 'assets/images/on-boarding-3.png',
      title: 'Welcome to Waddi and enjoy our service',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotWidth: 10.0,
                    spacing: 5.0,
                    dotHeight: 10.0,
                    activeDotColor: Colors.red,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onPressed: () {
                    if (isLast) {
                      navigateToAndFinish(context, WaddyLoginScreen());
                    } else {
                      boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                model.image,
              ),
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30.0,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
        ],
      );
}
