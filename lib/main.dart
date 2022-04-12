import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/news_app/Cubit/State.dart';
import 'package:flutter_appp/Layout/shop_app/cubit/cubit.dart';
import 'package:flutter_appp/Layout/shop_app/shop_Layout.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/cubit.dart';
import 'package:flutter_appp/Layout/social_app/social_screen.dart';
import 'package:flutter_appp/modules/Splash_Screens/Shop_Splach.dart';
import 'package:flutter_appp/modules/bmi_app/bmi/bmi_calculator.dart';
import 'package:flutter_appp/modules/social_app/Login/social_Login.dart';
import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_appp/shared/styles/colors.dart';
import 'modules/shop_app/on_boarding/onboarding/on_boarding_screen.dart';

import 'package:flutter_appp/shared/Network/Local/cache_helper.dart';
import 'package:flutter_appp/shared/Network/remote/dio_helper.dart';
import 'package:flutter_appp/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'Layout/news_app/Cubit/cubit.dart';
import 'Layout/news_app/Cubit/dark_light(toggle).dart';

import 'package:flutter_appp/shared/bloc_observer.dart';

import 'modules/shop_app/on_boarding/login/shop_login_screen.dart';
import 'shared/components/constants.dart';

bool isFirebaseReady = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().catchError((e) {
    isFirebaseReady = false;
    print(e);
  });
  ;
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  //
  // token = CacheHelper.getData(key: 'token');
  uId = CacheHelper.getData(key: 'uId');
  // print(token);
  // if (onBoarding != null) {
  //   if (token != null)
  //     widget = ShopLayout();
  //   else
  //     widget = ShopLoginScreen();
  // } else {
  //   widget = OnBoardingScreen();
  // }
  if (uId != null) {
    widget = SocialScreen();
  } else {
    widget = SocialLogin();
  }

  BlocOverrides.runZoned(
      () => runApp(MyApp(
            isDark: isDark,
            startWidget: widget,
          )),
      blocObserver: MyBlocObserver()); //Bloc ob server
}

class MyApp extends StatelessWidget {
  bool? isDark;
  Widget? startWidget;

  MyApp({this.isDark, this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        BlocProvider(
          create: (BuildContext context) => ModeChangeCubit()
            ..appChangeMode(
              fromShared: isDark!,
            ),
        ),
        BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUser()),
        BlocProvider(create: (context) => SocialCubit()..getUserData()),
      ],
      child: BlocConsumer<ModeChangeCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: socialLightTheme,
              darkTheme: socialDarkTheme,
              themeMode: ModeChangeCubit.get(context).isDark
                  ? ThemeMode.light
                  : ThemeMode.dark,
              home: BmiCalculator()
              // SplashScreen(
              //   sstartWidget: startWidget,
              // )
              //       Directionality(
              //
              //           textDirection: TextDirection.ltr,
              //           // child: onBoarding ? ShopLoginScreen() :OnBoardingScreen ()),
              // child:

              // ),
              );
        },
      ),
    );
  }
}
