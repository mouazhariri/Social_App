class CommentModel {
  String? name;
  String? imageComment;
  String? image;
  String? textComment;
  String? commentId;
  String? postId;
  String? userid;
  String? dateTime;

  CommentModel(
      {this.image,
      this.name,
      this.imageComment,
      this.textComment,
      this.commentId,
      this.postId,
      this.userid,
      this.dateTime});

  CommentModel.fromJson(Map<String, dynamic> json) {
    imageComment = json['imageComment'];
    image = json['image'];
    name = json['name'];
    textComment = json['textComment'];
    commentId = json['commentId'];
    postId = json['postId'];
    userid = json['userid'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'imageComment': imageComment,
      'textComment': textComment,
      'commentId': commentId,
      'postId': postId,
      'userid': userid,
      'dateTime': dateTime,
    };
  }
}
