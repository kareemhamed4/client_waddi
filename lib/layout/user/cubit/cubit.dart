import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:waddy_app/layout/user/cubit/states.dart';
import 'package:waddy_app/models/user/track_id_model.dart';
import 'package:waddy_app/modules/user/chat/chat_screen.dart';
import 'package:waddy_app/modules/user/home/home_screen.dart';
import 'package:waddy_app/modules/user/my_order/my_order_screen.dart';
import 'package:waddy_app/modules/user/profile/profile_screen.dart';

class UserLayoutCubit extends Cubit<UserLayoutStates> {
  UserLayoutCubit() : super(UserInitialState());
  static UserLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = const [
    ShippingHomeScreen(),
    ShippingMyOrderScreen(),
    ShippingChatScreen(),
    ShippingProfileScreen(),
  ];
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.my_library_books_outlined), label: 'my Order'),
    const BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'inBox'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarUserState());
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
