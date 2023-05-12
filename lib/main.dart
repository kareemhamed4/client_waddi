import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/bloc_observer.dart';
import 'package:waddy_app/cubit/driver/cubit.dart';
import 'package:waddy_app/cubit/user/cubit.dart';
import 'package:waddy_app/cubit/user/states.dart';
import 'package:waddy_app/layout/driver/cubit/cubit.dart';
import 'package:waddy_app/layout/user/cubit/cubit.dart';
import 'package:waddy_app/layout/user/layout_screen.dart';
import 'package:waddy_app/modules/common/choose_login_signup/choose_login_signup_screen.dart';
import 'package:waddy_app/modules/common/forget_password/cubit/cubit.dart';
import 'package:waddy_app/modules/common/login/waddy_login_screen.dart';
import 'package:waddy_app/modules/common/new_password/cubit/cubit.dart';
import 'package:waddy_app/modules/common/onboarding/waddy_on_boarding_screen.dart';
import 'package:waddy_app/modules/common/otp/cubit/cubit.dart';
import 'package:waddy_app/modules/common/register/cubit/cubit.dart';
import 'package:waddy_app/modules/driver/edit_password/cubit/cubit.dart';
import 'package:waddy_app/modules/driver/inbox/cubit/cubit.dart';
import 'package:waddy_app/modules/user/edit_password/cubit/cubit.dart';
import 'package:waddy_app/modules/user/make_order/cubit/cubit.dart';
import 'package:waddy_app/modules/user/my_orders/cubit/cubit.dart';
import 'package:waddy_app/modules/user/profile/cubit/cubit.dart';
import 'package:waddy_app/shared/components/constants.dart';
import 'package:waddy_app/shared/network/local/cache_helper.dart';
import 'package:waddy_app/shared/network/remote/dio_helper.dart';
import 'package:waddy_app/shared/styles/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  currentLocationAsString = CacheHelper.getData(key: 'currentLocation');
  bool? isDark = CacheHelper.getData(key: 'isDark') ?? false;
  bool? onBoarding = CacheHelper.getData(key: 'firstSplash');

  Widget widget;

  String? token = CacheHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null) {
      widget = const UserLayoutScreen();
    } else {
      widget = WaddyLoginScreen();
    }
  } else {
    widget = const WaddyOnBoardingScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  const MyApp({super.key, this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => UserCubit()
            ..changeAppMode(
              fromShared: isDark,
            )
            ..getMyCurrentLocation(),
        ),
        BlocProvider(
          create: (BuildContext context) => DriverCubit()
            ..changeAppMode(
              fromShared: isDark,
            )
            ..getMyCurrentLocation(),
        ),
        BlocProvider(create: (BuildContext context) => UserLayoutCubit()),
        BlocProvider(create: (BuildContext context) => DriverLayoutCubit()),
        BlocProvider(create: (BuildContext context) => DriverInboxCubit()),
        BlocProvider(create: (BuildContext context) => SignUpCubit()),
        BlocProvider(create: (BuildContext context) => ForgetPasswordCubit()),
        BlocProvider(create: (BuildContext context) => VerifyOTPCubit()),
        BlocProvider(create: (BuildContext context) => UpdatePasswordCubit()),
        BlocProvider(create: (BuildContext context) => UserProfileCubit()..getUserData()),
        BlocProvider(create: (BuildContext context) => EditPasswordForAuthDriverCubit()),
        BlocProvider(create: (BuildContext context) => EditPasswordForAuthUserCubit()),
        BlocProvider(create: (BuildContext context) => MakeOrderCubit()),
        BlocProvider(create: (BuildContext context) => GetUserOrdersCubit()..getOrders()),
      ],
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          UserCubit cubit = BlocProvider.of(context);
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: !cubit.isDark
                ? const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.dark,
                    systemNavigationBarColor: Colors.transparent,
                    systemNavigationBarIconBrightness: Brightness.dark)
                : const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light,
                    systemNavigationBarColor: Colors.transparent,
                    systemNavigationBarIconBrightness: Brightness.light,
                    statusBarBrightness: Brightness.light,
                  ),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: UserCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: const ChooseLoginOrSignupScreen(),
            ),
          );
        },
      ),
    );
  }
}
