abstract class socialLoginStates {}

class socialLoginInitialStats extends socialLoginStates {}

class socialLoginSuccessStats extends socialLoginStates {
  final String uId;

  socialLoginSuccessStats(this.uId);
}

class socialLoginLoadingStats extends socialLoginStates {}

class socialLoginErrorStats extends socialLoginStates {
  final String error;

  socialLoginErrorStats(this.error);
}

class socialLoginPasswordStats extends socialLoginStates {}
