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

class ResetPasswordCubit extends Cubit<ResetPasswordStates> {
  ResetPasswordCubit() : super(ResetPasswordInitialState());
  static ResetPasswordCubit get(context) => BlocProvider.of(context);

  void forgetPassword({
    required String email,
  }) {
    emit(ForgetPasswordLoadingState());

    DioHelper.postData(
        url: FORGET_PASSWORD,
        data: {
          'email': email,
        }).then((value) {
      showToast(state: ToastStates.SUCCESS,text: value.data!['message']);
      emit(ForgetPasswordSuccessState());
    })
        .catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      if(error is DioError)
      {
        showToast(state: ToastStates.ERROR,text: error.response!.data!['message']);
      }
      emit(ForgetPasswordErrorState(error.toString()));
    });
  }


  String? codeText;
  void currentText(value){
    codeText=value;
    emit(ChangeTextSuccessState());
  }

  void verifyOTP({
    required String email,
     String? otp,
  }) {
    emit(VerifyOTPLoadingState());

    DioHelper.postData(
        url: VERIFY,
        data: {
          'email': email,
          'otp': otp,
        }).then((value) {
      emit(VerifyOTPSuccessState(value.data['type']));
      showToast(state: ToastStates.SUCCESS,text: value.data!['message']);


    })
        .catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      if(error is DioError)
      {
        showToast(state: ToastStates.ERROR,text: error.response!.data!['message']);
      }
      emit(VerifyOTPErrorState(error.toString()));
    });
  }


  IconData suffix2 = Icons.visibility_off_outlined;
  bool isPassword2 = true;
  void changePasswordVisibility2() {
    isPassword2 = !isPassword2;
    suffix2 =
    isPassword2 ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangePasswordVisibilityState());
  }




  void resetPassword({
     String? email,
    String? otp,
    String? password,
  }) {
    emit(ResetPasswordLoadingState());

    DioHelper.postData(
        url: VERIFY,
        data: {
          'email': email,
          'otp': otp,
          'password': password,
        }).then((value) {
      emit(ResetPasswordSuccessState(value.data['type']));


    })
        .catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      if(error is DioError)
      {
        showToast(state: ToastStates.ERROR,text: error.response!.data!['message']);
      }
      emit(ResetPasswordErrorState(error.toString()));
    });
  }




}
