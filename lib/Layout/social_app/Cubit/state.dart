import 'package:flutter_appp/models/social_model/social_model.dart';

abstract class SocialState {}

class SocialInitialStates extends SocialState {}

class SocialChangeNavBarStates extends SocialState {}

class SocialLoadingHomeStates extends SocialState {}

class SocialSuccessHomeStates extends SocialState {}

class SocialErrorHomeStates extends SocialState {
  final String error;

  SocialErrorHomeStates(this.error);
}

class SocialAddPostStates extends SocialState {}
