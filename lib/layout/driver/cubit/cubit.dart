import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/layout/driver/cubit/states.dart';
import 'package:waddy_app/modules/driver/home/home_screen.dart';
import 'package:waddy_app/modules/driver/inbox/inbox_screen.dart';
import 'package:waddy_app/modules/driver/orders/orders_screen.dart';
import 'package:waddy_app/modules/driver/profile/profile_screen.dart';

class DriverLayoutCubit extends Cubit<DriverLayoutStates> {
  DriverLayoutCubit() : super(DriverInitialState());
  static DriverLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = const [
    DriverHomeScreen(),
    DriverOrdersScreen(),
    SizedBox(),
    DriverInboxScreen(),
    DriverProfileScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarDriverState());
  }
}
