import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:waddy_app/modules/common/login/waddy_login_screen.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

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
      title: 'The Best App For\nShipping & Delivery\nIn Egypt',
    ),
    BoardingModel(
      image: 'assets/images/on-boarding-2.png',
      title: 'You are our Priority,\nshipping fast, easy\nand safe',
    ),
    BoardingModel(
      image: 'assets/images/on-boarding-3.png',
      title: 'Welcome to Waddi\nand enjoy our\nservice',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          mySizedBox(size: size, myHeight: 120),
          Expanded(
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
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
                mySizedBox(size: size, myHeight: 58),
                myMaterialButton(
                    context: context,
                    onPressed: () {
                      if (isLast) {
                        navigateToAndFinish(context, WaddyLoginScreen());
                      } else {
                        boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    labelWidget: Text(isLast ? "Get Started" : "Next",
                        style: Theme.of(context).textTheme.labelLarge)),
                mySizedBox(size: size, myHeight: 58),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(
              model.image,
            ),
            fit: BoxFit.fitWidth,
          ),
          const SizedBox(
            height: 58.0,
          ),
          Text(model.title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: myFavColor2, fontSize: 35, height: 1.2)),
          const SizedBox(
            height: 15.0,
          ),
        ],
      );
}
