
import '../../../models/LoginModel.dart';
abstract class ResetPasswordStates {}

class ResetPasswordInitialState extends ResetPasswordStates {}



class ForgetPasswordLoadingState extends ResetPasswordStates {}

class ForgetPasswordSuccessState extends ResetPasswordStates {}

class ForgetPasswordErrorState extends ResetPasswordStates {
  final String error;
  ForgetPasswordErrorState(this.error);
}


class VerifyOTPLoadingState extends ResetPasswordStates {}

class VerifyOTPSuccessState extends ResetPasswordStates {
  String message;
  VerifyOTPSuccessState(this.message);
}

class VerifyOTPErrorState extends ResetPasswordStates {
  final String error;
  VerifyOTPErrorState(this.error);
}

class ChangeTextSuccessState extends ResetPasswordStates {}

class ResetPasswordLoadingState extends ResetPasswordStates {}

class ResetPasswordSuccessState extends ResetPasswordStates {
  String? message;
  ResetPasswordSuccessState(this.message);

}

class ResetPasswordErrorState extends ResetPasswordStates {
  final String error;
  ResetPasswordErrorState(this.error);
}

class ChangePasswordVisibilityState extends ResetPasswordStates {}
