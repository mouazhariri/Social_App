// POST
// UPDATE
// DELETE

// GET

// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

//search :https://newsapi.org/
// v2/everything?
// q=tesla&apiKey=0ae97745667048e69851b7ff496bf7d5

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/state.dart';
import 'package:flutter_appp/models/social_model/social_model.dart';
import 'package:flutter_appp/modules/shop_app/on_boarding/login/shop_login_screen.dart';
import 'package:flutter_appp/modules/shop_app/on_boarding/login/shop_login_screen.dart';
import 'package:flutter_appp/modules/social_app/Login/social_Login.dart';
import 'package:flutter_appp/shared/Network/Local/cache_helper.dart';
import 'package:flutter_appp/shared/components/components.dart';

void logOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateToAndFinish(context, ShopLoginScreen());
    }
  });
}

void logOuts(context) {
  CacheHelper.removeData(key: 'uId').then((value) {
    if (value) {
      navigateToAndFinish(context, SocialLogin());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
String? uId = '';
String tokenFire = '';
//List<String> IsLiked = [];
//
//   Future<void> getLike(String? postId) async {
//     await FirebaseFirestore.instance
//         .collection('Posts')
//         .doc(postId!)
//         .get()
//         .then((value) {
//       IsLiked = List<String>.from(value.data()!['Like']);
//     });
//   }
//
//   void likeUnlikePost(String? postId) {
//     getLike(postId).then((value) {
//       IsLiked.contains(userModel!.uId)
//           ? unlikePost(postId!)
//           : likePost(postId!);
//     });
//   }
//   // void isLike(index, String postId) {
//   //   // for (int i = 0; i < Islike.length;) {
//   //   //   if (i == index)
//   //   //     Islike[i] = true;
//   //   //   else
//   //   //     Islike[i] = false;
//   //   // }
//   //
//   //   FirebaseFirestore.instance
//   //       .collection('Posts')
//   //       .doc(postId)
//   //       .collection('Like')
//   //       .doc(userModel!.uId)
//   //       .update({
//   //     'like': true,
//   //   }).then((value) {
//   //     emit(SocialLikePostSuccessStates());
//   //   });
//   //   Islike = index;
//   //   emit(isLikeState());
//   // }
//
//   void likePost(String postId) {
//     emit(SocialLikePostLoadingStates());
//     FirebaseFirestore.instance.collection('Posts').doc(postId)
//         // .collection('Like')
//         // .doc(userModel!.uId)
//         .update({
//       'Like': FieldValue.arrayUnion([userModel!.uId]),
//     }).then((value) {
//       modelPost.forEach((element) {
//         if (element.uId == postId) element.Like.add(userModel!.uId.toString());
//       });
//       userModel!.uPost?.forEach((element) {
//         if (element.uId == postId) element.Like.add(userModel!.uId.toString());
//       });
//       emit(SocialLikePostSuccessStates());
//     });
//   }
//
//   void unlikePost(String postId) {
//     FirebaseFirestore.instance
//         .collection('Posts')
//         .doc(postId)
//         .collection('Like')
//         .doc('${userModel!.uId}')
//         .update({
//       'Like': FieldValue.arrayUnion([userModel!.uId]),
//     }).then((value) {
//       modelPost.forEach((element) {
//         if (element.uId == postId) element.Like.add(userModel!.uId.toString());
//       });
//       userModel!.uPost?.forEach((element) {
//         if (element.uId == postId) element.Like.add(userModel!.uId.toString());
//       });
//       emit(UnlikePostSuccessState());
//     }).catchError((error) {
//       emit(UnlikePostErrorState());
//     });
//   }
