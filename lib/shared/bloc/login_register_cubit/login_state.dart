import 'package:newnew/model/user_auth_model/forget_password_model.dart';
import 'package:newnew/model/user_auth_model/register_model.dart';
import 'package:newnew/model/user_auth_model/reset_password_model.dart';
import 'package:newnew/model/user_auth_model/user_model.dart';
import 'package:newnew/model/user_auth_model/verify_code_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}
class ChangePasswordState extends LoginState {}
class LoginLoadingState extends LoginState {}
class LoginSuccessState extends LoginState {
  late final UserDataModel userDataModel;
  LoginSuccessState(this.userDataModel);
}
class LoginErrorState extends LoginState {}

class SignupLoadingState extends LoginState {}
class SignupSuccessState extends LoginState {
  late final RegisterDataModel registerDataModel;
  SignupSuccessState(this.registerDataModel);
}
class SignupErrorState extends LoginState {}

class ForgetPasswordLoadingState extends LoginState {}
class ForgetPasswordSuccessState extends LoginState {
   late final ForgetPasswordDataModel forgetPasswordDataModel;
   ForgetPasswordSuccessState(this.forgetPasswordDataModel);
}
class ForgetPasswordErrorState extends LoginState {}

class VerifyCodeLoadingState extends LoginState {}
class VerifyCodeSuccessState extends LoginState {
  late final VerifyCodeDataModel verifyCodeDataModel;
  VerifyCodeSuccessState(this.verifyCodeDataModel);
}
class VerifyCodeErrorState extends LoginState {}


class ResetPasswordLoadingState extends LoginState {}
class ResetPasswordSuccessState extends LoginState {
  late final ResetPasswordDataModel resetPasswordDataModel;
  ResetPasswordSuccessState(this.resetPasswordDataModel);
}
class ResetPasswordErrorState extends LoginState {}

// google signIn
class GoogleSignInLoadingState extends LoginState {}
class GoogleSignInSuccessState extends LoginState {}
class GoogleSignInErrorState extends LoginState {}