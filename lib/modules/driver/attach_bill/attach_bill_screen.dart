import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:waddy_app/modules/driver/orders/cubit/cubit.dart';
import 'package:waddy_app/modules/driver/orders/cubit/states.dart';
import 'package:waddy_app/shared/components/components.dart';
import 'package:waddy_app/shared/styles/colors.dart';

class DeliveryAttachBillScreen extends StatefulWidget {
  final String? orderId;
  const DeliveryAttachBillScreen({Key? key, this.orderId}) : super(key: key);

  @override
  State<DeliveryAttachBillScreen> createState() => _DeliveryAttachBillScreenState();
}

class _DeliveryAttachBillScreenState extends State<DeliveryAttachBillScreen> {
  TextEditingController orderIdController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  List<double> dashPattern = [6, 6];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    orderIdController.text = widget.orderId ?? "";
    return BlocConsumer<DriverOrdersCubit, DriverOrdersStates>(
      listener: (context, state) {
        if(state is ImageUploadSuccessState){
          Navigator.pop(context);
          buildSuccessToast(context: context, title: "Done!", description: "Image Uploaded Successfully");
        }
        if(state is ImageUploadErrorState){
          Navigator.pop(context);
          buildSuccessToast(context: context, title: "Oops!", description: state.error);
        }
      },
      builder: (context, state) {
        DriverOrdersCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: buildAppBarForOnlyStatusBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
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
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20, color: myFavColor2),
                  ),
                  Text(
                    "Upload a Bill to Proof of Delivery",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16, color: myFavColor4),
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
                                  cubit.filePath != null ? "Uploaded!" : "Upload Bill",
                                  style:
                                      Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor7, fontSize: 16),
                                ),
                                onPressed: () async {
                                  cubit.chooseImageFile();
                                },
                              ),
                            ),
                            mySizedBox(size: size, myHeight: 6),
                            Text(
                              cubit.filePath != null ? cubit.fileName! : "image only accepted",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16, color: myFavColor4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 20),
                  Text('Order ID', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14)),
                  const SizedBox(
                    height: 8.0,
                  ),
                  myTextFormField(
                    context: context,
                    controller: orderIdController,
                    type: TextInputType.text,
                    hint: 'Order ID',
                    prefixIcon: Icon(
                      FontAwesomeIcons.hashtag,
                      color: myFavColor4,
                    ),
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'OrderId must not be empty';
                      }
                      return null;
                    },
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
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor, fontSize: 20),
                          ),
                          bgColor: myFavColorWithOpacity,
                          onPressed: () {
                            cubit.deleteSelectedImage();
                            setState(() {
                              dashPattern = [6, 6];
                            });
                          },
                        ),
                      ),
                      mySizedBox(size: size, myWidth: 28),
                      Expanded(
                        child: ConditionalBuilder(
                          condition: state is! ImageUploadLoadingState,
                          builder: (context) => myMaterialButton(
                            context: context,
                            height: 50,
                            radius: 33,
                            labelWidget: Text(
                              "Send",
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor7, fontSize: 20),
                            ),
                            bgColor: myFavColor,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (cubit.result != null) {
                                  cubit.delegateUploadImageProof(
                                    orderId: widget.orderId ?? orderIdController.text,
                                  );
                                }
                              }
                            },
                          ),
                          fallback: (context) => myMaterialButton(
                            context: context,
                            height: 50,
                            radius: 33,
                            labelWidget: const Center(
                              child: SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              ),
                            ),
                            bgColor: myFavColor,
                            onPressed: () {
                              null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
