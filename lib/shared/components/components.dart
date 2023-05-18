// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/layout/user/cubit/cubit.dart';
import 'package:waddy_app/models/common/message_model.dart';
import 'package:waddy_app/models/user/model_user_firebase.dart';
import 'package:waddy_app/modules/user/chat_details/chat_details_screen.dart';
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

Future<void> navigateTo(context, widget) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

Future<void> navigateToAndFinish(context, widget) async {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

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
      height: myHeight != null ? size.height * myHeight / 780 : 0,
      width: myWidth != null ? size.width * myWidth / 360 : 0,
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
  required Size size,
}) =>
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black38,
      useSafeArea: true,
      constraints: BoxConstraints(maxHeight: size.height * 0.75),
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

class FourCharSpaceFormatter extends TextInputFormatter {
  final int charSpaceCount;

  FourCharSpaceFormatter({this.charSpaceCount = 0});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newString = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    var spaceCount = 0;

    for (var i = 0; i < newString.length; i++) {
      final character = newString[i];

      if (character == ' ') {
        // Skip additional spaces if not required
        if (charSpaceCount > 0 && spaceCount >= charSpaceCount) {
          continue;
        }

        buffer.write(' ');
        spaceCount++;
      } else {
        buffer.write(character);
      }

      if (charSpaceCount > 0 && (i + 1) % charSpaceCount == 0) {
        buffer.write(' ');
        spaceCount++;
      }
    }

    final newText = buffer.toString().trim();
    final newSelectionIndex =
        newValue.selection.end + newText.length - newValue.text.length;

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newSelectionIndex),
    );
  }
}

Widget myTextFormField({
  required BuildContext context,
  TextEditingController? controller,
  TextInputType? type,
  bool? isPassword,
  VoidCallback? onTap,
  ValueChanged<String>? onChange,
  String? Function(String?)? validate,
  ValueChanged<String>? onSubmit,
  Widget? suffixIcon,
  Widget? prefixIcon,
  Widget? icon,
  int? maxLength,
  int? maxLength2,
  Color? fillColor,
  Color? hintColor,
  Color? textColor,
  TextAlign? textAlign,
  String? hint,
  double? radius,
  int? minLines,
  int? maxLines,
  bool? isEnabled = true,
  TextInputAction? textInputAction,
}) =>
    Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius ?? 0),
        ),
        shape: BoxShape.rectangle,
      ),
      child: TextFormField(
        obscuringCharacter: '●',
        controller: controller,
        enabled: isEnabled ?? true,
        keyboardType: type,
        obscureText: isPassword ?? false,
        onTap: onTap,
        onChanged: (value) {
          if (onChange != null) {
            final oldValueSelection = controller?.selection;
            onChange(value);
            controller?.value = TextEditingValue(
              text: value,
              selection: oldValueSelection!,
            );
          }
        },
        textInputAction: textInputAction ?? TextInputAction.done,
        onFieldSubmitted: onSubmit,
        validator: validate,
        textAlign: textAlign ?? TextAlign.start,
        maxLength: maxLength,
        minLines: minLines ?? 1,
        maxLines: minLines ?? 1,
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength2),
        ],
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontSize: 18, color: textColor ?? myFavColor8),
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? myFavColor5,
          border: fillColor == null
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
                  borderSide: BorderSide(
                    color: myFavColor,
                  ),
                ),
          hintText: hint ?? '',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 16, color: hintColor ?? myFavColor4),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          alignLabelWithHint: true,
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

Widget buildChatItem({
  required BuildContext context,
  required UserModelFB modelFB,
}) {
  UserLayoutCubit cubit = BlocProvider.of<UserLayoutCubit>(context);
  // Retrieve the last message for the current user from the map
  MessageModel? lastMessage = cubit.lastMessages[modelFB.uId];
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      navigateTo(context, UserChatDetailsScreen(userModelFB: modelFB));
    },
    child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(modelFB.image!),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                modelFB.name!,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: myFavColor2, fontSize: 18),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (lastMessage != null)  // Check if there's a last message
                Row(
                  children: [
                    Icon(
                      lastMessage.senderId == cubit.userModelFB!.uId
                          ? Icons.check_circle_outline_outlined
                          : null,
                      color: myFavColor4,
                      size: 15,
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 140,
                      child: Text(
                        lastMessage.text!,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: myFavColor4, fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
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
    ),
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
      Icon(
        FluentIcons.call_16_regular,
        color: myFavColor,
      ),
    ],
  );
}

Widget buildTransactionHistoryItem({
  required BuildContext context,
}) =>
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: myFavColorWithOpacity,
              radius: 25,
              child: Center(
                  child: Image.asset(
                "assets/icons/wallet.png",
                height: 20,
                width: 20,
              )),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New Order Made !",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "You have created a new\nshipping order",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(height: 1.2),
                ),
              ],
            ),
          ],
        ),
        Text(
          "2 hours ago",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: myFavColor),
        ),
      ],
    );

Widget myTextButton({
  required BuildContext context,
  required String label,
  Color? textColor,
  required Function onPressed,
}) =>
    TextButton(
      onPressed: () {
        onPressed();
      },
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: textColor ?? myFavColor2, fontSize: 20),
      ),
    );

void buildErrorToast({
  required BuildContext context,
  required String title,
  required String description,
  bool? showTitle,
}) =>
    CherryToast.error(
      displayTitle: showTitle ?? true,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: myFavColor2, fontSize: 16),
      ),
      description: Text(
        description,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: myFavColor8, fontSize: 12),
      ),
      animationType: AnimationType.fromTop,
      animationDuration: Duration(milliseconds: 1000),
      autoDismiss: true,
    ).show(context);

void buildSuccessToast({
  required BuildContext context,
  required String title,
  required String description,
}) =>
    CherryToast.success(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: myFavColor2, fontSize: 16),
      ),
      description: Text(
        description,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: myFavColor8, fontSize: 12),
      ),
      animationType: AnimationType.fromRight,
      animationDuration: Duration(milliseconds: 1000),
      autoDismiss: true,
    ).show(context);

PreferredSizeWidget defaultTabBar({
  required BuildContext context,
  required TabController tabController,
  required Size size,
  required List<String> itemsName,
}) =>
    TabBar(
      padding: EdgeInsets.zero,
      indicatorPadding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      controller: tabController,
      physics: const BouncingScrollPhysics(),
      indicatorColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      isScrollable: true,
      tabs: [
        Container(
          height: size.height * (24 / 780),
          width: size.width * (64 / 360),
          decoration: BoxDecoration(
            color: tabController.index == 0 ? myFavColor : myFavColor7,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: myFavColor,
            ),
          ),
          child: Tab(
            child: Text(
              itemsName[0],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: tabController.index == 0 ? myFavColor7 : myFavColor,
                  fontSize: 12),
            ),
          ),
        ),
        Container(
          height: size.height * (24 / 780),
          width: size.width * (64 / 360),
          decoration: BoxDecoration(
            color: tabController.index == 1 ? myFavColor : myFavColor7,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: myFavColor,
            ),
          ),
          child: Tab(
            child: Text(
              itemsName[1],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: tabController.index == 1 ? myFavColor7 : myFavColor,
                  fontSize: 12),
            ),
          ),
        ),
        Container(
          height: size.height * (24 / 780),
          width: size.width * (64 / 360),
          decoration: BoxDecoration(
            color: tabController.index == 2 ? myFavColor : myFavColor7,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: myFavColor,
            ),
          ),
          child: Tab(
            child: Text(
              itemsName[2],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: tabController.index == 2 ? myFavColor7 : myFavColor,
                  fontSize: 12),
            ),
          ),
        ),
        Container(
          height: size.height * (24 / 780),
          width: size.width * (64 / 360),
          decoration: BoxDecoration(
            color: tabController.index == 3 ? myFavColor : myFavColor7,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: myFavColor,
            ),
          ),
          child: Tab(
            child: Text(
              itemsName[3],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: tabController.index == 3 ? myFavColor7 : myFavColor,
                  fontSize: 12),
            ),
          ),
        ),
      ],
    );

Widget myDropDownButton({
  required BuildContext context,
  required List<String> dropMenuItems,
  required String selectedValue,
  String? validateText,
  Widget? prefix,
  String? hintText,
  Color? hintColor,
  Color? textColor,
  void Function(String?)? onChange,
  String Function(String?)? validator,
}) =>
    DropdownButtonFormField2(
      decoration: InputDecoration(
        //Add isDense true and zero Padding.
        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        contentPadding: EdgeInsets.zero,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontSize: 16, color: hintColor ?? myFavColor4),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint: Row(
        children: [
          if (prefix != null) prefix,
          if (prefix != null)
            const SizedBox(
              width: 20,
            ),
          Flexible(
            child: Text(
              hintText ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 16, color: hintColor ?? myFavColor4),
            ),
          ),
        ],
      ),
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontSize: 18, color: textColor ?? myFavColor8),
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          color: myFavColor2,
        ),
      ),
      buttonStyleData: ButtonStyleData(
          height: 48,
          padding: EdgeInsets.only(right: 10, left: 0),
          decoration: BoxDecoration(
            color: myFavColor5,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          )),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: myFavColor5,
        ),
      ),
      items: dropMenuItems
          .map((item) => DropdownMenuItem<String>(
                value: item,
                onTap: () {
                  selectedValue = item;
                },
                child: Text(
                  item,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 18, color: textColor ?? myFavColor8),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return validateText;
        }
        return null;
      },
      onChanged: onChange,
      onSaved: (value) {
        selectedValue = value.toString();
      },
    );

Widget customTextFormFieldForCardNumber({
  required BuildContext context,
  TextEditingController? controller,
  TextInputType? type,
  bool? isPassword,
  VoidCallback? onTap,
  ValueChanged<String>? onChange,
  String? Function(String?)? validate,
  ValueChanged<String>? onSubmit,
  Widget? suffixIcon,
  Widget? prefixIcon,
  Widget? icon,
  int? maxLength,
  int? maxLength2,
  Color? fillColor,
  Color? hintColor,
  Color? textColor,
  TextAlign? textAlign,
  String? hint,
  double? radius,
  int? minLines,
  int? maxLines,
  bool? isEnabled = true,
  TextInputAction? textInputAction,
  int? charSpaceCount,
}) =>
    Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius ?? 0),
        ),
        shape: BoxShape.rectangle,
      ),
      child: TextFormField(
        obscuringCharacter: '●',
        controller: controller,
        enabled: isEnabled ?? true,
        keyboardType: type,
        obscureText: isPassword ?? false,
        onTap: onTap,
        onChanged: (value) {
          if (onChange != null) {
            final oldValueSelection = controller?.selection;
            onChange(value);
            controller?.value = TextEditingValue(
              text: value,
              selection: oldValueSelection!,
            );
          }
        },
        textInputAction: textInputAction ?? TextInputAction.done,
        onFieldSubmitted: onSubmit,
        validator: validate,
        textAlign: textAlign ?? TextAlign.start,
        maxLength: maxLength,
        minLines: minLines ?? 1,
        maxLines: minLines ?? 1,
        textAlignVertical: TextAlignVertical.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength2),
          LengthLimitingTextInputFormatter(
              charSpaceCount != null ? charSpaceCount * 5 - 1 : null),
          FourCharSpaceFormatter(charSpaceCount: charSpaceCount ?? 0),
        ],
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontSize: 18, color: textColor ?? myFavColor8),
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? myFavColor5,
          border: fillColor == null
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
                  borderSide: BorderSide(
                    color: myFavColor,
                  ),
                ),
          hintText: hint ?? '',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 16, color: hintColor ?? myFavColor4),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          alignLabelWithHint: true,
        ),
      ),
    );
