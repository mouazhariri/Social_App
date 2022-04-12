import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/state.dart';
import 'package:flutter_appp/models/social_model/social_model.dart';
import 'package:flutter_appp/modules/social_app/Add_Post/Add_Post.dart';
import 'package:flutter_appp/modules/social_app/Chatts/chats.dart';
import 'package:flutter_appp/modules/social_app/HomePage/HomePage.dart';
import 'package:flutter_appp/modules/social_app/Search/Social_Search.dart';
import 'package:flutter_appp/modules/social_app/Setting/Setting.dart';
import 'package:flutter_appp/modules/social_app/Users/Social_Users.dart';
import 'package:flutter_appp/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context) => BlocProvider.of(context);

  late SocialUserModel userModel;

  void getUserData() async {
    emit(SocialLoadingHomeStates());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialSuccessHomeStates());
    }).catchError((error) {
      // print(error.toString());
      emit(SocialErrorHomeStates(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    HomePage(),
    Chats(),
    AddPost(),
    Users(),
    SocialSetting()
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 2)
      emit(SocialAddPostStates());
    else {
      currentIndex = index;
      emit(SocialChangeNavBarStates());
    }
  }
}
