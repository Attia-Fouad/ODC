
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odc/modules/reset_password/verify_otp_screen.dart';
import 'package:odc/shared/components/components.dart';

import '../../shared/styles/icon_broken.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
        listener: (context, states) {
          if(states is ForgetPasswordSuccessState)
            {
              navigateTo(context, VerifyOTPScreen(email: emailController.text,));
            }
        },
        builder: (context, states) {
          var cubit = ResetPasswordCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              title: const Text('Forget Password'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      const Text('Enter Your Email',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),),
                      const SizedBox(height: 15,),
                      defaultFormField(
                        controller: emailController,
                        label: 'Email Address',
                        prefixIcon: IconBroken.Message,
                        type: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'email must be not empty';
                          }else if (!value.toString().contains('@') ||
                              !value.toString().contains('.com')) {
                            return 'ex: example@mail.com';
                          } else {
                            return null;
                          }

                        },
                      ),
                      const SizedBox(height: 20,),
                      defaultButton(text: 'Submit', function: (){
                        if (formKey.currentState!.validate()) {
                          cubit.forgetPassword(email: emailController.text);

                        }
                      },radius: 8),


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
