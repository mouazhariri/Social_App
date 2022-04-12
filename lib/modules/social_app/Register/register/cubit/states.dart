abstract class socialRegisterStates {}

class socialRegisterInitialStats extends socialRegisterStates {}

class socialRegisterSuccessStats extends socialRegisterStates {}

class socialRegisterLoadingStats extends socialRegisterStates {}

class socialRegisterErrorStats extends socialRegisterStates {
  final String error;

  socialRegisterErrorStats(this.error);
}

class socialRegisterPasswordStats extends socialRegisterStates {}

class SocialUserCreateSuccessStats extends socialRegisterStates {}

class SocialUserCreateLoadingStats extends socialRegisterStates {}

class SocialUserCreateErrorStats extends socialRegisterStates {
  final String error;

  SocialUserCreateErrorStats(this.error);
}
