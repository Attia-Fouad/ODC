import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:odc/models/LoginModel.dart';
import 'package:odc/shared/components/components.dart';
import '../../../shared/networks/end_points.dart';
import '../../../shared/networks/remote/dio_helper.dart';
import 'states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);
  late LoginModel loginModel;

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(LoginChangePasswordVisibilityState());
  }


  IconData suffix2 = Icons.visibility_off_outlined;
  bool isPassword2 = true;
  void changePasswordVisibility2() {
    isPassword2 = !isPassword2;
    suffix2 =
    isPassword2 ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(SignUpChangePasswordVisibilityState());
  }


  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data: {
          'email': email,
          'password': password,
        }).then((value) {
      if (kDebugMode) {
        print(value.data);
      }
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel));
    })
        .catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      if(error is DioError)
        {
          showToast(state: ToastStates.ERROR,text: error.response!.data!['message']);
        }
      emit(LoginErrorState(error.toString()));
    });
  }



  void userRegister({
    required String email,
    required String password,
    required String firstName,
    required String lastName,

  }) {
    emit(RegisterLoadingState());

    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    }).then((value) {

      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error) {
      if(error is DioError)
      {
        showToast(state: ToastStates.ERROR,text: error.response!.data!['message'].toString());
      }

      if (kDebugMode) {
        print(error.toString());
      }
      emit(RegisterErrorState(error.toString()));
    });
  }


  bool loginIsChecked=false;
  bool registerIsChecked=false;

  void loginRememberMe(value)
  {
    loginIsChecked=value;
    emit(LoginIsChecked());
  }
  void registerRememberMe(value)
  {
    registerIsChecked=value;
    emit(RegisterIsChecked());
  }


  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  Future<void> signUpWithGoogle()async{
    try{
      GoogleSignInAccount? googleSignInAccount= await googleSignIn.signIn();
      userRegisterByGoogle(
        firstName: googleSignInAccount?.displayName,
        lastName:googleSignInAccount?.displayName ,
        email:googleSignInAccount!.email ,
        id: googleSignInAccount.id,
      );

    }
    catch(error)
    {
      print(error.toString());
    }



  }


  void userRegisterByGoogle({
    required String email,
    required String id,
     String? firstName,
     String? lastName,
     String picture='https://res.cloudinary.com/lms07/image/upload/v1645954589/avatar/6214b94ad832b0549b436264_avatar1645954588291.png',

  }) {
    emit(RegisterByGoogleLoadingState());

    DioHelper.postData(url: REGISTER_GOOGLE, data: {
      'email': email,
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'picture': picture,
    }).then((value) {

      loginModel = LoginModel.fromJson(value.data);
      emit(RegisterByGoogleSuccessState(loginModel));
    }).catchError((error) {
      if(error is DioError)
      {
        showToast(state: ToastStates.ERROR,text: error.response!.data!['message'].toString());
      }

      if (kDebugMode) {
        print(error.toString());
      }
      emit(RegisterByGoogleErrorState(error.toString()));
    });
  }











}
