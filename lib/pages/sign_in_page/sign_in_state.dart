abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {
  bool isLoading;

  SignInLoading({this.isLoading = false});
}

class SignInError extends SignInState {
  dynamic error;

  SignInError({this.error});
}
