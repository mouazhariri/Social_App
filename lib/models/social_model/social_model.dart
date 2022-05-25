import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appp/models/social_model/Post_model.dart';

class SocialUserModel {
  String? name;
  String? phone;
  String? email;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;
  // List<PostModel>? uPost = [];

  SocialUserModel({
    this.name,
    this.phone,
    this.email,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified,
    // this.uPost,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
      // 'uPost': uPost?.map((e) => e.toString()).toList(),
    };
  }
}
