import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waddy_app/bloc_observer.dart';
import 'package:waddy_app/cubit/cubit.dart';
import 'package:waddy_app/cubit/states.dart';
import 'package:waddy_app/layout/cubit/cubit.dart';
import 'package:waddy_app/layout/layout_screen.dart';
import 'package:waddy_app/modules/login/waddy_login_screen.dart';
import 'package:waddy_app/modules/onboarding/waddy_on_boarding_screen.dart';
import 'package:waddy_app/shared/network/local/cache_helper.dart';
import 'package:waddy_app/shared/network/remote/dio_helper.dart';
import 'package:waddy_app/shared/styles/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark') ?? false;
  bool? onBoarding = CacheHelper.getData(key: 'firstSplash');

  Widget widget;

  String? token = CacheHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null) {
      widget = const Waddylayout();
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
          create: (BuildContext context) =>
              AppCubit()..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(create: (BuildContext context) => ShippingCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = BlocProvider.of(context);
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
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: const WaddyOnBoardingScreen(),
            ),
          );
        },
      ),
    );
  }
}
