
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:odc/modules/reset_password/reset_password_screen.dart';
import 'package:odc/shared/components/components.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../shared/styles/icon_broken.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class VerifyOTPScreen extends StatelessWidget {
   VerifyOTPScreen({Key? key,required this.email}) : super(key: key);
  String email;

  @override
  Widget build(BuildContext context) {
    var codeController=TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
        listener: (context, states) {
          if(states is VerifyOTPSuccessState)
            {
              if(states.message=='Success')
                {
                  navigateTo(context, ResetPasswordScreen(email: email,otp: ResetPasswordCubit.get(context).codeText,));
                }

            }
        },
        builder: (context, states) {
          var cubit = ResetPasswordCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              title: const Text('Verify Code'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Text('Enter Your Code',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),),
                    const SizedBox(height: 20,),
                    PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 55,
                        fieldWidth: 50,
                        activeFillColor:HexColor('#1ABC00'),
                        inactiveFillColor: Colors.white,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      controller: codeController,
                      onCompleted: (v) {
                        print("Completed");
                        cubit.verifyOTP(email: email, otp: v);
                        print(v);
                      },
                      onChanged: (value) {
                        print(value);
                       cubit.currentText(value);
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        return true;
                      }, appContext: context,
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

  }
}
