
import '../../../models/LoginModel.dart';
abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends AuthStates {
  final String error;
  LoginErrorState(this.error);
}

class LoginChangePasswordVisibilityState extends AuthStates {}

class SignUpChangePasswordVisibilityState extends AuthStates {}


class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {
  final LoginModel loginModel;
  RegisterSuccessState(this.loginModel);
}

class RegisterErrorState extends AuthStates {
  final String error;

  RegisterErrorState(this.error);
}


class RegisterByGoogleLoadingState extends AuthStates {}

class RegisterByGoogleSuccessState extends AuthStates {
  final LoginModel loginModel;
  RegisterByGoogleSuccessState(this.loginModel);
}

class RegisterByGoogleErrorState extends AuthStates {
  final String error;

  RegisterByGoogleErrorState(this.error);
}


class RegisterIsChecked extends AuthStates {}
class LoginIsChecked extends AuthStates {}


