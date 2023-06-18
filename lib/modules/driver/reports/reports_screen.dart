import 'package:flutter/material.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class DriverReportScreen extends StatelessWidget {
  const DriverReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBarForOnlyStatusBar(height: 60,leadingColor: myFavColor7),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              "Routes Progress",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: myFavColor2, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          buildRoutesProgressItem(
            context: context,
            percentage: 0,
            completed: 0,
            unCompleted: 1,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              "Routes Progress",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: myFavColor2, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          buildRoutesProgressItem(
            context: context,
            percentage: 0,
            completed: 0,
            unCompleted: 0,
          ),
          const SizedBox(
            height: 20,
          ),
          buildStopProgressItem(
            context: context,
            percentage: 500,
            completed: 0,
            unCompleted: 5,
          ),
          mySizedBox(size: size, myHeight: 55),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: myMaterialButton(
                context: context,
                onPressed: () {},
                height: 50,
                labelWidget: Text(
                  "Generate Report",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(),
                )),
          )
        ],
      ),
    );
  }

  Widget buildRoutesProgressItem({
    required BuildContext context,
    required double percentage,
    required int completed,
    required int unCompleted,
  }) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: myFavColor4.withOpacity(0.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$percentage%",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: myFavColor2, fontSize: 44, height: 1),
                ),
                Text(
                  "Completed",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: myFavColor4, fontSize: 16, height: 1),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  unCompleted.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: myFavColor2, fontSize: 44, height: 1),
                ),
                Text(
                  "Uncompleted",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: myFavColor4, fontSize: 16, height: 1),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  completed.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: myFavColor2, fontSize: 44, height: 1),
                ),
                Text(
                  "Completed",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: myFavColor4, fontSize: 16, height: 1),
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildStopProgressItem({
    required BuildContext context,
    required double percentage,
    required int completed,
    required int unCompleted,
  }) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: myFavColor4.withOpacity(0.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    percentage == 500 ? "" : "$percentage%",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: myFavColor2, fontSize: 44, height: 1),
                  ),
                  Text(
                    percentage == 500 ? "" : "Completed",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: myFavColor4, fontSize: 16, height: 1),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    percentage == 500 ? "" : unCompleted.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: myFavColor2, fontSize: 44, height: 1),
                  ),
                  Text(
                    percentage == 500 ? "" : "Uncompleted",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: myFavColor4, fontSize: 16, height: 1),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    completed.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: myFavColor2, fontSize: 44, height: 1),
                  ),
                  Text(
                    percentage == 500
                        ? "Avg Travel Time Per Stop"
                        : "Completed",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: myFavColor4, fontSize: 16, height: 1),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
