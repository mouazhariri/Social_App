import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_appp/models/social_model/comment_model.dart';

class PostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  // String? time;
  String? text;
  String? PostImage;
  // List<String>? Like = [];
  // String? postID;
  // List<CommentModel> comments = [];

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    // this.time,
    this.text,
    this.PostImage,
    // this.Like,
    // this.postID
    // required this.comments,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    // time = json['time'];
    text = json['text'];
    PostImage = json['PostImage'];
    // Like = (json['Like'] != null ? List<String>.from(json['Like']) : null)!;
    // postID = json['postID'];

    // json['postComments'].forEach((v) {
    // if (v != null) comments.add(CommentModel.fromJson(v));
    // });
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      // 'time': Timestamp.now(),
      'text': text,
      'PostImage': PostImage,
      // 'postID': postID,
      // 'Like': Like.map((e) => e.toString()).toList(),
      // 'comments': comments.map((e) => e.toString()).toList(),
    };
  }
}

class LikesModel {
  String? uId;
  bool? Like;
  LikesModel({
    this.uId,
    this.Like,
  });

  LikesModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    Like = json['Like'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'Like': Like,
    };
  }
}
