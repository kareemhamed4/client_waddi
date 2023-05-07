import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class DeliveryAttachBillScreen extends StatefulWidget {
  const DeliveryAttachBillScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryAttachBillScreen> createState() =>
      _DeliveryAttachBillScreenState();
}

class _DeliveryAttachBillScreenState extends State<DeliveryAttachBillScreen> {
  List<double> dashPattern = [6, 6];
  String? nameFile;
  bool photoIsUploaded = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBarForOnlyStatusBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: myFavColor8.withAlpha(20),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: myFavColor7,
                  radius: 16,
                  child: Icon(
                    Icons.arrow_back_outlined,
                    color: myFavColor,
                  ),
                ),
              ),
            ),
            mySizedBox(size: size, myHeight: 33),
            Text(
              "Proof of Delivery",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 20, color: myFavColor2),
            ),
            Text(
              "Upload a Bill to Proof of Delivery",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 16, color: myFavColor4),
            ),
            mySizedBox(size: size, myHeight: 12),
            DottedBorder(
              borderType: BorderType.RRect,
              color: myFavColor4,
              dashPattern: dashPattern,
              radius: const Radius.circular(12),
              padding: const EdgeInsets.all(6),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Container(
                  width: double.infinity,
                  height: size.height * 178 / size.height,
                  color: myFavColor7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 125,
                        child: myMaterialButton(
                          context: context,
                          height: 40,
                          radius: 9,
                          labelWidget: Text(
                            photoIsUploaded ? "Uploaded!" : "Upload Bill",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: myFavColor7, fontSize: 16),
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              type: FileType.custom,
                              allowedExtensions: ['png',"jpg","jpeg"],
                            );
                            if (result != null) {
                              PlatformFile file = result.files.first;
                              setState(() {
                                nameFile = file.name;
                                photoIsUploaded = true;
                                dashPattern = [1.0];
                              });
                            }
                          },
                        ),
                      ),
                      mySizedBox(size: size, myHeight: 6),
                      Text(
                        photoIsUploaded ? nameFile! : "image only accepted",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 16, color: myFavColor4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            mySizedBox(size: size, myHeight: 85),
            Row(
              children: [
                Expanded(
                  child: myMaterialButton(
                    context: context,
                    height: 50,
                    radius: 33,
                    labelWidget: Text(
                      "Cancel",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: myFavColor, fontSize: 20),
                    ),
                    bgColor: myFavColorWithOpacity,
                    onPressed: () {
                      setState(() {
                        nameFile = null;
                        photoIsUploaded = false;
                        dashPattern = [6, 6];
                      });
                    },
                  ),
                ),
                mySizedBox(size: size, myWidth: 28),
                Expanded(
                  child: myMaterialButton(
                    context: context,
                    height: 50,
                    radius: 33,
                    labelWidget: Text(
                      "Send",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: myFavColor7, fontSize: 20),
                    ),
                    bgColor: myFavColor,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
