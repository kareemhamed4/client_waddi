import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/layout/cubit/cubit.dart';
import 'package:waddy_app/layout/cubit/states.dart';

class Waddylayout extends StatelessWidget {
  const Waddylayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = ShippingCubit.get(context);
    return BlocConsumer<ShippingCubit, ShippingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottom(index);
            },
          ),
        );
      },
    );
  }
}
