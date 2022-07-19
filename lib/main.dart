import 'dart:io';

import 'package:desktop_window/desktop_window.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/news_app/Cubit/State.dart';
import 'package:flutter_appp/Layout/news_app/news_layout.dart';

import 'package:flutter_appp/shared/Network/Local/cache_helper.dart';
import 'package:flutter_appp/shared/Network/remote/dio_helper.dart';

import 'package:flutter_appp/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Layout/news_app/Cubit/cubit.dart';
import 'Layout/news_app/Cubit/dark_light(toggle).dart';
import 'package:flutter_appp/shared/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding();
  WidgetsFlutterBinding.ensureInitialized();
//
  if (Platform.isWindows) await DesktopWindow.setMinWindowSize(Size(400, 650));
  //

  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');

  BlocOverrides.runZoned(
      () => runApp(MyApp(
            isDark: isDark,
          )),
      blocObserver: MyBlocObserver()); //Bloc ob server
}

class MyApp extends StatelessWidget {
  bool? isDark;

  MyApp({
    this.isDark,
  });
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
              fromShared: isDark,
            ),
        ),
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
              home: NewsLayout()

              // SplashSocialScreen(
              //   sstartWidget: startWidget,
              // )
              //       Directionality(
              //
              //           textDirection: TextDirection.ltr,
              //           // child: onBoarding ? ShopLoginScreen() :OnBoardingScreen ()),
              // child:

              // ),
              //   screenTypeLayout(
              //     mobile:,
              //   desktop:,
              // ),//responsive builder
              );
        },
      ),
    );
  }
}
