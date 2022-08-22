
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:odc/modules/authintication/auth_screen.dart';
import 'package:odc/modules/reset_password/verify_otp_screen.dart';
import 'package:odc/shared/components/components.dart';

import '../../shared/styles/icon_broken.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ResetPasswordScreen extends StatelessWidget {
   ResetPasswordScreen({
    Key? key,
    this.email,
    this.otp
  }) : super(key: key);
  String? email;
  String? otp;

  @override
  Widget build(BuildContext context) {
    var passwordController=TextEditingController();
    var passwordController2=TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
        listener: (context, states) {
          if(states is ResetPasswordSuccessState)
            {
              if(states.message=='Success') {
                showToast(state: ToastStates.SUCCESS,text: 'Password Changed Successfully');
                navigateAndFinish(context, const AuthScreen());
              }
            }
        },
        builder: (context, states) {
          var cubit = ResetPasswordCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              title: const Text('Reset Password'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      const Text('Enter New Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),),
                      const SizedBox(
                        height: 20,
                      ),

                      defaultFormField(
                        function: () {
                          ResetPasswordCubit.get(context)
                              .changePasswordVisibility2();
                        },
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: "Password",
                        validator: (value){
                          RegExp regEx = RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");
                          if(value.isEmpty)
                          {
                            return "Password must not be empty";
                          }
                          if(value!=passwordController2.text)
                          {
                            return "Password must be same";
                          }
                          else if(value.length<8)
                          {
                            return 'Should be more than 8 Characters';
                          }
                          else if (!value.toString().contains(regEx)) {
                            return 'Use Numbers and Capital and Small Characters at least 1';
                          } else {
                            return null;
                          }
                        },
                        prefixIcon: IconBroken.Unlock,
                        isPassword: cubit.isPassword2,
                        suffixIcon: cubit.suffix2,
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      defaultFormField(
                        function: () {
                          ResetPasswordCubit.get(context)
                              .changePasswordVisibility2();
                        },
                        controller: passwordController2,
                        type: TextInputType.visiblePassword,
                        label: "Confirm Password",
                        validator: (value){
                          RegExp regEx = RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");
                          if(value.isEmpty)
                          {
                            return "Password must not be empty";
                          }
                          else if(value!=passwordController.text)
                          {
                            return "Password must be same";
                          }
                          else if(value.length<8)
                          {
                            return 'Should be more than 8 Characters';
                          }
                          else if (!value.toString().contains(regEx)) {
                            return 'Use Numbers and Capital and Small Characters at least 1';
                          } else {
                            return null;
                          }
                        },
                        prefixIcon: IconBroken.Unlock,
                        isPassword: cubit.isPassword2,
                        suffixIcon: cubit.suffix2,
                      ),


                      const SizedBox(height: 20,),
                      Conditional.single(
                        context: context,
                        conditionBuilder: (BuildContext context) =>
                        states is !ResetPasswordLoadingState,
                        widgetBuilder: (BuildContext context) =>
                            defaultButton(text: 'Confirm', function: (){
                              if (formKey.currentState!.validate()) {
                                cubit.resetPassword(
                                  otp: otp,
                                  email: email,
                                  password: passwordController2.text,
                                );
                              }
                            },radius: 8),
                        fallbackBuilder: (BuildContext context) =>
                        const Center(child: CircularProgressIndicator()),
                      ),



                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

  }
}
