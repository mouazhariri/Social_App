import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/social_app/Cubit/state.dart';
import 'package:flutter_appp/models/social_model/Chat_model.dart';
import 'package:flutter_appp/models/social_model/Post_model.dart';
import 'package:flutter_appp/models/social_model/comment_model.dart';
import 'package:flutter_appp/models/social_model/social_model.dart';
import 'package:flutter_appp/modules/social_app/Add_Post/Add_Post.dart';
import 'package:flutter_appp/modules/social_app/Chatts/chats.dart';
import 'package:flutter_appp/modules/social_app/HomePage/HomePage.dart';
import 'package:flutter_appp/modules/social_app/Register/register/cubit/states.dart';
import 'package:flutter_appp/modules/social_app/Search/Social_Search.dart';
import 'package:flutter_appp/modules/social_app/Setting/Setting.dart';
import 'package:flutter_appp/modules/social_app/Users/Social_Users.dart';
import 'package:flutter_appp/shared/components/components.dart';
import 'package:flutter_appp/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../shared/Network/Local/cache_helper.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialStates());

  get index => null;

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  PostModel? postModel;

  void getUserData() async {
    emit(SocialLoadingHomeStates());

    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      //value.data()
      userModel = SocialUserModel.fromJson(value.data()!);

      emit(SocialSuccessHomeStates());
    }).catchError((error) {
      // print(error.toString());
      emit(SocialErrorHomeStates(error.toString()));
    });
  }

  List<SocialUserModel> users = [];
  void getAllUsers() {
    //
    users = [];
    if (users.length == 0)
      FirebaseFirestore.instance.collection('Users').get().then((value) {
        //element content one of doc
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId)
            users.add(SocialUserModel.fromJson(element.data()));
        });
        emit(SocialGetAllUsersSuccessStates());
      }).catchError((error) {
        print(error);
        emit(SocialGetAllUsersErrorStates(error.toString()));
      });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    HomePage(),
    Chats(),
    AddPost(),
    Users(),
    SocialProfile()
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Profile',
  ];

  void changeBottomNav(int index) {
    if ((index == 1) || (index == 3)) {
      getAllUsers();
    }
    if (index == 2)
      emit(SocialAddPostStates());
    else {
      currentIndex = index;
      emit(SocialChangeNavBarStates());
    }
  }

  File? profileImage;

  Future<void> getProfileImage() async {
    emit(SocialProfileImagePickedLoadingStates());

    final PickerImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickerImage != null) {
      profileImage = File(PickerImage.path);
      emit(SocialProfileImagePickedSuccessStates());
    } else {
      print('No images selected');
      emit(SocialProfileImagePickedErrorStates());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final PickerCover =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickerCover != null) {
      coverImage = File(PickerCover.path);
      emit(SocialCoverImagePickedSuccessStates());
    } else {
      print('No images selected');
      emit(SocialCoverImagePickedErrorStates());
    }
  }

  // late String profileImageUrl = '';

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserCreateLoadingStats());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((imageUrl) {
        updateData(name: name, phone: phone, bio: bio, image: imageUrl);
        emit(SocialUploadProfileImageSuccessStates());
      }).catchError((error) {
        print(error);

        emit(SocialUploadProfileImageErrorStates());
      });
    }).catchError((error) {
      print(error);
      emit(SocialUploadProfileImageErrorStates());
    });
  }

  // late String coverImageUrl;
  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        //go in the storage
        .ref()
        //how move in storage and get last path to save it
        .child('Users/${Uri.file(coverImage!.path).pathSegments.last}')
        //start upload
        .putFile(coverImage!)
        .then((value) {
      //take link
      value.ref.getDownloadURL().then((coverUrl) {
        updateData(name: name, phone: phone, bio: bio, cover: coverUrl);
      }).catchError((error) {});
    }).catchError((error) {});
  }

  Future<void> updateUserData({
    required String name,
    required String phone,
    required String bio,
  }) async {
    emit(SocialUserCreateLoadingStats());
    if (coverImage != null && profileImage != null) {
      uploadCoverImage(name: name, phone: phone, bio: bio);
      uploadProfileImage(
        name: name,
        phone: phone,
        bio: bio,
      );
    } else if (profileImage != null) {
      uploadProfileImage(
        name: name,
        phone: phone,
        bio: bio,
      );
    } else if (coverImage != null) {
      uploadCoverImage(name: name, phone: phone, bio: bio);
    } else
      updateData(name: name, phone: phone, bio: bio);
  }

  void updateData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    emit(SocialUserCreateLoadingStats());
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      uId: userModel!.uId,
      image: image == null ? userModel!.image : image,
      cover: cover ?? userModel!.cover,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel?.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUpdateUserErrorStates());
    });
  }

  //post
  File? postImage;
  Future<void> getPostImage() async {
    final PickerPost =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickerPost != null) {
      postImage = File(PickerPost.path);
      emit(SocialPostImagePickedSuccessStates());
    } else {
      print('No images selected');
      emit(SocialPostImagePickedErrorStates());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemoveImageStates());
  }

  void removeCommentImage() {
    commentImage = null;
    emit(SocialRemoveCommentImageStates());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    // emit(SocialCreatePostLoadingStates());
    firebase_storage.FirebaseStorage.instance
        //go in the storage
        .ref()
        //how move in storage and get last path to save it
        .child('Posts/${Uri.file(postImage!.path).pathSegments.last}')
        //start upload
        .putFile(postImage!)
        .then((value) {
      //take link
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, ImagePost: value);
      }).catchError((error) {
        emit(SocialCreatePostErrorStates());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorStates());
    });
  }

  PostModel? model;
  void createPost({
    required String? dateTime,
    required String? text,
    String? ImagePost,
  }) {
    emit(SocialCreatePostLoadingStates());
    PostModel model = PostModel(
      name: userModel!.name!,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      PostImage: ImagePost ?? '',
    );
    FirebaseFirestore.instance
        .collection('Posts')
        //set:put the model under doc /add:add another doc and put model under it
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessStates());
    }).catchError((error) {
      emit(SocialCreatePostErrorStates());
    });
  }

  void getSinglePost(String postId) {
    emit(SocialGetsinglePostLoading());
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .get()
        .then((value) {
      value.reference.collection('Like').get().then((value) {
        postsLikesbymap[postId] = value.docs.length;
        emit(SocialGetSinglepostLikesSuccess());
      }).catchError(onError);
      value.reference.collection('comments').get().then((value) {
        postsCommentbymap[postId] = value.docs.length;
        emit(SocialGetSinglepostCommentsSuccess());
      }).catchError(onError);
      emit(SocialGetsinglePostSuccess());
    }).catchError((e) {
      emit(SocialGetsinglePostError());
      print(e.toString());
    });
  }

  List<dynamic> postsnumber = [];
  void getpostsnumber() {
    postsnumber = [];
    FirebaseFirestore.instance.collection('Posts').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] == uId) postsnumber.add(element.data());
      });
    });
  }

  //post
  List<PostModel> myPost = [];
  //like
  List<PostModel> modelPost = [];
  List<String> mylikedpostslist = [];

  List<String> postId = [];
  // Map<String, int> commentsNumber = {};

  // void getPost() {
  //   // emit(SocialGetPostLoadingStates());
  //   FirebaseFirestore.instance.collection('Posts').get().then((value) {
  //     for (var element in value.docs) {
  //       element.reference.collection('Like').get().then(
  //         (value) {
  //           modelPost.add(PostModel.fromJson(element.data()));
  //           Like.add(value.docs.length);
  //           postId.add(element.id);
  //         },
  //       ).catchError(
  //         (error) {},
  //       );
  //     }
  //     emit(SocialGetPostSuccessStates());
  //   }).catchError(
  //     (error) {
  //       print('error << $error >>');
  //       emit(SocialGetPostErrorStates(error));
  //     },
  //   );
  // }

  void deletepost(String postid, context) {
    emit(SocialDeletePostLoadingState());
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postid)
        .collection('comments')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
        emit(DeletePostSuccessState());
        getPost();
        getpostsnumber();
      });
    }).catchError(onError);
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postid)
        .collection('Like')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
        emit(DeletePostSuccessState());
        getPost();
        getpostsnumber();
      });
    }).catchError(onError);

    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postid)
        .delete()
        .then((value) {
      emit(DeletePostSuccessState());
      getpostsnumber();
      Navigator.pop(context);
    }).catchError((e) {
      emit(SocialDeletePostErrorState());
      print(e.toString());
    });
  }

  List<int> Like = [];

  Map<String, int> postsLikesbymap = ({}); //likes
  Map<String, int> postsCommentbymap = ({}); //comment
  //
  void getPost() {
    mylikedpostslist = [];
    postsLikesbymap = ({});
    postsCommentbymap = ({});
    modelPost = [];
    postId = [];
    users = [];
    myPost = [];
    emit(SocialGetPostLoadingStates());

    FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('dateTime')
        .get()
        .then((value) {
      //element content one of doc
      value.docs.forEach((element) {
        if (element.data()['uId'] == FirebaseAuth.instance.currentUser!.uid) {
          myPost.add(PostModel.fromJson(element.data()));
        }
        element.reference.collection('comments').get().then((value) {
          postsCommentbymap.addAll({element.id: value.docs.length});
          // commentsModel.add(CommentModel.fromJson(element.data()));

          // commentsNumber.add(value.docs.length);
          // postComments.add(element.id);
        }).catchError((error) {});
        // emit(SocialGetPostSuccessStates());
        element.reference.collection('Like').get().then((value) {
          postsLikesbymap.addAll({element.id: value.docs.length});
          postId.add(element.id);
          value.docs.forEach((e) {
            if (e.id == userModel!.uId!) {
              mylikedpostslist.add(element.id);
            }
          });
          modelPost.add(PostModel.fromJson(element.data()));
          emit(SocialgetlikesNumberSuccessState());

          emit(SocialGetPostSuccessStates());
        }).catchError(((e) {
          print(e.toString());
        }));
      });

      // value.docs.forEach((element) {
      //   element.reference.collection('Like').get().then((value) {
      //     modelPost.add(PostModel.fromJson(element.data()));
      //     // Islike.add(value.docs.length);
      //     // IsLiked.add(value.docs.length);
      //     Like.add(value.docs.length);
      //     postId.add(element.id);
      //   }).catchError((error) {});
      //   // emit(SocialGetPostSuccessStates());
      // });
      emit(SocialGetPostSuccessStates());
    }).catchError((error) {
      print(error);
      emit(SocialGetPostErrorStates(error.toString()));
    });
  }

///////////////////////////////////////////////////////////////////
//   int islike = 0;
  // Map<String, int>? likes;

  // List<int> IsLiked = [];
  // List<int> Islike = [];

  // Future<void> getLike(String? postId) async {
  //   await FirebaseFirestore.instance
  //       .collection('Posts')
  //       .doc(postId)
  //       .collection('Like')
  //       .doc(userModel!.uId)
  //       .get()
  //       .then((value) {
  //     // isLike;
  //     emit(SocialLikePostSuccessStates());
  //   });
  // }

  // void likeUnlikePost(String? postId) {
  //   getLike(postId).then((value) {
  //     Like.contains(userModel!.uId)
  //         ? likePost(postId!, isClick)
  //         : unlikePost(postId!);
  //   });
  // }

  // void isLike(index, String postId) {
  //   // for (int i = 0; i < Islike.length;) {
  //   //   if (i == index)
  //   //     Islike[i] = true;
  //   //   else
  //   //     Islike[i] = false;
  //   // }
  //
  //   Like = index;
  //   emit(isLikeState());
  // }

  // bool isClick = false;
  void likePost(
    String? postId,
  ) {
    emit(SocialLikePostLoadingStates());
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Like')
        .doc(userModel!.uId)
        .set({
      'uId': userModel!.uId,
      'Like': true,
    }).then((value) {
      mylikedpostslist.add(postId!);
      emit(SocialLikePostSuccessStates());

      getSinglePost(postId);
    }).catchError((error) {
      error.toString();
      emit(SocialLikePostErrorStates(error.toString()));
    });
  }

  // Widget? onPressed(
  //   String? postId,
  // ) {
  //   if (isClick == false) {
  //     likePost(postId, isClick);
  //     // Like = index;
  //     emit(isLikeState());
  //   } else {
  //     likePost(postId, isClick);
  //     // Like = index;
  //     emit(isLikeState());
  //   }
  //   isClick = !isClick;
  // }

  void unlikePost(String postId) {
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('Like')
        .doc('${userModel!.uId}')
        .delete()
        .then((value) {
      mylikedpostslist.remove(postId);
      emit(SocialLikePostSuccessStates());

      getSinglePost(postId);
    }).catchError((error) {
      emit(SocialLikePostErrorStates(error));
    });
  }
  ///////////////////////////////////////////////////
  // void getLike(String postId){
  //   FirebaseFirestore.instance
  //       .collection('Posts')
  //       .doc(postId)
  //       .collection('Like')
  //       .get().then((value) {
  //         value.docs.forEach((element) { })
  //   })
  // }

//////////////////////////////////
  //comment
  File? commentImage;
  Future<void> getCommentImage() async {
    final PickerComment =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickerComment != null) {
      commentImage = File(PickerComment.path);
      emit(SocialPostImagePickedSuccessStates());
    } else {
      print('No images selected');
      emit(SocialPostImagePickedErrorStates());
    }
  }
///////////////////////////

  void uploadCommentImage({
    required String dateTime,
    required String text,
    required String uId,
    required String name,
    String? postId,
  }) {
    // emit(SocialCreatePostLoadingStates());
    firebase_storage.FirebaseStorage.instance
        //go in the storage
        .ref()
        //how move in storage and get last path to save it
        .child(Uri.file(commentImage!.path).pathSegments.last)
        //start upload
        .putFile(commentImage!)
        .then((value) {
      //take link
      value.ref.getDownloadURL().then((value) {
        writeComment(
            name: name,
            userid: uId,
            dateTime: dateTime,
            text: text,
            postId: postId!,
            imageComment: value);
      }).catchError((error) {
        emit(SocialUploadCommentImageErrorStates());
      });
    }).catchError((error) {
      emit(SocialUploadCommentImageErrorStates());
    });
  }

  CommentModel? commentModel;

  void writeComment({
    required String userid,
    required String name,
    required String dateTime,
    required String text,
    String? imageComment,
    required String postId,
  }) {
    CommentModel model = CommentModel(
      name: name,
      userid: userid,
      image: userModel!.image,
      imageComment: imageComment,
      dateTime: dateTime,
      textComment: text,
      postId: postId,
    );

    //   FirebaseFirestore.instance
    //       .collection('Posts')
    //       .doc(userid)
    //       .collection('comments')
    //       .doc(userModel!.uId)
    //       .set(model.toMap())
    //       .then((value) {
    //     getPost();
    //     getSinglePost(userid);
    //     emit(WriteCommentSuccessState());
    //   }).catchError((error) {
    //     emit(WriteCommentErrorState());
    //   });
    // }

    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('Posts')
          .doc(postId)
          .collection('comments')
          .doc(value.id)
          .update({'commentId': value.id})
          .then((e) {})
          .catchError(onError);
      getSinglePost(postId);

      emit(WriteCommentSuccessState());
    }).catchError((error) {
      emit(WriteCommentErrorState());
    });
  }

  void deletesinglecomment(String postId, String commentId) {
    emit(SocialdeleteCommentLoadingState());
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .delete()
        .then((_) {
      emit(SocialdeleteCommentSuccessState());

      getComment(postId: postId);
      getSinglePost(postId);
    }).catchError((e) {
      print(e.toString());
      emit(SocialdeleteCommentErrorState());
    });
  }

  List<CommentModel> commentsModel = [];
  List<String> postComments = [];
  List<int> commentsNumber = [];

  void getComment({String? postId}) {
    emit(GetCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('Posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      commentsModel = [];

      event.docs.forEach((element) {
        commentsModel.add(CommentModel.fromJson(element.data()));
        // postComments.add(element.id);
      });
      emit(GetCommentsSuccessState());
    });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    emit(SocialSendMessageLoadingStates());
    ChatModel chatModel = ChatModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
    );
    // my message
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .collection('Chats')
        .doc(receiverId.toString())
        .collection('message')
        .add(chatModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessStates());
    }).catchError((error) {
      emit(SocialSendMessageErrorStates(error));
    });
    // receiver message
    FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverId.toString())
        .collection('Chats')
        .doc(userModel!.uId)
        .collection('message')
        .add(chatModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessStates());
    }).catchError((error) {
      emit(SocialSendMessageErrorStates(error));
    });
  }

  List<ChatModel> message = [];
  void getMessage({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel!.uId)
        .collection('Chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        //event:come message
        .listen((event) {
      message = [];
      event.docs.forEach((element) {
        message.add(ChatModel.fromJson(element.data()));
        //element.data():item
      });
      emit(SocialGetMessageSuccessStates());
    });
  }

  bool islike = false;

  void changebutonfriend(bool isShow) {
    // isShow = islike;
    isShow = !isShow;

    emit(SocialclickState());
  }

  void Friends() {}
}
