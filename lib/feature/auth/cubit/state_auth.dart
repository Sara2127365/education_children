import 'package:education_children/feature/auth/login/model/login_response.dart';
import 'package:education_children/feature/auth/signup/model/sign_up_response_model.dart';

abstract class AuthState {}

class InitialState extends AuthState {}

// ========================
// Sign Up States
// ========================
class LoadingSignUpState extends AuthState {}

class SuccessSignUpState extends AuthState {
  final String message;
  final SignupResponseModel? response;

  SuccessSignUpState({required this.message, this.response});
}

class ErrorSignUpState extends AuthState {
  final String message;

  ErrorSignUpState({required this.message});
}

// ========================
// Sign In / Login States
// ========================
class LoadingSignInState extends AuthState {}

class SuccessSignInState extends AuthState {
  final String message;
  final LoginResponseModel? response;

  SuccessSignInState({required this.message, this.response});
}

class ErrorSignInState extends AuthState {
  final String message;

  ErrorSignInState({required this.message});
}
