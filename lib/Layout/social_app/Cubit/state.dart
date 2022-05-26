import 'package:flutter_appp/models/social_model/social_model.dart';

abstract class SocialState {}

class SocialInitialStates extends SocialState {}

class SocialChangeNavBarStates extends SocialState {}

class UpdateUserLoadingState extends SocialState {}

class UpdateUserSuccessState extends SocialState {}

class UpdateUserErrorState extends SocialState {}

class SocialLoadingHomeStates extends SocialState {}

class SocialSuccessHomeStates extends SocialState {}

class SocialErrorHomeStates extends SocialState {
  final String error;

  SocialErrorHomeStates(this.error);
}

class SocialGetAllUsersSuccessStates extends SocialState {}

class SocialGetAllUsersLoadingStates extends SocialState {}

class SocialGetAllUsersErrorStates extends SocialState {
  final String error;

  SocialGetAllUsersErrorStates(this.error);
}

class GetUserPostSuccessState extends SocialState {}

class GetSinglePostSuccessState extends SocialState {}

class GetSinglePostErrorState extends SocialState {}

class SocialGetPostLoadingStates extends SocialState {}

class SocialgetlikesNumberSuccessState extends SocialState {}

class SocialGetPostSuccessStates extends SocialState {}

class SocialGetPostErrorStates extends SocialState {
  final String error;

  SocialGetPostErrorStates(this.error);
}

class GetLikedUsersLoadingState extends SocialState {}

class GetLikedUsersSuccessState extends SocialState {}

class SocialLikePostSuccessStates extends SocialState {}

class SocialLikePostLoadingStates extends SocialState {}

class SocialLikePostErrorStates extends SocialState {
  final String error;

  SocialLikePostErrorStates(this.error);
}

class UnlikePostSuccessState extends SocialState {}

class UnlikePostErrorState extends SocialState {}

class SocialAddPostStates extends SocialState {}

//
class SocialProfileImagePickedSuccessStates extends SocialState {}

class SocialProfileImagePickedLoadingStates extends SocialState {}

class SocialProfileImagePickedErrorStates extends SocialState {}

//
class SocialCoverImagePickedSuccessStates extends SocialState {}

class SocialCoverImagePickedErrorStates extends SocialState {}

//
class SocialUploadProfileImageSuccessStates extends SocialState {}

class SocialUploadProfileImageErrorStates extends SocialState {}

//
class SocialUploadCoverImagePickedSuccessStates extends SocialState {}

class SocialUploadCoverImagePickedErrorStates extends SocialState {}

//
class SocialUpdateUserErrorStates extends SocialState {}

class SocialUserCreateLoadingStats extends SocialState {}

//post
class SocialCreatePostSuccessStates extends SocialState {}

class SocialCreatePostLoadingStates extends SocialState {}

class SocialCreatePostErrorStates extends SocialState {}

class SocialPostImagePickedSuccessStates extends SocialState {}

class SocialPostImagePickedErrorStates extends SocialState {}

class SocialRemoveImageStates extends SocialState {}

class SocialRemoveCommentImageStates extends SocialState {}

//chat
class SocialSendMessageSuccessStates extends SocialState {}

class SocialSendMessageLoadingStates extends SocialState {}

class SocialSendMessageErrorStates extends SocialState {
  final String error;

  SocialSendMessageErrorStates(this.error);
}

class SocialGetMessageSuccessStates extends SocialState {}

class WriteCommentSuccessState extends SocialState {}

class WriteCommentErrorState extends SocialState {}

class GetCommentsSuccessState extends SocialState {}

class GetCommentsLoadingState extends SocialState {}

class SocialdeleteCommentLoadingState extends SocialState {}

class SocialdeleteCommentSuccessState extends SocialState {}

class SocialdeleteCommentErrorState extends SocialState {}

class SocialUploadCommentImageErrorStates extends SocialState {}

class SocialUploadCommentImageSuccessStates extends SocialState {}

class DeletePostSuccessState extends SocialState {}

class SocialDeletePostLoadingState extends SocialState {}

class SocialDeletePostErrorState extends SocialState {}

class isLikeState extends SocialState {}

class SocialGetsinglePostSuccess extends SocialState {}

class SocialGetsinglePostError extends SocialState {}

class SocialGetSinglepostLikesSuccess extends SocialState {}

class SocialGetSinglepostCommentsSuccess extends SocialState {}

class SocialGetsinglePostLoading extends SocialState {}

class SocialChangeBottomSheetState extends SocialState {}

class SocialclickState extends SocialState {}
