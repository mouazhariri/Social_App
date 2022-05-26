import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cub/State.dart';
import 'package:flutter_appp/Layout/cub/dark_light(toggle).dart';

import 'package:flutter_appp/Layout/social_app/Cubit/cubit.dart';
import 'package:flutter_appp/Layout/social_app/social_screen.dart';
import 'package:flutter_appp/modules/Splash_Screens/Social_Splach.dart';

import 'package:flutter_appp/modules/social_app/Login/social_Login.dart';
import 'package:flutter_appp/shared/Network/Local/cache_helper.dart';
import 'package:flutter_appp/shared/Network/remote/dio_helper.dart';
import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_appp/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_appp/shared/bloc_observer.dart';
import 'shared/components/constants.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
  print(message.data.toString());

  showToast(
    message: 'on background message',
    state: toastState.Success,
  );
}

void main() async {
  WidgetsFlutterBinding();
  WidgetsFlutterBinding.ensureInitialized();
//
  if (Platform.isWindows) await DesktopWindow.setMinWindowSize(Size(400, 650));
  //
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  //foreground fcm//when the app was open
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(
      message: 'New message',
      state: toastState.Warning,
    );
  });
//when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(
      message: 'New messages',
      state: toastState.Success,
    );
  });
//background fcm // show the message on background
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  // bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  //
  // token = CacheHelper.getData(key: 'token');// print(token);
  //   // if (onBoarding != null) {
  //   //   if (token != null)
  //   //     widget = ShopLayout();
  //   //   else
  //   //     widget = ShopLoginScreen();
  //   // } else {
  //   //   widget = OnBoardingScreen();
  //   // }
  uId = CacheHelper.getData(key: 'uId') ?? '';

  if (uId != '') {
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
  final Widget startWidget;

  MyApp({this.isDark, required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ModeChangeCubit()
            ..appChangeMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData()
              ..getPost()
              ..getComment()),
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
              home: SplashSocialScreen(
                sstartWidget: startWidget,
              )
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
