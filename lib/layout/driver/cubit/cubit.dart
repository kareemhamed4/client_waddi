import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:waddy_app/layout/driver/cubit/states.dart';
import 'package:waddy_app/models/user/track_id_model.dart';
import 'package:waddy_app/modules/driver/home/home_screen.dart';
import 'package:waddy_app/modules/driver/orders/orders_screen.dart';
import 'package:waddy_app/modules/user/chat/chat_screen.dart';
import 'package:waddy_app/modules/user/profile/profile_screen.dart';

class DriverLayoutCubit extends Cubit<DriverLayoutStates> {
  DriverLayoutCubit() : super(DriverInitialState());
  static DriverLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = const [
    DriverHomeScreen(),
    DriverOrdersScreen(),
    SizedBox(),
    ShippingChatScreen(),
    ShippingProfileScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarDriverState());
  }

  List<TrackIdModel> trackId = [];
  getTackId() async {
    Response response = await http
        .get(Uri.parse('http://localhost:8080/client/order/track/:trackId'));
    var responseBody = jsonDecode(response.body);
    debugPrint('Track id is : $responseBody');
    if (responseBody['status'] == 200) {}
  }
}
