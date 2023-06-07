import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waddy_app/bloc_observer.dart';
import 'package:waddy_app/cubit/driver/cubit.dart';
import 'package:waddy_app/cubit/user/cubit.dart';
import 'package:waddy_app/cubit/user/states.dart';
import 'package:waddy_app/layout/driver/cubit/cubit.dart';
import 'package:waddy_app/layout/user/cubit/cubit.dart';
import 'package:waddy_app/modules/common/otp/cubit/cubit.dart';
import 'package:waddy_app/modules/common/forget_password/cubit/cubit.dart';
import 'package:waddy_app/modules/common/new_password/cubit/cubit.dart';
import 'package:waddy_app/modules/common/splash/first_splash.dart';
import 'package:waddy_app/modules/driver/edit_password/cubit/cubit.dart';
import 'package:waddy_app/modules/driver/inbox/cubit/cubit.dart';
import 'package:waddy_app/modules/driver/orders/cubit/cubit.dart';
import 'package:waddy_app/modules/driver/profile/cubit/cubit.dart';
import 'package:waddy_app/modules/user/check_rate/cubit/cubit.dart';
import 'package:waddy_app/modules/user/edit_password/cubit/cubit.dart';
import 'package:waddy_app/modules/user/help_center/cubit/cubit.dart';
import 'package:waddy_app/modules/user/inbox/cubit/cubit.dart';
import 'package:waddy_app/modules/user/my_orders/cubit/cubit.dart';
import 'package:waddy_app/modules/user/new_make_order/cubit/cubit.dart';
import 'package:waddy_app/modules/user/new_register/cubit/cubit.dart';
import 'package:waddy_app/modules/user/profile/cubit/cubit.dart';
import 'package:waddy_app/modules/user/register/cubit/cubit.dart';
import 'package:waddy_app/network/local/cache_helper.dart';
import 'package:waddy_app/network/remote/dio_helper.dart';
import 'package:waddy_app/shared/constants/constants.dart';
import 'package:waddy_app/shared/styles/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  currentLocationAsString = CacheHelper.getData(key: 'currentLocation');
  bool? isDark = CacheHelper.getData(key: 'isDark') ?? false;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');
  userToken = CacheHelper.getData(key: 'userToken');
  driverToken = CacheHelper.getData(key: 'driverToken');

  Widget widget;
  if (onBoarding != null) {
    if (userToken != null) {
      widget = const FirstSplashScreen(isUserLoginBefore: true);
    } else if (driverToken != null) {
      widget = const FirstSplashScreen(isDelegateLoginBefore: true);
    } else {
      widget = const FirstSplashScreen(isNoLoginDetected: true);
    }
  } else {
    widget = const FirstSplashScreen(isFirstTime: true);
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  const MyApp({super.key, this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
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
        BlocProvider(
            create: (BuildContext context) => UserLayoutCubit()
              ..getUserData()
              ..getUserDataFromFB()
              ..getAllUsersFromFB()
              ..getUsersWithChat()),
        BlocProvider(create: (BuildContext context) => DriverLayoutCubit()),
        BlocProvider(create: (BuildContext context) => DriverInboxCubit()),
        BlocProvider(create: (BuildContext context) => UserInboxCubit()),
        BlocProvider(create: (BuildContext context) => SignUpCubit()),
        BlocProvider(create: (BuildContext context) => ForgetPasswordCubit()),
        BlocProvider(create: (BuildContext context) => VerifyOTPCubit()),
        BlocProvider(create: (BuildContext context) => UpdatePasswordCubit()),
        BlocProvider(create: (BuildContext context) => UserProfileCubit()),
        BlocProvider(create: (BuildContext context) => DriverProfileCubit()..getDriverData()),
        BlocProvider(create: (BuildContext context) => EditPasswordForAuthDriverCubit()),
        BlocProvider(create: (BuildContext context) => EditPasswordForAuthUserCubit()),
        BlocProvider(create: (BuildContext context) => NewMakeOrderCubit()),
        BlocProvider(create: (BuildContext context) => GetUserOrdersCubit()..getOrders()),
        BlocProvider(create: (BuildContext context) => HelpCenterCubit()),
        BlocProvider(create: (BuildContext context) => CheckRateCubit()),
        BlocProvider(create: (BuildContext context) => NewRegisterCubit()),
        BlocProvider(
            create: (BuildContext context) => DriverOrdersCubit()
              ..getOrdersRelatedToDelegate()
              ..getDriverAllOrders()),
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
            child: ScreenUtilInit(
                designSize: const Size(375, 812),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, child) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: lightTheme,
                    darkTheme: darkTheme,
                    themeMode: UserCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
                    home: startWidget,
                  );
                }),
          );
        },
      ),
    );
  }
}
