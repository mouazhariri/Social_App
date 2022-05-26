import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/shop_app/shop_Layout.dart';
import 'package:flutter_appp/main.dart';
import 'package:flutter_appp/modules/shop_app/on_boarding/login/shop_login_screen.dart';
import 'package:flutter_appp/modules/shop_app/on_boarding/onboarding/on_boarding_screen.dart';
import 'package:flutter_appp/shared/Network/Local/cache_helper.dart';
import 'package:flutter_appp/shared/Network/remote/dio_helper.dart';
import 'package:flutter_appp/shared/bloc_observer.dart';
import 'package:flutter_appp/shared/components/constants.dart';
import 'package:flutter_appp/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  final Widget sstartWidget;

  const SplashScreen({required this.sstartWidget});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => widget.sstartWidget));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/shoppmoon.png'),
              fit: BoxFit.fill)),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Image.asset(
          //   'assets/images/shoppmoon.png',
          //   fit: BoxFit.cover,
          // ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      )),
    );
  }
}
