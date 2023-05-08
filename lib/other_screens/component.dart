import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  TextInputType? type,
  bool ispassword = false,
  required String label,
  IconData? prefix,
  String? Function(String? value)? validate,
  IconData? suffix,
  VoidCallback? suffix_pressed,
  double height = 50,
  String? suffixText,
}) =>
    Container(
      height: height,
      color: Color.fromRGBO(250, 250, 250, 1),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            prefix,
            color: Color.fromRGBO(255, 75, 84, 1),
          ),
          suffixText: suffixText,
          suffixIcon: IconButton(
            icon: Icon(
              suffix,
              color: Color.fromRGBO(255, 75, 84, 1),
            ), 
            onPressed: suffix_pressed,
          ),
          border: OutlineInputBorder(),
        ),
        keyboardType: type,
        onFieldSubmitted: (String value) {
          print(value);
        },
        obscureText: ispassword,
        controller: controller,
        validator: validate ,
        cursorColor: Color.fromRGBO(255, 75, 84, 1),
        
      ),
    );



Widget defaultButton({
  double width = double.infinity,
  double height =50,
  Color background = const Color.fromRGBO(255, 75, 84, 1),
  bool isUpperCase = true,
  double borderRadius = 30,
  required VoidCallback function,
  required String text,
}) => Container(
  width: width,
  height: height,
  child: MaterialButton(
    onPressed: function ,
    child:  Text(
      isUpperCase? text.toUpperCase() : text,
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(borderRadius),
    color: background,
  ),
);