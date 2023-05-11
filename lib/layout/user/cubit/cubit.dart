import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:waddy_app/custom_icons_icons.dart';
import 'package:waddy_app/layout/user/cubit/states.dart';
import 'package:waddy_app/models/user/track_id_model.dart';
import 'package:waddy_app/modules/user/home/home_screen.dart';
import 'package:waddy_app/modules/user/inbox/inbox_screen.dart';
import 'package:waddy_app/modules/user/my_orders/my_order_screen.dart';
import 'package:waddy_app/modules/user/profile/profile_screen.dart';

class UserLayoutCubit extends Cubit<UserLayoutStates> {
  UserLayoutCubit() : super(UserInitialState());
  static UserLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = const [
    UserHomeScreen(),
    UserMyOrderScreen(),
    UserInboxScreen(),
    UserProfileScreen(),
  ];
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(CustomIcons.doc_text_inv), label: 'My Order'),
    const BottomNavigationBarItem(icon: Icon(CustomIcons.chat), label: 'Inbox'),
    const BottomNavigationBarItem(icon: Icon(CustomIcons.user_alt), label: 'Profile'),
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
