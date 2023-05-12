import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/layout/user/cubit/cubit.dart';
import 'package:waddy_app/layout/user/cubit/states.dart';

class UserLayoutScreen extends StatelessWidget {
  const UserLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var cubit = UserLayoutCubit.get(context);
    return BlocConsumer<UserLayoutCubit, UserLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: SizedBox(
            height: size.height * 65/780,
            child: BottomNavigationBar(
              items: cubit.bottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottom(index,context);
              },
            ),
          ),
        );
      },
    );
  }
}
