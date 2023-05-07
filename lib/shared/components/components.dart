// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waddy_app/shared/styles/colors.dart';

Widget myMaterialButton({
  required BuildContext context,
  required Function onPressed,
  Widget? labelWidget,
  bool isEnabled = true,
  Color? bgColorForNotEnabled,
  double height = 60,
  double radius = 33,
  Color? bgColor,
}) =>
    MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        onPressed();
      },
      color: isEnabled
          ? bgColor ?? myFavColor
          : bgColorForNotEnabled ?? myFavColor4,
      minWidth: double.infinity,
      height: height,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: myFavColor)),
      child: labelWidget,
    );

Widget defaultTextForm({
  required TextEditingController controller,
  required TextInputType type,
  required String text,
  IconData? prefix,
  String? Function(String?)? valid,
  Function()? onTap,
  ValueChanged<String>? onChange,
  bool isSecure = false,
  IconData? suffix,
  Function? suffixAction,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: text,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixAction!();
                },
                icon: Icon(suffix))
            : null,
      ),
      onTap: onTap,
      onChanged: onChange,
      validator: valid,
      obscureText: isSecure,
    );

Widget myDivider() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 0.5,
        color: myFavColor4.withOpacity(0.5),
      ),
    );

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget notify(context) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(7.0),
            color: Colors.white,
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.payment,
                      color: Colors.redAccent,
                      size: 30.0,
                    ),
                    SizedBox(
                      width: 7.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment successful',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'You have made shipping Payment ',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Card(
            color: Colors.white,
            elevation: 10,
            margin: EdgeInsets.all(7.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.local_offer,
                      color: Colors.redAccent,
                      size: 30.0,
                    ),
                    SizedBox(
                      width: 7.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today’s Special Offers !',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'You get a special promo today!',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Card(
            color: Colors.white,
            elevation: 10,
            margin: EdgeInsets.all(7.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.new_label,
                    color: Colors.redAccent,
                    size: 30.0,
                  ),
                  SizedBox(
                    width: 7.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New Services Available !',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Now you can search the nearby drop',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget mySizedBox({
  required Size size,
  double? myHeight,
  double? myWidth,
}) =>
    SizedBox(
      height: myHeight != null ? size.height * myHeight / size.height : 0,
      width: myWidth != null ? size.width * myWidth / size.width : 0,
    );

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  Color? titleColor,
}) =>
    AppBar(
      title: Text(
        title ?? "",
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: titleColor ?? myFavColor8, fontSize: 28),
      ),
    );

Future<dynamic> showMyBottomSheet({
  required BuildContext context,
  required Widget child,
}) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black38,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return child;
      },
    );

Widget myTextFormField({
  required BuildContext context,
  TextEditingController? controller,
  TextInputType? type,
  bool? isPassword,
  Function? onTap,
  ValueChanged<String>? onChange,
  String? Function(String?)? validate,
  ValueChanged<String>? onSubmit,
  Widget? suffixIcon,
  Widget? prefixIcon,
  Widget? icon,
  int? maxLength,
  int? maxLength2,
  Color? fillColor,
  TextAlign? textAlign,
  String? hint,
  double? radius,
}) =>
    Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius??0)),
        shape: BoxShape.rectangle,
      ),
      child: TextFormField(
        obscuringCharacter: '●',
        controller: controller,
        keyboardType: type,
        obscureText: isPassword ?? false,
        onTap: () {
          onTap;
        },
        onChanged: onChange,
        onFieldSubmitted: onSubmit,
        validator: validate,
        textAlign: textAlign ?? TextAlign.start,
        maxLength: maxLength,
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength2),
        ],
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? myFavColor5,
          border: InputBorder.none,
          hintText: hint ?? '',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 16, color: myFavColor4),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    );

Widget myCustomMaterialButtonLeft({
  required BuildContext context,
  required Function onPressed,
  Widget? labelWidget,
  bool isEnabled = true,
  Color? bgColorForNotEnabled,
  double height = 40,
  double radius = 4,
  Color? bgColor,
}) =>
    MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        onPressed();
      },
      color: isEnabled
          ? bgColor ?? myFavColor
          : bgColorForNotEnabled ?? myFavColor4,
      minWidth: double.infinity,
      height: height,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radius),
            bottomLeft: Radius.circular(radius),
          ),
          side: BorderSide(color: myFavColor)),
      child: labelWidget,
    );

Widget myCustomMaterialButtonRight({
  required BuildContext context,
  required Function onPressed,
  Widget? labelWidget,
  bool isEnabled = true,
  Color? bgColorForNotEnabled,
  double height = 40,
  double radius = 4,
  Color? bgColor,
}) =>
    MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        onPressed();
      },
      color: isEnabled
          ? bgColor ?? myFavColor
          : bgColorForNotEnabled ?? myFavColor4,
      minWidth: double.infinity,
      height: height,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(radius),
            bottomRight: Radius.circular(radius),
          ),
          side: BorderSide(color: myFavColor)),
      child: labelWidget,
    );

PreferredSize buildAppBarForOnlyStatusBar({
  double height = 0,
  Color? leadingColor,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: AppBar(
      backgroundColor: myFavColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: myFavColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(
        color: leadingColor ?? myFavColor2,
      ),
    ),
  );
}

Widget buildChatItem(BuildContext context) {
  return Row(
    children: [
      const CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage("assets/images/ahmed.jpg"),
      ),
      const SizedBox(
        width: 16,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ahmed Waddy",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: myFavColor2, fontSize: 18),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "🙏🏻 شكراً علي الخدمة",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: myFavColor4, fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      Column(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration:
            BoxDecoration(color: myFavColor, shape: BoxShape.circle),
            child: Center(
                child: Text("2",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: myFavColor7))),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            "05.00 PM",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: myFavColor4, fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ],
  );
}

Widget buildCallItem({
  required BuildContext context,
  required Widget icon,
}) {
  return Row(
    children: [
      const CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage("assets/images/ahmed.jpg"),
      ),
      const SizedBox(
        width: 16,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ahmed Waddy",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: myFavColor2, fontSize: 18),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            icon,
          ],
        ),
      ),
      Icon(FluentIcons.call_16_regular,color: myFavColor,),
    ],
  );
}
