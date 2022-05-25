import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/modules/social_app/Login/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class socialLoginCubit extends Cubit<socialLoginStates> {
  socialLoginCubit() : super(socialLoginInitialStats());

  static socialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(socialLoginLoadingStats());

    // FirebaseAuth.instance
    //     //     .signInWithEmailAndPassword(email: email, password: password)
    //     //     .then((value) {
    //     //   // loginModel = socialLoginModel.fromJson(value.data),
    //     //   emit(socialLoginSuccessStats(uId: value.user!.uid));
    //     //   // ignore: invalid_return_type_for_catch_error
    //     // }).catchError((error) => {
    //     //           emit(socialLoginErrorStats(error.toString())),
    //     //         });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        emit(socialLoginSuccessStats(uId: value.user!.uid));
        print(value.user!.email);
        return value;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      emit(socialLoginErrorStats(e.toString()));
    }
  }

  IconData suffix = Icons.visibility;
  bool isPassword = true;
  void changeVisibilityPassword() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(socialLoginPasswordStats());
  }
}
