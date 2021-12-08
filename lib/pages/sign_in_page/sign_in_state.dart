abstract class SignInState {}

class SignInInitial extends SignInState {

}

class SignInLoading extends SignInState {
  bool isLoading;

  SignInLoading({this.isLoading = true});
}

class SignInLoaded extends SignInState {
  bool isLoading;

  dynamic error;

  SignInLoaded({
    this.isLoading = false,
    this.error,
  });
}

class SignInError extends SignInState {
  dynamic error;

  SignInError({this.error});
}
