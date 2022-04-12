import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/models/social_model/social_model.dart';
import 'package:flutter_appp/modules/social_app/Register/register/cubit/states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class socialRegisterCubit extends Cubit<socialRegisterStates> {
  socialRegisterCubit() : super(socialRegisterInitialStats());

  static socialRegisterCubit get(context) => BlocProvider.of(context);
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(socialRegisterLoadingStats());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);

      UserCreate(
        uId: value.user!.uid,
        name: name,
        email: email,
        phone: phone,
      );
    }).catchError((error) {
      print(error.toString());
      emit(socialRegisterErrorStats(error.toString()));
    });
  }

  void UserCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
        name: name,
        phone: phone,
        email: email,
        uId: uId,
        bio: 'write your story ...',
        image:
            'https://img.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg?w=740&t=st=1649496586~exp=1649497186~hmac=09b7eeea2eae37ba8b619f9d98f8e8ed351fd209b559389c30e5ea30329bc6e6',
        cover:
            'https://img.freepik.com/free-photo/beautiful-shot-high-white-hilltops-mountains-covered-fog_181624-399.jpg?w=900&t=st=1649496670~exp=1649497270~hmac=ee2ed1795f9b00e4d5da499aae5162a792cf2a77310115f5baeb89f68b37d665',
        isEmailVerified: false);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialUserCreateSuccessStats());
    }).catchError((error) {
      emit(SocialUserCreateErrorStats(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(socialRegisterPasswordStats());
  }
}
